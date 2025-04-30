open Ast
open Typer_util
let rec type_expr counter env = function
  | Cst_i (_, ann) -> 
      Annotation.set_type ann TInt;
      (TInt, [])
  
  | App (e1, e2, ann) ->
      let t1, c1 = type_expr counter env e1 in
      let t2, c2 = type_expr counter env e2 in
      let fresh = TUniv (Counter.get_fresh counter) in
      Annotation.set_type ann fresh;
      (fresh, (t1, TFunc([], t2, fresh)) :: c1 @ c2)
  
  | Let (rec_flag, x, e1, e2, ann) ->
      let t1, c1 = 
        if rec_flag then
          let t_var = TUniv (Counter.get_fresh counter) in
          let env' = Util.Environment.add env x t_var in
          let t, c = type_expr counter env' e1 in
          (t, (t_var, t) :: c)
        else type_expr counter env e1
      in
      let env' = Util.Environment.add env x t1 in
      let t2, c2 = type_expr counter env' e2 in
      Util.Environment.remove env x;
      (t2, c1 @ c2)
  
  | Fun (x, e, ann) ->
      let t_arg = TUniv (Counter.get_fresh counter) in
      let env' = Util.Environment.add env x t_arg in
      let t_body, c = type_expr counter env' e in
      let t_func = TFunc([], t_arg, t_body) in
      Annotation.set_type ann t_func;
      (t_func, c)
