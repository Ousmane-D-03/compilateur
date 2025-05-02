open Type_system
open Ast
open Typer_util

let rec type_expr counter env = function
  | Var(x, ann) -> 
      let t = match Util.Environment.get env x with
        | Some t -> instantiate counter t 
        | None -> raise (Typing_error(Annotation.get_pos ann, "Unbound variable " ^ x)) in
      Annotation.set_type ann t;
      (t, [])
      
  | App(f, arg, ann) ->
      (* Instancier les types avant de générer les contraintes *)
      let (f_type, f_constraints) = type_expr counter env f in
      let (arg_type, arg_constraints) = type_expr counter env arg in
      let f_type = instantiate counter f_type in
      let arg_type = instantiate counter arg_type in
      let ret_type = TUniv(Counter.get_fresh counter) in
      let constraints = (f_type, TFunc([], arg_type, ret_type)) :: 
                       (f_constraints @ arg_constraints) in
      Annotation.set_type ann ret_type;
      (ret_type, constraints)

  | Let(is_rec, name, e1, e2, ann) ->
      let count_before = Counter.get_fresh counter in
      let e1_env = Util.Environment.copy env in
      
      (* Gérer la récursion *)
      let (t1, c1) = 
        if is_rec then
          let t_var = TUniv(Counter.get_fresh counter) in
          Util.Environment.add e1_env name t_var;
          let (t, c) = type_expr counter e1_env e1 in
          (t, (t_var, t) :: c)
        else type_expr counter e1_env e1 in
      
      (* Résoudre les contraintes internes et généraliser *)
      let (internal, external_) = split_constraint_by_floor count_before c1 in
      let subst = solve_constraints internal in
      Type_system.type_substitution_in_expr e1 subst;
      let t1 = Type_system.generalize_type_expr count_before e1 in
      
      (* Environnement pour e2 avec le type généralisé *)
      let e2_env = Util.Environment.copy env in
      Util.Environment.add e2_env name t1;
      let (t2, c2) = type_expr counter e2_env e2 in
      
      Annotation.set_type ann t2;
      (t2, external_ @ c2)

  | e -> Typer_naive.type_expr counter env e