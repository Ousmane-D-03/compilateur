open Type_system
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

let type_of_built_in (built_in : built_in) =
  match built_in with
  | Add -> TFunc ([], TInt, TFunc ([], TInt, TInt))
  | Sub -> TFunc ([], TInt, TFunc ([], TInt, TInt))
  | Mul -> TFunc ([], TInt, TFunc ([], TInt, TInt))
  | Div -> TFunc ([], TInt, TFunc ([], TInt, TInt))
  | Mod -> TFunc ([], TInt, TFunc ([], TInt, TInt))
  | UMin -> TFunc ([], TInt, TInt)
  | And -> TFunc ([], TBool, TFunc ([], TBool, TBool))
  | Or -> TFunc ([], TBool, TFunc ([], TBool, TBool))
  | Not -> TFunc ([], TBool, TBool)
  | Eq -> let t = TUniv (-1) in TFunc ([t], t, TFunc ([], t, TBool))
  | Neq -> let t = TUniv (-1) in TFunc ([t], t, TFunc ([], t, TBool))
  | Lt -> TFunc ([], TInt, TFunc ([], TInt, TBool))
  | Gt -> TFunc ([], TInt, TFunc ([], TInt, TBool))
  | Leq -> TFunc ([], TInt, TFunc ([], TInt, TBool))
  | Geq -> TFunc ([], TInt, TFunc ([], TInt, TBool))
  | Concat -> TFunc ([], TString, TFunc ([], TString, TString))
  | Cat -> let t = TUniv (-1) in TFunc ([t], t, TFunc ([], TList ([], t), TList ([], t)))
  | Append -> let t = TUniv (-1) in TFunc ([t], TList ([], t), TFunc ([], TList ([], t), TList ([], t)))
  | Head -> let t = TUniv (-1) in TFunc ([t], TList ([], t), t)
  | Tail -> let t = TUniv (-1) in TFunc ([t], TList ([], t), TList ([], t))
  | Print -> let t = TUniv (-1) in TFunc ([t], t, TUnit)

let rec solve_constraints (constraints : (type_lang * type_lang) list) :
    (int * type_lang) list =
  match constraints with
  (* à modifier après ça*)
  | [] -> failwith "solve_constraints not implemented"
  | ((TFunc _ as f), TBool) :: _ -> raise (Constraint_error (f, TBool))
  | _ :: t ->
      ignore substitute_constraint;
      solve_constraints t

let instantiate (counter : Counter.t) (type_lang : type_lang) : type_lang =
  (* à modifier*)
  let _ = Counter.get_fresh counter in
  match type_lang with _ -> type_lang
