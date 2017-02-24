%{
//PROJECT #2: PARSING Jon Sherwood 
//CS 4280 Program Translation Tech. Spring 2015
#include <stdio.h>
#include "tree.h"
extern tree root;

%}
%token <i> Ident 1  Intconst 2 
%token Resource 11 Main 12  Var 13
%token Const 14 Int 15 Bool 16 Ref 17 End 18 Do 19 Od 20 
%token If 21 Else 22 Fi 23 Exit 24 Next 25 Rec 26 Skip 27
%token Or 28 And 29 Not 30 True 31 False 32 Mod 33 Plus 34 
%token Minus 35 Star 36 Slash 37 Equal 38 Nequal 39 Lthan 40
%token Gthan 41 Lequal 42 Gequal 43 Lparen 44 Rparen 45 Comma 46 
%token Brac 47 Arrow 48 Assign 49 Semi 50 Colon 51 Period 52 Prog 60

%start program
%union { tree p; int i; }
%type  <p> body top_level decl type rec_type field_list idlist block stmts statement guarded_list guarded_stmt expr o_expr a_expr b_expr sum term factor unit
%%

program
	: Resource Main body End
		{ root = buildTree ( Prog, $3, NULL, NULL); }
	;
body
	: 	/* empty */
		{ $$ = NULL; }
	| top_level body
		{ $1->next = $2; $$ = $1; }
	;
top_level
	: statement
		{ $$ = $1; }
	| decl
		{ $$ = $1; }
	;
decl
	: Var idlist Colon type Semi
		{ $$ = buildTree (Var, $2, $4, NULL); }
	| Const Ident Colon type Assign expr Semi
		{ $$ = buildTree (Const, buildIntTree(Ident, $2),$4,$6); }
	;
type
	: Int
		{ $$ = buildTree (Int, NULL, NULL, NULL); }
	| Bool
		{ $$ = buildTree (Bool,NULL, NULL, NULL); }
	| Rec type
		{ $$ = buildTree(Rec, $2, NULL, NULL); }
	;
rec_type
	: Rec Lparen field_list Rparen
		{ $$ = buildTree (Rec, $3,NULL,NULL); }
	;
field_list
	: Ident Colon type
        { $$ = buildTree(Colon, buildIntTree(Ident, $1), $3, NULL); }
	| field_list Semi Ident Semi type
        { $$ = buildTree(Semi, $1, buildIntTree(Ident, $3),$5); }
	;
idlist
	: Ident
		{ $$ = buildIntTree (Ident, $1); }
	| Ident Comma idlist
		{ $$ = buildIntTree (Ident, $1); $$->next = $3; }
	;
block
	: /* empty */
		{ $$ = NULL; }
	| decl block
		{ $$ = $1; $1->next = $2; }
	| statement block
		{ $$ = $1; $1->next = $2;}
	;
stmts
	: statement
		{ $$ = $1; }
	| statement stmts
		{  $$ = $1; $1->next = $2; }
	;
statement
	: expr Semi
		{ $$ =  $1; }
	| Skip Semi
		{ $$ = buildTree(Skip, NULL, NULL, NULL); }
	| Exit Semi
		{ $$ = buildTree(Exit, NULL, NULL, NULL); }
	| Next Semi
		{ $$ = buildTree(Next, NULL, NULL, NULL); }
	| Do guarded_list Od Semi
            { $$ = buildTree(Do, $2, NULL, NULL); }
	| If guarded_list Fi Semi
            { $$ = buildTree(If, $2, NULL, NULL); }
	;
guarded_list
	: guarded_stmt
            { $$ = $1; }
	| guarded_stmt Brac Else Arrow stmts
            { $$ = buildTree(Else, $1, $5,NULL); }
	| guarded_stmt Brac guarded_list
            { $$ = $1; $1->next=$3; }
	;
guarded_stmt
	:expr Arrow stmts
		{$$ = buildTree(Arrow, $1, $3, NULL);}
	;
expr
	: Ident Assign expr
		{$$ = buildTree(Assign, buildIntTree(Ident, $1), $3, NULL);}
	| Ident Period Ident Assign expr
		{$$ = buildTree(Assign, buildTree(Period, buildIntTree(Ident, $1),buildIntTree(Ident,$3),NULL), $5,NULL);}
	| o_expr
		{ $$ = $1; }
    ;
o_expr
	: o_expr   Or   a_expr
		{$$ = buildTree(Or, $1, $3,NULL);}
	| a_expr
		{ $$ = $1; }
	;
a_expr
	: a_expr  And  b_expr
		{$$ = buildTree(And, $1, $3,NULL);}
	| b_expr
		{ $$ = $1; }
	;
b_expr
	: b_expr Equal sum
		{$$ = buildTree(Equal, $1, $3,NULL);}
	| b_expr Nequal sum
		{$$ = buildTree(Nequal, $1, $3,NULL);}
	| b_expr Lthan sum
		{$$ = buildTree(Lthan, $1, $3,NULL);}
	| b_expr Gthan sum
		{$$ = buildTree(Gthan, $1, $3,NULL);}
	| b_expr Lequal sum
		{$$ = buildTree(Lequal, $1, $3,NULL);}
	| b_expr Gequal sum
		{$$ = buildTree(Gequal, $1, $3,NULL);}
	| sum
		{ $$ = $1; }
	;
sum
	: sum Plus term
		{$$ = buildTree(Plus, $1, $3,NULL);}
	| sum Minus term
		{$$ = buildTree(Minus, $1, $3,NULL);}
	| term
		{ $$ = $1; }
	;
term
	: term Star factor
		{$$ = buildTree(Star, $1, $3,NULL);}
	| term Slash factor
		{$$ = buildTree(Slash, $1, $3, NULL);}
	| term Mod factor
		{$$ = buildTree( Mod, $1, $3, NULL);}
	| factor
		{ $$ = $1; }
	;
factor
	: Plus unit
		{ $$ = buildTree(Plus, $2, NULL,NULL); }
	| Minus unit
		{ $$ = buildTree(Minus, $2, NULL, NULL); }
	| Not unit
		{ $$ = buildTree(Not, $2, NULL, NULL); }
	| unit
		{ $$ = $1; }
	;
unit
	: Ident
		{ $$ = buildIntTree(Ident, $1); }
	| Intconst
		{ $$ = buildIntTree(Intconst, $1); }
	| True
		{ $$ = buildTree(True, NULL, NULL, NULL); }
	| False
		{ $$ = buildTree(False, NULL, NULL, NULL); }
	| Lparen expr Rparen
    	{ $$ = $2; }
	| Ident Period  Ident
		{ $$ = buildTree(Period, buildIntTree(Ident, $1), buildIntTree(Ident, $3), NULL); }
	;
%%

