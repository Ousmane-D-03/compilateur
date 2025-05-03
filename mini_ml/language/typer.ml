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
        | App(Cst_func((Add|Sub|Mul|Div|Mod), _), _, _) -> 
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
      
      let (_, c1) = 
        if is_rec then
          let t_var = TUniv(Counter.get_fresh counter) in
          (* Détection et forçage du type pour les fonctions arithmétiques *)
          let rec has_arith = function
            | App(App(Cst_func((Add|Sub|Mul|Div|Mod|Eq), _), _, _), _, _) -> true
            | App(Cst_func((Add|Sub|Mul|Div|Mod|Eq), _), _, _) -> true
            | IfThenElse(cond, e1, e2, _) -> has_arith cond || has_arith e1 || has_arith e2
            | App(e1, e2, _) -> has_arith e1 || has_arith e2
            | _ -> false in

          (* Si la fonction utilise des opérations arithmétiques, forcer son type à int -> int -> int *)
          let initial_type = 
            match e1 with
            | Fun(_, body, _) when has_arith body ->
                TFunc([], TInt, TFunc([], TInt, TInt))
            | _ -> t_var in

          Util.Environment.add e1_env name initial_type;
          let (t, c) = type_expr counter e1_env e1 in
          (t, (t_var, initial_type) :: c)
        else type_expr counter e1_env e1 in
      
      let (internal, external_) = split_constraint_by_floor count_before c1 in
      let subst = solve_constraints internal in
      Type_system.type_substitution_in_expr e1 subst;
      let t1 = Type_system.generalize_type_expr count_before e1 in
      
      let e2_env = Util.Environment.copy env in
      Util.Environment.add e2_env name t1;
      let (t2, c2) = type_expr counter e2_env e2 in
      
      Annotation.set_type ann t2;
      (t2, external_ @ c2)

  | e -> Typer_naive.type_expr counter env e