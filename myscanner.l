%{
//PROJECT #2: PARSING Jon Sherwood 
//CS 4280 Program Translation Tech. Spring 2015

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tree.h"
#include "y.tab.h"
void yyerror (char * s);
int line = 1, pos = 0;
%}
L	[a-zA-Z_]
D	[0-9]
%%
[ \t]+		{pos += yyleng;}
resource	{pos += 8; return Resource;}
main		{pos += 4; return Main;}
var			{pos += 3; return Var;}
const		{pos += 5; return Const;}
int			{pos += 3; return Int;}
bool		{pos += 4; return Bool;}
ref			{pos += 3; return Ref;}
end			{pos += 3; return End;}
do			{pos += 2; return Do;}
od			{pos += 2; return Od;}
if			{pos += 2; return If;}
else		{pos += 4; return Else;}
fi			{pos += 2; return Fi;}
exit		{pos += 4; return Exit;}
next		{pos += 4; return Next;}
rec			{pos += 3; return Rec;}
skip		{pos += 4; return Skip;}
or			{pos += 2; return Or;}
and			{pos += 3; return And;}
not			{pos += 3; return Not;}
mod			{pos += 3; return Mod;}
true		{pos += 4; return True;}
false		{pos += 5; return False;}
{D}+		{pos += yyleng; yylval.i=atoi(yytext);return Intconst;}
{L}({L}|{D})* {pos += yyleng; yylval.i = lookup(yytext); return Ident;}
"+"		{pos += 1; return Plus;}
"-"		{pos += 1; return Minus;}
"*"		{pos += 1; return Star;}
"/"		{pos += 1; return Slash;}
"="		{pos += 1; return Equal;}
"!="	{pos += 1; return Nequal;}
"<"		{pos += 1; return Lthan;}
">"		{pos += 1; return Gthan;}
"<="	{pos += 2; return Lequal;}
">="	{pos += 2; return Gequal;}
"("		{pos += 1; return Lparen;}
")"		{pos += 1; return Rparen;}
","		{pos += 1; return Comma;}
"[]"	{pos += 2; return Brac;}
"->"	{pos += 2; return Arrow;}
":="	{pos += 2; return Assign;}
";"		{pos += 1; return Semi;}
":"		{pos += 1; return Colon;}
"."		{pos += 1; return Period;}
"\n"	{line++; pos = 1;}
.		{pos += 1; yyerror ("Illegal Character");}
%%

void yyerror (char s[]) {
	printf ("%s in line %d at position %d token %s\n", s, line, pos, yytext);
}

int yywrap(void) {
    return 1;
}

typedef char name[15];
static char Names[200][15] = {"<no name>"};
int top = 0;

int lookup (char s[])
{
	int	i;

	for (i = 1; i <= top; i ++)
		if (strcmp (s, Names[i]) == 0) return i;
	strcpy (Names[++top], s);
	return top;
}

void printNames (void)
{
	int i = 0;

	for (; i <= top; i++)
		printf ("%d\t%s\n", i, Names[i]);

}

char *id_name (int i)
{
	return Names[i];
}
