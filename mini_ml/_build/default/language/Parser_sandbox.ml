
(* This generated code requires the following version of MenhirLib: *)

let () =
  MenhirLib.StaticVersion.require_20240715

module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = Tokens.token
  
end

include MenhirBasics

# 1 "language/Parser_sandbox.mly"
  
    open Ast

# 26 "language/Parser_sandbox.ml"

module Tables = struct
  
  include MenhirBasics
  
  let token2terminal : token -> int =
    fun _tok ->
      match _tok with
      | Tokens.ADD ->
          39
      | Tokens.AND ->
          38
      | Tokens.APPEND ->
          37
      | Tokens.ARROW ->
          36
      | Tokens.BOOL _ ->
          35
      | Tokens.CAT ->
          34
      | Tokens.CONCAT ->
          33
      | Tokens.DIV ->
          32
      | Tokens.ELSE ->
          31
      | Tokens.EOF ->
          30
      | Tokens.EQ ->
          29
      | Tokens.FUN ->
          28
      | Tokens.GEQ ->
          27
      | Tokens.GT ->
          26
      | Tokens.HEAD ->
          25
      | Tokens.ID _ ->
          24
      | Tokens.IF ->
          23
      | Tokens.IN ->
          22
      | Tokens.INT _ ->
          21
      | Tokens.LEQ ->
          20
      | Tokens.LET ->
          19
      | Tokens.LT ->
          18
      | Tokens.L_PAR ->
          17
      | Tokens.L_SQ ->
          16
      | Tokens.MOD ->
          15
      | Tokens.MUL ->
          14
      | Tokens.NEG ->
          13
      | Tokens.NEQ ->
          12
      | Tokens.NOT ->
          11
      | Tokens.OR ->
          10
      | Tokens.PRINT ->
          9
      | Tokens.REC ->
          8
      | Tokens.R_PAR ->
          7
      | Tokens.R_SQ ->
          6
      | Tokens.SEMICOLON ->
          5
      | Tokens.STRING _ ->
          4
      | Tokens.SUB ->
          3
      | Tokens.TAIL ->
          2
      | Tokens.THEN ->
          1
  
  and error_terminal =
    0
  
  and token2value : token -> Obj.t =
    fun _tok ->
      match _tok with
      | Tokens.ADD ->
          Obj.repr ()
      | Tokens.AND ->
          Obj.repr ()
      | Tokens.APPEND ->
          Obj.repr ()
      | Tokens.ARROW ->
          Obj.repr ()
      | Tokens.BOOL _v ->
          Obj.repr _v
      | Tokens.CAT ->
          Obj.repr ()
      | Tokens.CONCAT ->
          Obj.repr ()
      | Tokens.DIV ->
          Obj.repr ()
      | Tokens.ELSE ->
          Obj.repr ()
      | Tokens.EOF ->
          Obj.repr ()
      | Tokens.EQ ->
          Obj.repr ()
      | Tokens.FUN ->
          Obj.repr ()
      | Tokens.GEQ ->
          Obj.repr ()
      | Tokens.GT ->
          Obj.repr ()
      | Tokens.HEAD ->
          Obj.repr ()
      | Tokens.ID _v ->
          Obj.repr _v
      | Tokens.IF ->
          Obj.repr ()
      | Tokens.IN ->
          Obj.repr ()
      | Tokens.INT _v ->
          Obj.repr _v
      | Tokens.LEQ ->
          Obj.repr ()
      | Tokens.LET ->
          Obj.repr ()
      | Tokens.LT ->
          Obj.repr ()
      | Tokens.L_PAR ->
          Obj.repr ()
      | Tokens.L_SQ ->
          Obj.repr ()
      | Tokens.MOD ->
          Obj.repr ()
      | Tokens.MUL ->
          Obj.repr ()
      | Tokens.NEG ->
          Obj.repr ()
      | Tokens.NEQ ->
          Obj.repr ()
      | Tokens.NOT ->
          Obj.repr ()
      | Tokens.OR ->
          Obj.repr ()
      | Tokens.PRINT ->
          Obj.repr ()
      | Tokens.REC ->
          Obj.repr ()
      | Tokens.R_PAR ->
          Obj.repr ()
      | Tokens.R_SQ ->
          Obj.repr ()
      | Tokens.SEMICOLON ->
          Obj.repr ()
      | Tokens.STRING _v ->
          Obj.repr _v
      | Tokens.SUB ->
          Obj.repr ()
      | Tokens.TAIL ->
          Obj.repr ()
      | Tokens.THEN ->
          Obj.repr ()
  
  and default_reduction =
    (4, "\n\b\176\000\005\000\t\012\016p")
  
  and error =
    (40, "\000\004D\136\000\000\000\000\000\000\000\004D\136\001\000\000\000\000\000\000\000\000\000\000\000\000\000\128\000\000\000\000\000\b\000\004D\136\000\001\004D\130\000\000\000\000\000\000\000\004D\128\000\001\004D\130\000\001\000\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000")
  
  and start =
    1
  
  and action =
    ((8, "\027\000\027\000\000/E\027\003\000\027\000\t\000\005\000\000+\000"), (8, "\006\026\0306\n>\r\021\014K\000\018\005\t\000\022\005\t\000\000\005\t\000\005\t\0002\000\000\r\021"))
  
  and lhs =
    (4, "\004C3!\017\017")
  
  and goto =
    ((4, "0`\000\014\000\128\000\000\000\000"), (8, "\t\017\018\011\t\012\015\011\t\000\n\011"))
  
  and semantic_action =
    [|
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = f;
          MenhirLib.EngineTypes.startp = _startpos_f_;
          MenhirLib.EngineTypes.endp = _endpos_f_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let f : (Ast.expr) = Obj.magic f in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_f_ in
        let _endpos = _endpos_f_ in
        let _v : (Ast.expr) = 
# 24 "language/Parser_sandbox.mly"
                  ( f )
# 235 "language/Parser_sandbox.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e;
          MenhirLib.EngineTypes.startp = _startpos_e_;
          MenhirLib.EngineTypes.endp = _endpos_e_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = f;
            MenhirLib.EngineTypes.startp = _startpos_f_;
            MenhirLib.EngineTypes.endp = _endpos_f_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let e : (Ast.expr) = Obj.magic e in
        let f : (Ast.expr) = Obj.magic f in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_f_ in
        let _endpos = _endpos_e_ in
        let _v =
          let _endpos = _endpos_e_ in
          let _startpos = _startpos_f_ in
          let _loc = (_startpos, _endpos) in
          (
# 25 "language/Parser_sandbox.mly"
                               ( App(f,e,Annotation.create _loc))
# 271 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = e;
          MenhirLib.EngineTypes.startp = _startpos_e_;
          MenhirLib.EngineTypes.endp = _endpos_e_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let e : (Ast.expr) = Obj.magic e in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e_ in
        let _endpos = _endpos_e_ in
        let _v : (Ast.expr) = 
# 13 "language/Parser_sandbox.mly"
                  ( e )
# 297 "language/Parser_sandbox.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e;
          MenhirLib.EngineTypes.startp = _startpos_e_;
          MenhirLib.EngineTypes.endp = _endpos_e_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _3;
            MenhirLib.EngineTypes.startp = _startpos__3_;
            MenhirLib.EngineTypes.endp = _endpos__3_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = x;
              MenhirLib.EngineTypes.startp = _startpos_x_;
              MenhirLib.EngineTypes.endp = _endpos_x_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let e : (Ast.expr) = Obj.magic e in
        let _3 : unit = Obj.magic _3 in
        let x : (
# 22 "language/Tokens.mly"
       (string)
# 338 "language/Parser_sandbox.ml"
        ) = Obj.magic x in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_e_ in
        let _v =
          let _endpos = _endpos_e_ in
          let _startpos = _startpos__1_ in
          let _loc = (_startpos, _endpos) in
          (
# 14 "language/Parser_sandbox.mly"
                            ( Fun(x,e,Annotation.create _loc) )
# 351 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e2;
          MenhirLib.EngineTypes.startp = _startpos_e2_;
          MenhirLib.EngineTypes.endp = _endpos_e2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = e1;
            MenhirLib.EngineTypes.startp = _startpos_e1_;
            MenhirLib.EngineTypes.endp = _endpos_e1_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let e2 : (Ast.expr) = Obj.magic e2 in
        let e1 : (Ast.expr) = Obj.magic e1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e1_ in
        let _endpos = _endpos_e2_ in
        let _v =
          let _endpos = _endpos_e2_ in
          let _startpos = _startpos_e1_ in
          let _loc = (_startpos, _endpos) in
          (
# 15 "language/Parser_sandbox.mly"
                                 ( App(e1,e2,Annotation.create _loc) )
# 388 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _2;
          MenhirLib.EngineTypes.startp = _startpos__2_;
          MenhirLib.EngineTypes.endp = _endpos__2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = e;
            MenhirLib.EngineTypes.startp = _startpos_e_;
            MenhirLib.EngineTypes.endp = _endpos_e_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let _2 : unit = Obj.magic _2 in
        let e : (Ast.expr) = Obj.magic e in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e_ in
        let _endpos = _endpos__2_ in
        let _v : (Ast.t) = 
# 10 "language/Parser_sandbox.mly"
             ( [(false,"result",e)] )
# 421 "language/Parser_sandbox.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = i;
          MenhirLib.EngineTypes.startp = _startpos_i_;
          MenhirLib.EngineTypes.endp = _endpos_i_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let i : (
# 24 "language/Tokens.mly"
       (int)
# 442 "language/Parser_sandbox.ml"
        ) = Obj.magic i in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_i_ in
        let _endpos = _endpos_i_ in
        let _v =
          let _endpos = _endpos_i_ in
          let _startpos = _startpos_i_ in
          let _loc = (_startpos, _endpos) in
          (
# 18 "language/Parser_sandbox.mly"
          ( Cst_i(i,Annotation.create _loc) )
# 454 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _3;
          MenhirLib.EngineTypes.startp = _startpos__3_;
          MenhirLib.EngineTypes.endp = _endpos__3_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _1_inlined1;
            MenhirLib.EngineTypes.startp = _startpos__1_inlined1_;
            MenhirLib.EngineTypes.endp = _endpos__1_inlined1_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let _3 : unit = Obj.magic _3 in
        let _1_inlined1 : unit = Obj.magic _1_inlined1 in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v =
          let f =
            let b = 
# 28 "language/Parser_sandbox.mly"
        ( Add )
# 496 "language/Parser_sandbox.ml"
             in
            
# 31 "language/Parser_sandbox.mly"
                        ( b )
# 501 "language/Parser_sandbox.ml"
            
          in
          let (_endpos_f_, _startpos_f_) = (_endpos__3_, _startpos__1_) in
          let _endpos = _endpos_f_ in
          let _startpos = _startpos_f_ in
          let _loc = (_startpos, _endpos) in
          (
# 19 "language/Parser_sandbox.mly"
               ( Cst_func(f,Annotation.create _loc) )
# 511 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v =
          let f = 
# 32 "language/Parser_sandbox.mly"
        ( UMin )
# 538 "language/Parser_sandbox.ml"
           in
          let (_endpos_f_, _startpos_f_) = (_endpos__1_, _startpos__1_) in
          let _endpos = _endpos_f_ in
          let _startpos = _startpos_f_ in
          let _loc = (_startpos, _endpos) in
          (
# 19 "language/Parser_sandbox.mly"
               ( Cst_func(f,Annotation.create _loc) )
# 547 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = x;
          MenhirLib.EngineTypes.startp = _startpos_x_;
          MenhirLib.EngineTypes.endp = _endpos_x_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let x : (
# 22 "language/Tokens.mly"
       (string)
# 569 "language/Parser_sandbox.ml"
        ) = Obj.magic x in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_x_ in
        let _v =
          let _endpos = _endpos_x_ in
          let _startpos = _startpos_x_ in
          let _loc = (_startpos, _endpos) in
          (
# 20 "language/Parser_sandbox.mly"
         ( Var(x,Annotation.create _loc) )
# 581 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _3;
          MenhirLib.EngineTypes.startp = _startpos__3_;
          MenhirLib.EngineTypes.endp = _endpos__3_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = e;
            MenhirLib.EngineTypes.startp = _startpos_e_;
            MenhirLib.EngineTypes.endp = _endpos_e_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let _3 : unit = Obj.magic _3 in
        let e : (Ast.expr) = Obj.magic e in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v : (Ast.expr) = 
# 21 "language/Parser_sandbox.mly"
                       ( e )
# 621 "language/Parser_sandbox.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
    |]
  
  and trace =
    None
  
end

module MenhirInterpreter = struct
  
  module ET = MenhirLib.TableInterpreter.MakeEngineTable (Tables)
  
  module TI = MenhirLib.Engine.Make (ET)
  
  include TI
  
  module Symbols = struct
    
    type 'a terminal = 'a Tokens.MenhirInterpreter.terminal
    
    type _ nonterminal = 
      | N_simple_expr : (Ast.expr) nonterminal
      | N_main : (Ast.t) nonterminal
      | N_expr : (Ast.expr) nonterminal
      | N_app_expr : (Ast.expr) nonterminal
    
  end
  
  include Symbols
  
  include MenhirLib.InspectionTableInterpreter.Make (Tables) (struct
    
    include TI
    
    include Symbols
    
    include MenhirLib.InspectionTableInterpreter.Symbols (Symbols)
    
    let terminal =
      fun t ->
        match t with
        | 0 ->
            X (T Tokens.MenhirInterpreter.T_error)
        | 1 ->
            X (T Tokens.MenhirInterpreter.T_THEN)
        | 2 ->
            X (T Tokens.MenhirInterpreter.T_TAIL)
        | 3 ->
            X (T Tokens.MenhirInterpreter.T_SUB)
        | 4 ->
            X (T Tokens.MenhirInterpreter.T_STRING)
        | 5 ->
            X (T Tokens.MenhirInterpreter.T_SEMICOLON)
        | 6 ->
            X (T Tokens.MenhirInterpreter.T_R_SQ)
        | 7 ->
            X (T Tokens.MenhirInterpreter.T_R_PAR)
        | 8 ->
            X (T Tokens.MenhirInterpreter.T_REC)
        | 9 ->
            X (T Tokens.MenhirInterpreter.T_PRINT)
        | 10 ->
            X (T Tokens.MenhirInterpreter.T_OR)
        | 11 ->
            X (T Tokens.MenhirInterpreter.T_NOT)
        | 12 ->
            X (T Tokens.MenhirInterpreter.T_NEQ)
        | 13 ->
            X (T Tokens.MenhirInterpreter.T_NEG)
        | 14 ->
            X (T Tokens.MenhirInterpreter.T_MUL)
        | 15 ->
            X (T Tokens.MenhirInterpreter.T_MOD)
        | 16 ->
            X (T Tokens.MenhirInterpreter.T_L_SQ)
        | 17 ->
            X (T Tokens.MenhirInterpreter.T_L_PAR)
        | 18 ->
            X (T Tokens.MenhirInterpreter.T_LT)
        | 19 ->
            X (T Tokens.MenhirInterpreter.T_LET)
        | 20 ->
            X (T Tokens.MenhirInterpreter.T_LEQ)
        | 21 ->
            X (T Tokens.MenhirInterpreter.T_INT)
        | 22 ->
            X (T Tokens.MenhirInterpreter.T_IN)
        | 23 ->
            X (T Tokens.MenhirInterpreter.T_IF)
        | 24 ->
            X (T Tokens.MenhirInterpreter.T_ID)
        | 25 ->
            X (T Tokens.MenhirInterpreter.T_HEAD)
        | 26 ->
            X (T Tokens.MenhirInterpreter.T_GT)
        | 27 ->
            X (T Tokens.MenhirInterpreter.T_GEQ)
        | 28 ->
            X (T Tokens.MenhirInterpreter.T_FUN)
        | 29 ->
            X (T Tokens.MenhirInterpreter.T_EQ)
        | 30 ->
            X (T Tokens.MenhirInterpreter.T_EOF)
        | 31 ->
            X (T Tokens.MenhirInterpreter.T_ELSE)
        | 32 ->
            X (T Tokens.MenhirInterpreter.T_DIV)
        | 33 ->
            X (T Tokens.MenhirInterpreter.T_CONCAT)
        | 34 ->
            X (T Tokens.MenhirInterpreter.T_CAT)
        | 35 ->
            X (T Tokens.MenhirInterpreter.T_BOOL)
        | 36 ->
            X (T Tokens.MenhirInterpreter.T_ARROW)
        | 37 ->
            X (T Tokens.MenhirInterpreter.T_APPEND)
        | 38 ->
            X (T Tokens.MenhirInterpreter.T_AND)
        | 39 ->
            X (T Tokens.MenhirInterpreter.T_ADD)
        | _ ->
            assert false
    
    and nonterminal =
      fun nt ->
        match nt with
        | 4 ->
            X (N N_app_expr)
        | 3 ->
            X (N N_expr)
        | 2 ->
            X (N N_main)
        | 1 ->
            X (N N_simple_expr)
        | _ ->
            assert false
    
    and lr0_incoming =
      (8, "\000\028$,2:2J\003\007\t\003P\016\007\016\005\007>")
    
    and rhs =
      ((8, "\005\003\t\003\003:2J\007\t\003\007>,$P\016\0282$\007\016"), (8, "\000\001\002\004\005\t\011\r\014\017\018\019\022"))
    
    and lr0_core =
      (8, "\000\001\002\003\004\005\006\007\b\t\n\011\012\r\014\015\016\017\018")
    
    and lr0_items =
      ((16, "\000\000$\001,\001 \001\028\001(\001\016\001\016\002\016\003\012\001\004\001\016\004\020\001\b\001\020\002\b\002 \002 \003,\002,\003\000\001\024\001\024\002"), (8, "\000\001\002\004\005\006\007\b\t\011\012\014\016\017\018\019\020\021\022\023"))
    
    and nullable =
      "\000"
    
    and first =
      (40, "\000\004D\136\000\000\004D\128\000\000\004D\136\000\000\004D\136\000\000\004D\128\000")
    
  end) (ET) (TI)
  
end

let main =
  fun lexer lexbuf : (Ast.t) ->
    Obj.magic (MenhirInterpreter.entry `Legacy 0 lexer lexbuf)

module Incremental = struct
  
  let main =
    fun initial_position : (Ast.t) MenhirInterpreter.checkpoint ->
      Obj.magic (MenhirInterpreter.start 0 initial_position)
  
end
