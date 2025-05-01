
(* The type of tokens. *)

type token = 
  | THEN
  | TAIL
  | SUB
  | STRING of (string)
  | SEMICOLON
  | R_SQ
  | R_PAR
  | REC
  | PRINT
  | OR
  | NOT
  | NEQ
  | NEG
  | MUL
  | MOD
  | L_SQ
  | L_PAR
  | LT
  | LET
  | LEQ
  | INT of (int)
  | IN
  | IF
  | ID of (string)
  | HEAD
  | GT
  | GEQ
  | FUN
  | EQ
  | EOF
  | ELSE
  | DIV
  | CONCAT
  | CAT
  | BOOL of (bool)
  | ARROW
  | APPEND
  | AND
  | ADD

module MenhirInterpreter : sig
  
  (* The indexed type of terminal symbols. *)
  
  type _ terminal = 
    | T_error : unit terminal
    | T_THEN : unit terminal
    | T_TAIL : unit terminal
    | T_SUB : unit terminal
    | T_STRING : (string) terminal
    | T_SEMICOLON : unit terminal
    | T_R_SQ : unit terminal
    | T_R_PAR : unit terminal
    | T_REC : unit terminal
    | T_PRINT : unit terminal
    | T_OR : unit terminal
    | T_NOT : unit terminal
    | T_NEQ : unit terminal
    | T_NEG : unit terminal
    | T_MUL : unit terminal
    | T_MOD : unit terminal
    | T_L_SQ : unit terminal
    | T_L_PAR : unit terminal
    | T_LT : unit terminal
    | T_LET : unit terminal
    | T_LEQ : unit terminal
    | T_INT : (int) terminal
    | T_IN : unit terminal
    | T_IF : unit terminal
    | T_ID : (string) terminal
    | T_HEAD : unit terminal
    | T_GT : unit terminal
    | T_GEQ : unit terminal
    | T_FUN : unit terminal
    | T_EQ : unit terminal
    | T_EOF : unit terminal
    | T_ELSE : unit terminal
    | T_DIV : unit terminal
    | T_CONCAT : unit terminal
    | T_CAT : unit terminal
    | T_BOOL : (bool) terminal
    | T_ARROW : unit terminal
    | T_APPEND : unit terminal
    | T_AND : unit terminal
    | T_ADD : unit terminal
  
end
