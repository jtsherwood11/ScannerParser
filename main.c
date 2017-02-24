//PROJECT #2: PARSING Jon Sherwood 
//CS 4280 Program Translation Tech. Spring 2015
#include <stdio.h>
#include <stdlib.h>
#include "tree.h" 
tree root;

int main (int argc, char **argv) {
	extern FILE *yyin;

    if (argc != 2) {
        fprintf (stderr, "%s: USAGE: sr <input file name> \n", argv[0]);
        exit(1);
    }
    if ((yyin = fopen (argv[1], "r")) == 0L) {
        fprintf (stderr, "%s: Can't open Input File %s\n", argv[0], argv[1]);
        exit(1);
    }
	yyparse();
	printNames();
	printTree (root);
    close (yyin);
    return 0;

}

