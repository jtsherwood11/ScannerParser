CC = gcc -g
LEX = flex
YACC = bison -y
OBJS = main.o y.tab.o lex.yy.o \
		tree.o \
	# 	check.o \
	# 	code.o instr.o generate.o

sr : $(OBJS)
	$(CC) -o sr $(OBJS)

lex.yy.c : myscanner.l
	$(LEX) myscanner.l
lex.yy.o : lex.yy.c

y.tab.o : y.tab.c tree.h
y.tab.c : myparser.y
	$(YACC) myparser.y
y.tab.h : myparser.y
	$(YACC) -d myparser.y

tree.o : tree.c tree.h
main.o : main.c tree.h

clean :
	-@ rm lex.yy.c y.tab.c *.o
