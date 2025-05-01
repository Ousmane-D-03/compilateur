open Type_system
open Ast

exception Constraint_error of type_lang * type_lang
exception Typing_error of Util.Position.t * string

(* Déplacer occurs_in avant son utilisation *)
let rec substitute_univ_in_type (t : type_lang) (n : int) (replacement : type_lang) : type_lang =
  match t with
  | TUniv m when m = n -> replacement
  | TList(generics, t') -> TList(generics, substitute_univ_in_type t' n replacement)
  | TFunc(generics, t1, t2) ->
      TFunc(generics, substitute_univ_in_type t1 n replacement, substitute_univ_in_type t2 n replacement)
  | _ -> t

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

let rec solve_constraints (constraints : (type_lang * type_lang) list) =
  match constraints with
  | [] -> []
  | (t1, t2) :: rest ->
      match (t1, t2) with
      | TUniv n, t | t, TUniv n ->
          if occurs_in n t then
            raise (Constraint_error (t1, t2))
          else
            let subst = (n, t) in
            let rest' = List.map (fun (a,b) -> 
              (apply_subst_in_type [(n, t)] a, 
               apply_subst_in_type [(n, t)] b)) rest in
            subst :: solve_constraints rest'
            
      | TList(_, t1'), TList(_, t2') ->
          solve_constraints ((t1', t2') :: rest)
          
      | TFunc(_, t1, t2), TFunc(_, t1', t2') ->
          solve_constraints ((t1, t1') :: (t2, t2') :: rest)
          
      | t1, t2 when t1 = t2 -> solve_constraints rest
      | _ -> raise (Constraint_error (t1, t2))

let get_type_vars typ =
  let rec aux acc = function
    | TUniv n -> n :: acc
    | TList(_, t) -> aux acc t
    | TFunc(_, t1, t2) -> aux (aux acc t1) t2
    | _ -> acc
  in
  List.sort_uniq compare (aux [] typ)

let rec instantiate counter typ =
  match typ with
  | TFunc(generics, t1, t2) ->
      let fresh_vars = List.map (fun _ -> TUniv(Counter.get_fresh counter)) generics in
      let t1' = List.fold_left (fun t (gen, fresh) -> 
        substitute_univ_in_type t gen fresh) t1 (List.combine generics fresh_vars) in
      let t2' = List.fold_left (fun t (gen, fresh) ->
        substitute_univ_in_type t gen fresh) t2 (List.combine generics fresh_vars) in
      TFunc([], t1', t2')
  | TList(generics, t) ->
      let fresh_vars = List.map (fun _ -> TUniv(Counter.get_fresh counter)) generics in
      let t' = List.fold_left (fun t (gen, fresh) ->
        substitute_univ_in_type t gen fresh) t (List.combine generics fresh_vars) in
      TList([], t')
  | t -> t
