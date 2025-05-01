open Type_system
open Ast
open Typer_util

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
      (* Création d'une expression temporaire pour la généralisation *)
      let temp_ann = Annotation.create Lexing.(dummy_pos, dummy_pos) in
      let () = Annotation.set_type temp_ann t1' in
      let temp_expr = Unit temp_ann in
      let t1'' = generalize_type_expr count_before temp_expr in
      Util.Environment.add env x t1'';
      let (t2, c2) = type_expr counter env e2 in
      Util.Environment.remove env x;
      (t2, external_ @ c2)

  | _ -> Typer_naive.type_expr counter env expr
