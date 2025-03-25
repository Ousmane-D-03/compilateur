%{
    open Ast
%}

%token IF
%token THEN
%token ELSE
%token WHILE
%token L_PAR
%token R_PAR
%token L_CUR_BRK
%token R_CUR_BRK
%token L_SQ_BRK
%token R_SQ_BRK
%token ADD
%token SUB
%token MUL
%token DIV
%token MOD
%token AND
%token OR
%token NOT
%token EQ
%token NEQ
%token LT
%token GT
%token LEQ
%token GEQ
%token COMMA
%token SEMICOLON
%token ASSIGN
%token DEF
%token DOT
%token PRINT
%token SIZE
%token RETURN
%token INT_TYP
%token FLOAT_TYP
%token BOOL_TYP
%token NULL_TYP
%token VAR
%token <string> ID
%token <string> STRING
%token <int> INT
%token <float> FLOAT
%token <bool> BOOL
%token EOF

%nonassoc THEN
%nonassoc ELSE
%left ADD SUB
%left MUL DIV MOD
%nonassoc UMINUS
%nonassoc L_PAR

%start <Ast.t> main

%%

main:
| l = function_list EOF { Program (List.rev l) }
| i = instruction EOF { Instruction i }
| e = expression EOF { Expression e }

function_list:
| (* empty *) { [] }
| function_list function_decl { $2 :: $1 }

function_decl:
| DEF ID params=separated_list(COMMA, ID) RETURN typ=type_ 
  L_CUR_BRK body=instruction_list R_CUR_BRK
  { { name = $2; params = params; return_type = typ; 
      body = List.rev body; annot = Annotation.create $loc } }

type_:
| INT_TYP { TInt }
| FLOAT_TYP { TFloat }
| BOOL_TYP { TBool }
| NULL_TYP { TNull }

instruction:
| IF e=expression THEN i1=instruction ELSE i2=instruction 
  { IfElse(e, i1, i2, Annotation.create $loc) }
| WHILE e=expression DO i=instruction 
  { While(e, i, Annotation.create $loc) }
| L_CUR_BRK il=instruction_list R_CUR_BRK 
  { Block(List.rev il, Annotation.create $loc) }
| VAR id=ID ASSIGN e=expression SEMICOLON 
  { DeclVar(id, e, Annotation.create $loc) }
| id=ID ASSIGN e=expression SEMICOLON 
  { Assign(id, e, Annotation.create $loc) }
| PRINT e=expression SEMICOLON 
  { Print(e, Annotation.create $loc) }
| SEMICOLON { Block([], Annotation.create $loc) }

instruction_list:
| (* empty *) { [] }
| instruction_list instruction { $2 :: $1 }

expression:
| i=INT { Cst_i(i, Annotation.create $loc) }
| f=FLOAT { Cst_f(f, Annotation.create $loc) }
| s=STRING { Cst_s(s, Annotation.create $loc) }
| BOOL { Cst_b($1, Annotation.create $loc) }
| id=ID { Var(id, Annotation.create $loc) }
| e1=expression op=binop e2=expression 
  { Binop(op, e1, e2, Annotation.create $loc) }
| SUB e=expression %prec UMINUS 
  { Unop(Neg, e, Annotation.create $loc) }
| NOT e=expression 
  { Unop(Not, e, Annotation.create $loc) }
| L_PAR e=expression R_PAR { e }
| ID L_PAR args=separated_list(COMMA, expression) R_PAR 
  { CallFunc($1, args, Annotation.create $loc) }

%inline binop:
| ADD { Add }
| SUB { Sub }
| MUL { Mul }
| DIV { Div }
| MOD { Mod }
| AND { And }
| OR { Or }
| EQ { Eq }
| NEQ { Neq }
| LT { Lt }
| GT { Gt }
| LEQ { Leq }
| GEQ { Geq }