
(* The type of tokens. *)

type token = Tokens.token

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.t)

module MenhirInterpreter : sig
  
  (* The incremental API. *)
  
  include MenhirLib.IncrementalEngine.INCREMENTAL_ENGINE
    with type token = token
  
  (* The indexed type of terminal symbols. *)
  
  type 'a terminal = 'a Tokens.MenhirInterpreter.terminal
  
  (* The indexed type of nonterminal symbols. *)
  
  type _ nonterminal = 
    | N_simple_expr : (Ast.expr) nonterminal
    | N_req_list : (Ast.t) nonterminal
    | N_req : (Ast.req) nonterminal
    | N_main : (Ast.t) nonterminal
    | N_expr : (Ast.expr) nonterminal
    | N_app_expr : (Ast.expr) nonterminal
  
  (* The inspection API. *)
  
  include MenhirLib.IncrementalEngine.INSPECTION
    with type 'a lr1state := 'a lr1state
    with type production := production
    with type 'a terminal := 'a terminal
    with type 'a nonterminal := 'a nonterminal
    with type 'a env := 'a env
  
end

(* The entry point(s) to the incremental API. *)

module Incremental : sig
  
  val main: Lexing.position -> (Ast.t) MenhirInterpreter.checkpoint
  
end
