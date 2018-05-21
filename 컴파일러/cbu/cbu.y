%{
#define MSDOS
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#define DEBUG	0

#define	 MAXSYM	100
#define	 MAXSYMLEN	20
#define	 MAXTSYMLEN	15
#define	 MAXTSYMBOL	MAXSYM/2


int tsymbolcnt=0;
int errorcnt=0;
FILE *fp;

extern char symtbl[MAXSYM][MAXSYMLEN];
extern int maxsym;
extern int lineno;
extern int ifcount = 0;
extern int whilecount = 0;

void	dwgen();
int		gentemp();
void	assgnstmt(int, int);
void	numassgn(int, int);
void	addstmt(int, int, int);
void	substmt(int, int, int);
void	multistmt(int, int, int);
void	divstmt(int, int, int);
void	powstmt(int, int, int);
void	rootstmt(int, int);
void	ifstmt();
void	whilestmt();
void	equalstmt(int, int, int);
void	nequalstmt(int, int);
void	bthanstmt(int, int);
void	sthanstmt(int, int);
void	labelstmt();
int		insertsym(char *);
%}

%token	ADD SUB MULTI DIV OF POW ROOT IF THEN IS CONAND WHILE EQUAL NEQUAL BIGTHAN SMALLTHAN ASSGN STMTEND START END ID NUM

%right ASSGN
%left EQUAL NEQUAL
%left BIGTHAN SMALLTHAN
%left ADD SUB
%left MULTI DIV
%left POW ROOT

%%
program		:	START stmt_list END		{ if (errorcnt==0) dwgen(); }
			;

stmt_list	:	stmt_list stmt 	
			|	/* null */
			| 	error STMTEND	{ errorcnt++; yyerrok; }
			;

stmt	:	IF { ifstmt(); } A THEN stmt		{ labelstmt(); }
		|	A WHILE stmt			//{ whilestmt(); }
		|	ID ASSGN expr STMTEND stmt	{ $$=$1; assgnstmt($1, $3); }
		|	/* null */
		;
			
A		:	Z CONAND Z EQUAL		{ $$=gentemp(); equalstmt($$, $1, $3); }
		|	Z CONAND Z NEQUAL		//{ $$=gentemp(); nequalstmt($1, $3); }
		|	Z IS Z BIGTHAN			//{ $$=gentemp(); bthanstmt($1, $3); }
		|	Z IS Z SMALLTHAN		//{ $$=gentemp(); sthanstmt($1, $3); }
		;
			
expr	:	expr ADD B		{ $$=gentemp(); addstmt($$, $1, $3); }
		|	expr SUB B		{ $$=gentemp(); substmt($$, $1, $3); }
		|	B
		;
		
B		:	B MULTI C		{ $$=gentemp(); multistmt($$, $1, $3); }
		|	B DIV C			{ $$=gentemp(); divstmt($$, $1, $3); }
		|	C
		;
		
C		:	Z OF NUM POW		{ $$=gentemp(); powstmt($$, $1, $3); }
		|	ROOT NUM			{ $$=gentemp(); rootstmt($$, $2); }
		|	Z
		;
		
Z		:	ID	
		|	NUM		{ $$=gentemp(); numassgn($$, $1); }
		;


%%
main() 
{
	printf("\nsample CBU compiler v1.0\n");
	printf("(C) Copyright by Jae Sung Lee (jasonlee@cbnu.ac.kr), 2001.\n");

	fp=fopen("a.asm", "w");
	
	yyparse();

	fclose(fp);

	if (errorcnt==0) 
		{ printf("Successfully compiled. Assembly code is in 'a.asm'.\n");}
}

yyerror(s)
char *s;
{
	printf("%s (line %d)\n", s, lineno);
}

void numassgn(idx, num)
int idx;
int num;
{
	fprintf(fp, "$ -- NUM ASSIGNMENT STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[idx]); 
	fprintf(fp, "PUSH %d\n", num); 
	fprintf(fp, ":=\n");
}

void assgnstmt(left, right)
int left;
int right;
{	
	fprintf(fp, "$ -- ID ASSIGNMENT STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[left]); 
	fprintf(fp, "RVALUE %s\n", symtbl[right]); 
	fprintf(fp, ":=\n");
}
	
void addstmt(t, first, second)
int t;
int first;
int second;
{
	fprintf(fp, "$ -- ADD STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[t]); 
	fprintf(fp, "RVALUE %s\n", symtbl[first]); 
	fprintf(fp, "RVALUE %s\n", symtbl[second]); 
	fprintf(fp, "+\n");
	fprintf(fp, ":=\n");
}

void substmt(t, first, second)
int t;
int first;
int second;
{
	fprintf(fp, "$ -- SUB STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[t]); 
	fprintf(fp, "RVALUE %s\n", symtbl[first]); 
	fprintf(fp, "RVALUE %s\n", symtbl[second]); 
	fprintf(fp, "-\n");
	fprintf(fp, ":=\n");
}

void multistmt(t, first, second)
int t;
int first;
int second;
{
	fprintf(fp, "$ -- MULTI STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[t]); 
	fprintf(fp, "RVALUE %s\n", symtbl[first]); 
	fprintf(fp, "RVALUE %s\n", symtbl[second]); 
	fprintf(fp, "*\n");
	fprintf(fp, ":=\n");
}

void divstmt(t, first, second)
int t;
int first;
int second;
{
	fprintf(fp, "$ -- DIV STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[t]); 
	fprintf(fp, "RVALUE %s\n", symtbl[first]); 
	fprintf(fp, "RVALUE %s\n", symtbl[second]); 
	fprintf(fp, "/\n");
	fprintf(fp, ":=\n");
}

void powstmt(t, first, second)
int t;
int first;
int second;
{
	int i;
	fprintf(fp, "$ -- POW STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[t]);
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	for(i=1; i<second; i++)
	{
		fprintf(fp, "RVALUE %s\n", symtbl[first]); 
		fprintf(fp, "*\n");
	}
	fprintf(fp, ":=\n");
}

void rootstmt(t, first)
int t;
int first;
{
	double temp;
	double next;
	next = 0.5*(1.0+(double)first/1.0);
	while(1)
	{
		temp = next;
		next = 0.5*(next + ((double)first/next));
		
		if((temp-next)<0.0001 || (temp-next)<-0.0001)
			break;
	}
	fprintf(fp, "$ -- ROOT STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[t]);
	fprintf(fp, "PUSH %d\n", (int)next);
}

void ifstmt()
{
	fprintf(fp, "$ -- IF STMT --\n");
	ifcount++;
}

void equalstmt(t, first, second)
int t;
int first;
int second;
{
	fprintf(fp, "LVALUE %s\n", symtbl[t]); 
	fprintf(fp, "RVALUE %s\n", symtbl[first]); 
	fprintf(fp, "RVALUE %s\n", symtbl[second]); 
	fprintf(fp, "-\n");
	fprintf(fp, ":=\n");
	if(first == second)
		fprintf(fp, "GOTO iflabel%d\n", ifcount);
}
/*
void nequalstmt(int, int)
int first;
int second;
{
	
}

void bthanstmt(int, int)
int first;
int second;
{
	
}

void sthanstmt(int, int)
int first;
int second;
{
	
}*/

void labelstmt()
{
	fprintf(fp, "LABEL iflabel%d\n", ifcount);
}

int gentemp()
{
char buffer[MAXTSYMLEN];
char tempsym[MAXSYMLEN]="TTCBU";

	tsymbolcnt++;
	if (tsymbolcnt > MAXTSYMBOL) printf("temp symbol overflow\n");
	itoa(tsymbolcnt, buffer, 10);
	strcat(tempsym, buffer);
	return( insertsym(tempsym) ); // Warning: duplicated symbol is not checked for lazy implementation
}

void dwgen()
{
int i;
	fprintf(fp, "HALT\n");
	fprintf(fp, "$ -- END OF EXECUTION CODE AND START OF VAR DEFINITIONS --\n");

// Warning: this code should be different if variable declaration is supported in the language 
	for(i=0; i<maxsym; i++) 
		fprintf(fp, "DW %s\n", symtbl[i]);
	fprintf(fp, "END\n");
}

