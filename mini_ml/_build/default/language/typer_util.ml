open Type_system
open Ast

exception Constraint_error of type_lang * type_lang
exception Typing_error of Util.Position.t * string

(* Déplacer occurs_in avant son utilisation *)
let rec occurs_in (n : int) (t : type_lang) : bool =
  match t with
  | TUniv m -> n = m
  | TList(_, t) -> occurs_in n t
  | TFunc(_, t1, t2) -> occurs_in n t1 || occurs_in n t2
  | _ -> false

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
  | Cat -> 
      let t = TUniv 0 in 
      TFunc ([], t, TFunc ([], TList([], t), TList([], t)))
  | And | Or -> TFunc ([], TBool, TFunc ([], TBool, TBool))
  | Not -> TFunc ([], TBool, TBool)
  | Eq | Neq | Lt | Gt | Leq | Geq -> 
      let t = TUniv 0 in
      TFunc ([], t, TFunc ([], t, TBool))
  | Print -> let t = TUniv 0 in TFunc ([], t, TUnit)
  | Head -> let t = TUniv 0 in TFunc ([], TList([], t), t)
  | Tail -> let t = TUniv 0 in TFunc ([], TList([], t), TList([], t))
  | Concat -> TFunc ([], TString, TFunc ([], TString, TString))
  | Append -> 
      let t = TUniv 0 in 
      TFunc ([], TList([], t), TFunc ([], TList([], t), TList([], t)))

let rec solve_constraints (constraints : (type_lang * type_lang) list) :
    (int * type_lang) list =
  match constraints with
  | [] -> []
  | (t1, t2) :: rest ->
      match (t1, t2) with
      | TUniv n, t | t, TUniv n ->
          if occurs_in n t then
            raise (Constraint_error (t1, t2))
          else
            let rest' = List.map 
              (fun (a,b) -> substitute_constraint n t (a, b)) rest in
            (n, t) :: solve_constraints rest'
            
      | TList(_, a1), TList(_, a2) ->
          solve_constraints ((a1, a2) :: rest)
          
      | TFunc(_, a1, r1), TFunc(_, a2, r2) ->
          solve_constraints ((a1, a2) :: (r1, r2) :: rest)
          
      | t1, t2 when t1 = t2 ->
          solve_constraints rest
          
      | _ -> raise (Constraint_error (t1, t2))

let instantiate (counter : Counter.t) (type_lang : type_lang) : type_lang =
  let _ = Counter.get_fresh counter in
  match type_lang with _ -> type_lang
