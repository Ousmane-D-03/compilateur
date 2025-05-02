open Type_system
open Ast
open Typer_util

(* Extracts type variables from a type *)
let rec get_type_vars t =
  match t with
  | TUniv v -> [v]
  | TFunc(vars, t1, t2) -> vars @ (get_type_vars t1) @ (get_type_vars t2)
  | _ -> []

let type_generics count_before t =
  (* Define the type_generics function logic here *)
  (* Placeholder implementation: Replace with actual logic *)
  []

let rec type_expr (counter : Counter.t) (env : type_lang Util.Environment.t)
    (expr : expr) =
  match expr with
  | App(e1, e2, ann) ->
      let (t1, c1) = type_expr counter env e1 in
      let (t2, c2) = type_expr counter env e2 in
      let t1' = instantiate counter t1 in
      let t2' = instantiate counter t2 in
      let t_res = TUniv(Counter.get_fresh counter) in
      let constraints = (t1', TFunc([], t2', t_res)) :: (c1 @ c2) in
      Annotation.set_type ann t_res;
      (t_res, constraints)

  | Let(rec_flag, x, e1, e2, ann) ->
      let count_before = Counter.get_fresh counter in
      let (t1, c1) = 
        if rec_flag then
          let t_var = TUniv(Counter.get_fresh counter) in
          Util.Environment.add env x t_var;
          let (t, c) = type_expr counter env e1 in
          (t, (t_var, t) :: c)
        else type_expr counter env e1 
      in
      let (internal, external_) = split_constraint_by_floor count_before c1 in
      let subst = solve_constraints internal in
      let t1' = apply_subst_in_type subst t1 in
      let vars = get_type_vars t1' in
      let generalized = TFunc(vars, t1', t1') in
      Util.Environment.add env x generalized;
      let (t2, c2) = type_expr counter env e2 in
      Util.Environment.remove env x;
      (t2, external_ @ c2)

  | _ -> Typer_naive.type_expr counter env expr