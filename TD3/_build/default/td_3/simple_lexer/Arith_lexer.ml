# 2 "td_3/simple_lexer/Arith_lexer.mll"
 
    exception Error of string

# 6 "td_3/simple_lexer/Arith_lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\247\255\248\255\249\255\250\255\010\000\000\000\252\255\
    \000\000\253\255\254\255\255\255\001\000\000\000";
  Lexing.lex_backtrk =
   "\255\255\255\255\255\255\255\255\255\255\004\000\008\000\255\255\
    \008\000\255\255\255\255\255\255\255\255\255\255";
  Lexing.lex_default =
   "\001\000\000\000\000\000\000\000\000\000\255\255\255\255\000\000\
    \255\255\000\000\000\000\000\000\255\255\255\255";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\011\000\010\000\000\000\000\000\011\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \011\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \004\000\003\000\000\000\009\000\000\000\007\000\000\000\000\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\008\000\007\000\000\000\012\000\009\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\006\000\000\000\013\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\255\255\255\255\000\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\255\255\000\000\255\255\000\000\255\255\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\013\000\255\255\008\000\012\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\000\000\255\255\006\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255";
  Lexing.lex_base_code =
   "";
  Lexing.lex_backtrk_code =
   "";
  Lexing.lex_default_code =
   "";
  Lexing.lex_trans_code =
   "";
  Lexing.lex_check_code =
   "";
  Lexing.lex_code =
   "";
}

let rec token lexbuf =
   __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 9 "td_3/simple_lexer/Arith_lexer.mll"
                                            ( token lexbuf )
# 108 "td_3/simple_lexer/Arith_lexer.ml"

  | 1 ->
# 10 "td_3/simple_lexer/Arith_lexer.mll"
                                 ( Lexing.new_line lexbuf; token lexbuf)
# 113 "td_3/simple_lexer/Arith_lexer.ml"

  | 2 ->
let
# 11 "td_3/simple_lexer/Arith_lexer.mll"
                       s
# 119 "td_3/simple_lexer/Arith_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 11 "td_3/simple_lexer/Arith_lexer.mll"
                                ( (Lexing.lexeme_start lexbuf), (Lexing.lexeme_end lexbuf), s,"add" )
# 123 "td_3/simple_lexer/Arith_lexer.ml"

  | 3 ->
let
# 12 "td_3/simple_lexer/Arith_lexer.mll"
                       s
# 129 "td_3/simple_lexer/Arith_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 12 "td_3/simple_lexer/Arith_lexer.mll"
                                ( (Lexing.lexeme_start lexbuf), (Lexing.lexeme_end lexbuf), s,"sub" )
# 133 "td_3/simple_lexer/Arith_lexer.ml"

  | 4 ->
let
# 13 "td_3/simple_lexer/Arith_lexer.mll"
                s
# 139 "td_3/simple_lexer/Arith_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 13 "td_3/simple_lexer/Arith_lexer.mll"
                                 ( (Lexing.lexeme_start lexbuf), (Lexing.lexeme_end lexbuf), s,"number" )
# 143 "td_3/simple_lexer/Arith_lexer.ml"

  | 5 ->
# 14 "td_3/simple_lexer/Arith_lexer.mll"
                                ( (Lexing.lexeme_start lexbuf), (Lexing.lexeme_end lexbuf), "(","Lpar" )
# 148 "td_3/simple_lexer/Arith_lexer.ml"

  | 6 ->
# 15 "td_3/simple_lexer/Arith_lexer.mll"
                                ( (Lexing.lexeme_start lexbuf), (Lexing.lexeme_end lexbuf), ")","Rpar" )
# 153 "td_3/simple_lexer/Arith_lexer.ml"

  | 7 ->
# 16 "td_3/simple_lexer/Arith_lexer.mll"
                                ( (Lexing.lexeme_start lexbuf), (Lexing.lexeme_end lexbuf), "","EOF")
# 158 "td_3/simple_lexer/Arith_lexer.ml"

  | 8 ->
let
# 17 "td_3/simple_lexer/Arith_lexer.mll"
           s
# 164 "td_3/simple_lexer/Arith_lexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 17 "td_3/simple_lexer/Arith_lexer.mll"
                                ( let pos = Lexing.lexeme_start_p lexbuf in raise (Error(Format.sprintf "Line %d, char %d ,Read: '%c'. It is not an acceptable character" pos.pos_lnum (pos.pos_cnum - pos.pos_bol +1) s)))
# 168 "td_3/simple_lexer/Arith_lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_token_rec lexbuf __ocaml_lex_state

;;

