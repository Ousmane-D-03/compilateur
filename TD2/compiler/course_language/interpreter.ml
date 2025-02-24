open Ast
open Abstract_machine

exception Return_exp of value option
exception Non_variable_reference of expr
exception Non_bool_test of expr
exception Non_integer_array_position of expr

let get_tab_pos name pos = name ^ string_of_int pos

(* Commencez à modifier à partir d’ici -- le code présent dans les fonctions n’est là que pour empêcher des warnings à la compilation qui obscurcirait votre sortie. Enlevez-le quand vous commencez à implémenter une fonction.*)

(* Sémantique d’une opération binaire*)

let operation_of_binop (op : binop) (v1 : value) (v2 : value) =
  match op,v1 with
  | Add, VInt _-> add_i v1 v2
  | Add, VFloat _-> add_f v1 v2
  | Sub, VInt _-> sub_i v1 v2
  | Sub, VFloat _-> sub_f v1 v2
  | Mul, VInt _-> mul_i v1 v2
  | Mul, VFloat _-> mul_f v1 v2
  | Div, VInt _-> div_i v1 v2
  | Div, VFloat _-> div_f v1 v2
  | Mod, VInt _-> mod_i v1 v2
  | Mod, VFloat _-> mod_f v1 v2
  | And, VBool _-> and_b v1 v2
  | Or, _ -> or_b v1 v2
  | Eq, _ -> eq_m v1 v2
  | Neq, _ -> not_b(eq_m v1 v2)
  | Lt, _ -> lt_m v1 v2
  | Gt, _ -> lt_m v2 v1
  | Leq, _ -> or_b (eq_m v1 v2) (lt_m v1 v2)
  | Geq, _ -> or_b (eq_m v1 v2) (lt_m v2 v1)
  | _ -> failwith "error operation_of_binop"

(* Sémantique d’une opération unaire*)
let operation_of_unop (op : unop) (v : value) =
  match op,v with
  | Not,VBool _ -> not_b v
  | UMin,VInt x -> VInt(-1*x)
  | UMin,VFloat x -> VFloat(-1. *. x)
  | _ -> failwith "errror unop operation"
(* Cette fonction interprète une expression et renvoie sa valeur. Vous devez traiter tous les cas possibles (cf module Ast). Reportez-vous au cours pour une explication de la sémantique. On conseille de traiter parallèlement expressions et instructions par ordre de complexité (décrit dans le cours). Vous pouvez laisser des cas non-traités simplement en leur associant [failwith "todo"] qui fera planter le programme sur ces cas, mais permettra de compiler et de traiter les autres.*)
let rec interpret_expr (map : value Util.Environment.t)
    (map_function : (Ast.argument list * Ast.instruction) Util.Environment.t)
    (expr : Ast.expr) =
  match expr with
  | Cst_i (i, _) -> VInt i
  | Cst_f (f, _) -> VFloat f
  | Cst_b (b, _) -> VBool b
  | Var (v, _) ->
      let value = Util.Environment.get map v in
      (match value with
      | Some i ->i
      | None -> failwith "variable non définie")
  | Binop (b,e1,e2,_)->
      let v1= (interpret_expr map map_function e1)
      and v2 = (interpret_expr map map_function e2)
      in  operation_of_binop b v1 v2
  | Unop (u,e,_)->
      let v= interpret_expr map map_function e 
      in  operation_of_unop u v
  | Array_val (s, e,_)->
      let name, map_tab =
        (match Util.Environment.get map s with
        | Some VArray(s,env) -> s,env
        |_->failwith("pas un tableau"))
      and index =(
        match interpret_expr map map_function e with
        |VInt i -> i
        |_->failwith("not int"))
      in
        (match Util.Environment.get map (name^string_of_int index) with
        | Some value -> value
        | None -> failwith "error_array_val")
  | Size_tab (s,_) -> 
      let name, map_tab =
        (match Util.Environment.get map s with
        | Some VArray(s,env) -> s,env
        |_->failwith("pas un tableau"))
      in
        (match Util.Environment.get map (name^"size") with
        | Some VInt value -> VInt value
        | None -> failwith "error_size_tab")
  | Func (s, e,_)->     
    let args, body = Option.get (Util.Environment.get map_function s) in
    let args = List.map (fun (t, _, v) -> v) args in
    let e = List.map (fun x -> interpret_expr map map_function x) e in
    let local_env = Util.Environment.copy map in
    List.iter2 (fun v a -> Util.Environment.modify local_env v a) args e; 
    interpret_instruction local_env map_function body; 
    match Util.Environment.get local_env "#result" with
    | Some value -> value
    | None -> failwith "error_func"
  | _ -> failwith "todo interpret_expr"

(* Cette fonction interprète une instruction. Le «and» est là pour qu’elle soit co-récursive avec interpret_expr (à cause des appels de fonctions). Elle ne renvoie rien, mais applique directement des effets de bord sur [map]. Reportez-vous au cours pour la sémantique.*)
and interpret_instruction (map : value Util.Environment.t)
    (map_function : (Ast.argument list * Ast.instruction) Util.Environment.t)
    (instruction : Ast.instruction) =
    match instruction with
    | Affect (s,e, _) ->
        let v = interpret_expr map map_function e in
        Util.Environment.modify map s v
    | Block (i_l, _) -> (*List.fold_left (fun m inst ->let _= interpret_instruction m map_function inst in m) map i_l*)
        List.iter (fun x -> interpret_instruction map map_function x) i_l
    | IfThenElse (e, i_1, i_2,_) ->
        if (interpret_expr map map_function e)=VBool true 
        then interpret_instruction map map_function i_1
        else interpret_instruction map map_function i_2
    | While (e,i, _ )-> 
        if (interpret_expr map map_function e)=VBool true
        then(
          interpret_instruction map map_function i;
          interpret_instruction map map_function instruction
        ) 
        else ()
    | Affect_array(s, e_index, e_expr,_) ->
      let index =(
        match interpret_expr map map_function e_index with
        |VInt i -> i
        |_->failwith("not int"))
      in 
      let name, map_tab =
        (match Util.Environment.get map s with
        | Some VArray(s,env) -> s,env
        |_->failwith("pas un tableau"))
      in
        Util.Environment.modify map_tab (name^string_of_int index) (interpret_expr map map_function e_expr)
        (** Affectation to an array cell. The first expression is the position and the second the value to affect*)
    | Array_decl ( _,s,e,_)->
      let _= Util.Environment.modify map s (VArray(s^"#",map))  
      and size =(
        match interpret_expr map map_function e with
        |VInt i -> i
        |_->failwith("not int"))
      in 
        Util.Environment.modify map (s^"#size") (VInt size) 
    | Proc (s,e,_)-> 
      let args, body = Option.get (Util.Environment.get map_function s) in
      let args = List.map (fun (t,_,v) -> v) args in
      let e = List.map (fun x -> interpret_expr map map_function x) e in
      List.iter2 (fun v a -> Util.Environment.modify map v a) args e;
      interpret_instruction map map_function body
    | Print_str (st, _) -> 
      print_string st
    | Print_expr (expr, _) -> 
      print_string (string_of_value (interpret_expr map map_function expr))
    | Var_decl _ -> ()
    | Return(e,_)->
      match e with
        | Some r ->
          let v = interpret_expr map map_function r 
          in 
          Util.Environment.add map "#result" v
        | None -> ()
    | _ -> failwith "todo interpret_inst"

(*Cette fonction doit interpréter une déclaration de fonction. Elle consiste simplement à associer la liste des arguments et le corps de la fonction à son nom dans l’environnement [functions].*)
let interpret_func_decl
    (functions : (Ast.argument list * Ast.instruction) Util.Environment.t)
    (func_decl : Ast.function_decl) =
  match func_decl with
  | Func_decl (_,s,args,i,_) -> Util.Environment.add functions s (args,i)
  | _ -> failwith "todo interpret_func_decl"  
  () (*à compléter*)

(* Cette fonction utilitaire vous est fournie : elle permet de mettre la liste des arguments à la même taille que celle des paramètres de la fonction main : s’il n’y en a pas assez, on leur attribue la valeu VNone, s’il y en a trop, on ignore les derniers. Cela permet de rendre la ligne de commande un peu plus résiliente à un mauvais nombre d’argument sur l’exécution d’un programme*)
let normalize_arg_list args vars =
  if List.length args < List.length vars then
    args @ List.init (List.length vars - List.length args) (fun _ -> "")
  else if List.length args > List.length vars then
    List.filteri (fun i _ -> i < List.length vars) args
  else args

(* Cette fonction permet d’exécuter une liste de déclaration de fonctions sur les arguments passés à la ligne de commande, et lance dessus la fonction main. Elle analyse la liste des fonctions, et stocke leurs définitions dans un environnement de fonctions, puis récupère la définition de la fonction nommée "main", crée un environnement de variables à partir de [args] (normalisées avec la fonction ci-dessus) et de ses paramètres et enfin appelle le corps de main sur ces arguments (comme un appel de fonction, sauf qu’ici les arguments sont directement des objets sémantiques et non syntaxique). Elle est au fond similaire à un appel de fonction, mais un peu plus technique, donc on vous la fourni.*)

let interpret_prg prg args =
  let functions = Util.Environment.new_environment () in
  List.iter (interpret_func_decl functions) prg;
  let environnement = Util.Environment.new_environment () in
  let params, body =
    try Option.get (Util.Environment.get functions "main")
    with _ -> failwith "Function main not defined!"
  in
  let vars = List.map (fun (_, _, v) -> v) params in
  let args = normalize_arg_list args vars in
  List.iter2
    (fun v a ->
      Abstract_machine.parse_complex_argument_and_affect environnement v a)
    vars args;
  try interpret_instruction environnement functions body
  with Return_exp _ -> ()
