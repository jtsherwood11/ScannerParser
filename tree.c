//PROJECT #2: PARSING Jon Sherwood 
//CS 4280 Program Translation Tech. Spring 2015
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "tree.h"
#include "y.tab.h"

tree buildTree (int kind, tree one, tree two, tree three)
{
	tree p = (tree)malloc(sizeof (node));
	p->kind = kind;
	p->first = one;
	p->second = two;
	p->third = three;
	p->next = NULL;
	return p;
}

tree buildIntTree (int kind, int val)
{
	tree p = (tree)malloc(sizeof (node));
	p->kind = kind;
	p->value = val;
	p->first = p->second = p->third = NULL;
	p->next = NULL;
	return p;
}

char TokName[][12] = {
    "", "ident", "intconst", "", "", "", "", "", "", "", "",
    "resource", "main", "var", "const", "int", "bool", "ref", "end",
    "do", "od", "if", "else", "fi",  "exit", "next",
    "rec", "skip", "or", "and", "not", "true",
    "false","%", "+", "-", "*", "/", "=",
    "!=", "<", ">", "<=", ">=",
    "(", ")", ",", "[]", "->",
    ":=", ";", ":", "."
};


static int indent = 0;
void printTree (tree p)
{
	if (p == NULL) return;
	for (; p != NULL; p = p->next) {
		printf ("%*s%s", indent, "", TokName[p->kind]);
		switch (p->kind) {
			case Ident: 
				printf ("  %s (%d)\n", id_name (p->value), p->value);
				break;
			case Intconst:
				printf ("  %d\n", p->value);
				break;
			default:
				printf ("\n");
				indent += 2;
				printTree (p->first);
				printTree (p->second);
				printTree (p->third);
				indent -= 2;
			}
		}
}
