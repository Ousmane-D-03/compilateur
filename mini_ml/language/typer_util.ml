open Ast

exception Constraint_error of type_lang * type_lang
exception Typing_error of Util.Position.t * string

module Counter = struct
  type t = int ref

  let create () = ref 0

  let get_fresh counter =
    let res = !counter in
    counter := !counter + 1;
    res
end

let type_of_built_in = function
  | Add | Sub | Mul | Div | Mod -> 
      TFunc([], TInt, TFunc([], TInt, TInt))
  | UMin -> 
      TFunc([], TInt, TInt)
  | And | Or -> 
      TFunc([], TBool, TFunc([], TBool, TBool))
  | Not -> 
      TFunc([], TBool, TBool)
  | Eq | Neq | Lt | Leq | Gt | Geq -> 
      let a = TUniv(0) in
      TFunc([0], a, TFunc([], a, TBool))
  | Print ->
      let a = TUniv(0) in 
      TFunc([0], a, TUnit)
  | Concat ->
      TFunc([], TString, TFunc([], TString, TString))
  | Cat ->
      let a = TUniv(0) in
      TFunc([0], a, TFunc([], TList([], a), TList([], a)))
  | Head | Tail ->
      let a = TUniv(0) in 
      TFunc([0], TList([], a), a)
  | Append ->
      let a = TUniv(0) in
      TFunc([0], TList([], a), TFunc([], TList([], a), TList([], a)))

let rec solve_constraints = function
  | [] -> []
  | (t1, t2) :: rest ->
      try
        let subst = Type_system.unify t1 t2 in
        let rest' = List.map (fun (t1, t2) ->
          (Type_system.apply_subst_in_type subst t1,
           Type_system.apply_subst_in_type subst t2)) rest in
        subst @ solve_constraints rest'
      with Failure _ -> raise (Constraint_error(t1, t2))

let instantiate counter type_lang =
  let fresh_var () = TUniv(Counter.get_fresh counter) in
  match type_lang with
  | TFunc(generics, arg, res) ->
      let subst = List.map (fun g -> (g, fresh_var ())) generics in
      TFunc([], 
            Type_system.apply_subst_in_type subst arg,
            Type_system.apply_subst_in_type subst res)
  | TList(generics, t) ->
      let subst = List.map (fun g -> (g, fresh_var ())) generics in
      TList([], Type_system.apply_subst_in_type subst t)
  | t -> t
