%{
    open Ast
%}

/* Ajout des priorités conformes au sujet */
%nonassoc IN ELSE ARROW
%right CAT              /* :: associatif à droite */
%left CONCAT APPEND     /* ^ et @ associatifs à gauche */
%left EQ NEQ LT GT LEQ GEQ  /* Comparaisons */
%left ADD SUB           /* Additions/soustractions */
%left MUL DIV MOD       /* Multiplications/divisions */
%right NOT NEG HEAD TAIL PRINT  /* Unaires */
%left SEMICOLON

/* Règle pour les listes constantes */
simple_expr:
| L_SQ separated_list(SEMICOLON, expr) R_SQ { 
    List.fold_right (fun e acc -> 
      App(App(Cst_func(Cat, Annotation.create $loc), e, acc, Annotation.create $loc)) 
    $2 (Nil(Annotation.create $loc)) 
  }

/* Let avec arguments (sucrage syntaxique) */
req:
| LET name=ID args=nonempty_list(ID) EQ e=expr {
    let func = List.fold_right (fun arg acc -> 
      Fun(arg, acc, Annotation.create $loc)) args e in
    (false, name, func)
  }