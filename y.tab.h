#define  Ident 1 
#define  Intconst 2
#define  Resource 11
#define  Main 12
#define  Var 13
#define  Const 14
#define  Int 15
#define  Bool 16
#define  Ref 17
#define  End 18
#define  Do 19
#define  Od 20
#define  If 21
#define  Else 22
#define  Fi 23
#define  Exit 24
#define  Next 25
#define  Rec 26
#define  Skip 27
#define  Or 28
#define  And 29
#define  Not 30
#define  True 31
#define  False 32
#define  Mod 33 
#define  Plus 34
#define  Minus 35
#define  Star 36
#define  Slash 37
#define  Equal 38
#define  Nequal 39
#define  Lthan 40
#define  Gthan 41
#define  Lequal 42
#define  Gequal 43
#define  Lparen 44
#define  Rparen 45
#define  Comma 46
#define  Brac 47
#define  Arrow 48
#define  Assign 49
#define  Semi 50
#define  Colon 51
#define  Period 52
#ifdef yystype
#undef  yystype_is_declared
#define yystype_is_declared 1
#endif
#ifndef yystype_is_declared
#define yystype_is_declared 1
typedef union { tree p; int i; } yystype;
#endif /* !yystype_is_declared */
extern yystype yylval;
