open Ast
open Typer_util
open Type_system

let rec type_expr (counter : Counter.t) (env : type_lang Util.Environment.t) (expr : expr) =
  match expr with
  | Cst_i (_, ann) -> 
      Annotation.set_type ann TInt;
      (TInt, [])
  
  | Cst_b (_, ann) ->
      Annotation.set_type ann TBool;
      (TBool, [])
      
  | Cst_str (_, ann) ->
      Annotation.set_type ann TString;
      (TString, [])
      
  | Unit (ann) ->
      Annotation.set_type ann TUnit;
      (TUnit, [])
      
  | Nil (ann) ->
      let t = TUniv (Counter.get_fresh counter) in
      let list_type = TList ([], t) in
      Annotation.set_type ann list_type;
      (list_type, [])
      
  | Var (x, ann) ->
      let t = match Util.Environment.get env x with
        | Some t -> t
        | None -> raise (Typing_error (Annotation.get_pos ann, 
                        "Variable " ^ x ^ " not found")) in
      Annotation.set_type ann t;
      (t, [])
      
  | Cst_func (f, ann) ->
      let t = type_of_built_in f in
      Annotation.set_type ann t;
      (t, [])
      
  | Fun (x, e, ann) ->
      let t_arg = TUniv (Counter.get_fresh counter) in
      Util.Environment.add env x t_arg;
      let (t_body, constraints) = type_expr counter env e in
      Util.Environment.remove env x;
      let t_fun = TFunc ([], t_arg, t_body) in
      Annotation.set_type ann t_fun;
      (t_fun, constraints)
      
  | App (e1, e2, ann) ->
      let (t1, c1) = type_expr counter env e1 in
      let (t2, c2) = type_expr counter env e2 in
      let t_res = TUniv (Counter.get_fresh counter) in
      let constraints = (t1, TFunc([], t2, t_res)) :: (c1 @ c2) in
      Annotation.set_type ann t_res;
      (t_res, constraints)
      
  | Let (rec_flag, x, e1, e2, ann) ->
      let (t1, c1) = 
        if rec_flag then
          let t_var = TUniv (Counter.get_fresh counter) in
          Util.Environment.add env x t_var;
          let (t, c) = type_expr counter env e1 in
          (t, (t_var, t) :: c)
        else type_expr counter env e1 
      in
      Util.Environment.add env x t1;
      let (t2, c2) = type_expr counter env e2 in
      Util.Environment.remove env x;
      Annotation.set_type ann t2;
      (t2, c1 @ c2)
      
  | IfThenElse (e1, e2, e3, ann) ->
      let (t1, c1) = type_expr counter env e1 in
      let (t2, c2) = type_expr counter env e2 in
      let (t3, c3) = type_expr counter env e3 in
      let constraints = (t1, TBool) :: (t2, t3) :: (c1 @ c2 @ c3) in
      Annotation.set_type ann t2;
      (t2, constraints)

  | Ignore (e1, e2, ann) ->
      let (_, c1) = type_expr counter env e1 in
      let (t2, c2) = type_expr counter env e2 in
      Annotation.set_type ann t2;
      (t2, c1 @ c2)
