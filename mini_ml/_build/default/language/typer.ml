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
      let (f_type, f_constraints) = type_expr counter env f in
      let (arg_type, arg_constraints) = type_expr counter env arg in
      let ret_type = TUniv(Counter.get_fresh counter) in
      let extra_constraints = match f with
        | App(Cst_func((Add|Sub|Mul|Div|Mod), _), e1, _) -> 
            [(arg_type, TInt); (ret_type, TInt)]
        | Cst_func((Add|Sub|Mul|Div|Mod), _) ->
            [(arg_type, TInt)]
        | _ -> [] in
      let constraints = (f_type, TFunc([], arg_type, ret_type)) :: 
                       (extra_constraints @ f_constraints @ arg_constraints) in
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
          let extra_constraints = match e1 with
            | Fun(_, body, _) ->
                let rec collect_arith_constraints = function
                  | App(App(Cst_func((Add|Sub|Mul|Div|Mod), _), e1, _), e2, _) -> 
                      [(t_var, TInt)]
                  | App(Cst_func((Eq), _), e1, _) -> 
                      [(t_var, TInt)]
                  | App(e1, e2, _) -> 
                      collect_arith_constraints e1 @ collect_arith_constraints e2
                  | _ -> []
                in
                collect_arith_constraints body @ c
            | _ -> c in
          (t, extra_constraints)
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