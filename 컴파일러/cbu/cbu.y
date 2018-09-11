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
int switchnum;

extern char symtbl[MAXSYM][MAXSYMLEN];
extern int maxsym;
extern int lineno;
extern int outcount = 0;
extern int loopcount = 0;
extern int ifmulti = 0;
extern int loopmulti = 0;
extern int ifloop = 0;
extern int switchmix = 0;
extern int switchcount = 0;

void	dwgen();
int		gentemp();
/* 대입 */
void	assgnstmt(int, int);
void	addassgnstmt(int, int);
void	subassgnstmt(int, int);
void	mulassgnstmt(int, int);
void	divassgnstmt(int, int);
void	numassgn(int, int);

/* 연산 */
void	addstmt(int, int, int);
void	substmt(int, int, int);
void	multistmt(int, int, int);
void	divstmt(int, int, int);
void	modstmt(int, int, int);
void	powstmt(int, int, int);
void	rootstmt(int, int);
void	increasestmt(int, int);
void	decreasestmt(int, int);

/* 반복 및 조건 */
void	ifstmt();
void	elseifstmt();
void	whilestmt();
void	outstmt();
void	loopstmt();
void	countstmt(int, int);
void	casestmt(int);
void	breakstmt();

/* 비교 */
void	equalstmt(int, int);
void	nequalstmt(int, int);
void	bthanstmt(int, int);
void	sthanstmt(int, int);
void	bethanstmt(int, int);
void	sethanstmt(int, int);

/* 스위치 */
void	switchstmt(int);
void	switchoutstmt();
void	switchend();

/* 입출력 */
void	printstmt(int);
void	scanstmt(int);

int		insertsym(char *);
%}

%token	ADD SUB MULTI DIV OF POW ROOT IF THEN IS CONAND WHILE EQUAL NEQUAL BIGTHAN SMALLTHAN ASSGN STMTEND START END ID NUM INCOPE DECOPE STARTLOOP LBRA RBRA BIGETHAN SMALLETHAN MOD AND
%token	ADDASSGN SUBASSGN MULASSGN DIVASSGN ELSE ELSEIF COUNT BREAK SWITCH CASE COLON OUT SWITEND SCAN PRINT

%right ASSGN ADDASSGN SUBASSGN MULASSGN DIVASSGN
%left AND
%left EQUAL NEQUAL
%left BIGTHAN SMALLTHAN BIGETHAN SMALLETHAN
%left ADD SUB
%left MULTI DIV MOD
%left POW ROOT
%right INCOPE DECOPE

%%
program		:	START stmt_list END		{ if (errorcnt==0) dwgen(); }
			;

stmt_list	:	stmt_list stmt 	
			|	/* null */
			| 	error STMTEND	{ errorcnt++; yyerrok; }
			;

stmt	:	IF { ifstmt(); } logic THEN LBRA stmt escape RBRA mulst stmt
		|	STARTLOOP { whilestmt(); } logic WHILE LBRA stmt RBRA { loopstmt(); } stmt
		|	idum COUNT STARTLOOP { whilestmt(); $$=gentemp(); countstmt($$, $1); } LBRA stmt RBRA { loopstmt(); } stmt
		|	subst stmt
		|	choic
		|	/* null */
		;
		
choic	:	SWITCH LBRA ID RBRA { switchstmt($3); } CASE NUM COLON { $$=gentemp(); numassgn($$, $6); casestmt($$); } subst OUT { switchoutstmt(); } chca
		;
		
chca	:	CASE NUM COLON { $$=gentemp(); numassgn($$, $2); casestmt($$); } subst OUT { switchoutstmt(); } chca 
		|	SWITEND { switchend(); }
		;
		
escape	:	BREAK STMTEND { breakstmt(); }
		|	/* null */
		;

mulst	:	ELSEIF { elseifstmt(); outstmt(); } logic THEN LBRA stmt escape RBRA  mulst
		|	ELSE { outstmt(); } LBRA stmt escape RBRA
		|	/* null */ { outstmt(); }
		;
		
logic	:	comp AND logic
		|	comp
		;
		
subst	:	ID ASSGN expr STMTEND				{ $$=$1; assgnstmt($1, $3); }
		|	ID ADDASSGN expr STMTEND			{ $$=$1; addassgnstmt($1, $3); }
		|	ID SUBASSGN expr STMTEND			{ $$=$1; subassgnstmt($1, $3); }
		|	ID MULASSGN expr STMTEND			{ $$=$1; mulassgnstmt($1, $3); }
		|	ID SUBASSGN expr STMTEND			{ $$=$1; divassgnstmt($1, $3); }
		|	inde STMTEND
		|	SCAN ID	STMTEND						{ scanstmt($2); }
		|	PRINT ID STMTEND					{ printstmt($2); }
		;
		
comp	:	idum CONAND idum IS EQUAL			{ equalstmt($1, $3); }
		|	idum CONAND idum IS NEQUAL			{ nequalstmt($1, $3); }
		|	idum IS idum BIGTHAN				{ bthanstmt($1, $3); }
		|	idum IS idum SMALLTHAN				{ sthanstmt($1, $3); }
		|	idum IS idum BIGETHAN				{ bethanstmt($1, $3); }
		|	idum IS idum SMALLETHAN				{ sethanstmt($1, $3); }
		;
			
expr	:	expr ADD tim		{ $$=gentemp(); addstmt($$, $1, $3); }
		|	expr SUB tim		{ $$=gentemp(); substmt($$, $1, $3); }
		|	tim
		;
		
tim		:	tim MULTI squ		{ $$=gentemp(); multistmt($$, $1, $3); }
		|	tim DIV squ			{ $$=gentemp(); divstmt($$, $1, $3); }
		|	tim MOD squ			{ $$=gentemp(); modstmt($$, $1, $3); }
		|	squ
		;
		
squ		:	idum OF NUM POW		{ $$=gentemp(); powstmt($$, $1, $3); }
		|	ROOT NUM			{ $$=gentemp(); rootstmt($$, $2); }
		|	idum
		;
		
inde	:	INCOPE idum				{ $$=gentemp(); increasestmt($$, $2); }
		|	DECOPE idum				{ $$=gentemp(); decreasestmt($$, $2); }
		;
		
idum	:	ID	
		|	NUM			{ $$=gentemp(); numassgn($$, $1); }
		;


%%
main() 
{
	printf("\nsample CBU compiler v1.0\n");
	printf("Edited by Kwangho Son\n");

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

/* 대입 관련 */

void assgnstmt(left, right)
int left;
int right;
{	
	fprintf(fp, "$ -- ID ASSIGNMENT STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[left]); 
	fprintf(fp, "RVALUE %s\n", symtbl[right]); 
	fprintf(fp, ":=\n");
}
void addassgnstmt(left, right)
int left;
int right;
{
	fprintf(fp, "$ -- ID ADDASSIGNMENT STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[left]); 
	fprintf(fp, "RVALUE %s\n", symtbl[left]); 
	fprintf(fp, "RVALUE %s\n", symtbl[right]); 
	fprintf(fp, "+\n");
	fprintf(fp, ":=\n");
}
void subassgnstmt(left, right)
int left;
int right;
{
	fprintf(fp, "$ -- ID SUBASSIGNMENT STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[left]); 
	fprintf(fp, "RVALUE %s\n", symtbl[left]); 
	fprintf(fp, "RVALUE %s\n", symtbl[right]); 
	fprintf(fp, "-\n");
	fprintf(fp, ":=\n");
}
void mulassgnstmt(left, right)
int left;
int right;
{
	fprintf(fp, "$ -- ID MULASSIGNMENT STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[left]); 
	fprintf(fp, "RVALUE %s\n", symtbl[left]); 
	fprintf(fp, "RVALUE %s\n", symtbl[right]); 
	fprintf(fp, "*\n");
	fprintf(fp, ":=\n");
}
void divassgnstmt(left, right)
int left;
int right;
{
	fprintf(fp, "$ -- ID DIVASSIGNMENT STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[left]); 
	fprintf(fp, "RVALUE %s\n", symtbl[left]); 
	fprintf(fp, "RVALUE %s\n", symtbl[right]); 
	fprintf(fp, "/\n");
	fprintf(fp, ":=\n");
}


/* 연산 관련 */

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
void modstmt(t, first, second)
int t;
int first;
int second;
{
	fprintf(fp, "$ -- MOD STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[t]); 
	fprintf(fp, "RVALUE %s\n", symtbl[first]); 
	fprintf(fp, "RVALUE %s\n", symtbl[second]);
	fprintf(fp, "RVALUE %s\n", symtbl[first]); 
	fprintf(fp, "RVALUE %s\n", symtbl[second]);
	fprintf(fp, "/\n");
	fprintf(fp, "*\n");
	fprintf(fp, "-\n");
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
void increasestmt(t, first)
int t;
int first;
{
	fprintf(fp, "$ -- INCREASE STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[t]);
	fprintf(fp, "PUSH 1\n");
	fprintf(fp, ":=\n");
	fprintf(fp, "LVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[t]);
	fprintf(fp, "+\n");
	fprintf(fp, ":=\n");
}

void decreasestmt(t, first)
int t;
int first;
{
	fprintf(fp, "$ -- INCREASE STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[t]);
	fprintf(fp, "PUSH 1\n");
	fprintf(fp, ":=\n");
	fprintf(fp, "LVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[t]);
	fprintf(fp, "-\n");
	fprintf(fp, ":=\n");
}

/* 비교 연산 */

void equalstmt(first, second)
int first;
int second;
{
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[second]);
	fprintf(fp, "-\n");
	fprintf(fp, "GOTRUE out%d\n", outcount);
}
void nequalstmt(first, second)
int first;
int second;
{
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[second]);
	fprintf(fp, "-\n");
	fprintf(fp, "GOFALSE out%d\n", outcount);
}
void bthanstmt(first, second)
int first;
int second;
{
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[second]);
	fprintf(fp, "-\n");
	fprintf(fp, "GOMINUS out%d\n", outcount);
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[second]);
	fprintf(fp, "-\n");
	fprintf(fp, "GOFALSE out%d\n", outcount);
}
void sthanstmt(first, second)
int first;
int second;
{
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[second]);
	fprintf(fp, "-\n");
	fprintf(fp, "GOPLUS out%d\n", outcount);
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[second]);
	fprintf(fp, "-\n");
	fprintf(fp, "GOFALSE out%d\n", outcount);
}
void bethanstmt(first, second)
int first;
int second;
{
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[second]);
	fprintf(fp, "-\n");
	fprintf(fp, "GOMINUS out%d\n", outcount);
}
void sethanstmt(first, second)
int first;
int second;
{
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[second]);
	fprintf(fp, "-\n");
	fprintf(fp, "GOPLUS out%d\n", outcount);
}


/* 반복 및 조건 */

void ifstmt()
{
	outcount++;
	ifloop = 1;
	fprintf(fp, "$ -- IF STMT --\n");
}

void whilestmt()
{
	loopcount++;
	outcount++;
	loopmulti = 1;
	fprintf(fp, "$ -- WHILE STMT --\n");
	fprintf(fp, "LABEL loop%d\n", loopcount);
}

void outstmt()
{
	if(switchmix = 0)
	{
		if(ifmulti == 0)
			fprintf(fp, "LABEL out%d\n", outcount);
		else if (ifmulti == 1)
			fprintf(fp, "LABEL out%d\n", outcount - 1);
	}
	else
	{
		if(ifmulti == 0)
			fprintf(fp, "LABEL out%d\n", outcount - switchcount);
		else if (ifmulti == 1)
			fprintf(fp, "LABEL out%d\n", outcount - switchcount - 1);
	}
	ifmulti = 0;
	switchmix = 0;
	switchcount = 0;
}

void loopstmt()
{
	if(switchmix == 0)
	{
		if(loopmulti == 1)
		{
			fprintf(fp, "GOTO loop%d\n", loopcount);
			if(ifloop == 1)
				fprintf(fp, "LABEL out%d\n", outcount - 1);
			else
				fprintf(fp, "LABEL out%d\n", outcount);
		}
		else
		{
			fprintf(fp, "GOTO loop%d\n", loopcount - 1);
			if(ifloop == 1)
				fprintf(fp, "LABEL out%d\n", outcount - 2);
			else
				fprintf(fp, "LABEL out%d\n", outcount - 1);
		}
	}
	else
	{
		if(loopmulti == 1)
		{
			fprintf(fp, "GOTO loop%d\n", loopcount);
			if(ifloop == 1)
				fprintf(fp, "LABEL out%d\n", outcount - switchcount - 1);
			else
				fprintf(fp, "LABEL out%d\n", outcount - switchcount);
		}
		else
		{
			fprintf(fp, "GOTO loop%d\n", loopcount - 1);
			if(ifloop == 1)
				fprintf(fp, "LABEL out%d\n", outcount - switchcount - 2);
			else
				fprintf(fp, "LABEL out%d\n", outcount - switchcount - 1);
		}
	}
	loopmulti = 0;
	switchmix = 0;
	switchcount = 0;
}

void elseifstmt()
{
	outcount++;
	fprintf(fp, "GOTO out%d\n", outcount);
	ifmulti = 1;
}

void breakstmt()
{
	fprintf(fp, "GOTO out%d\n", outcount - 1);
}

void countstmt(t, first)
int t;
int first;
{
	fprintf(fp, "LVALUE %s\n", symtbl[t]);
	fprintf(fp, "PUSH 1\n");
	fprintf(fp, ":=\n");
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[t]); 
	fprintf(fp, "GOFALSE out%d\n", outcount);
	fprintf(fp, "LVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[first]);
	fprintf(fp, "RVALUE %s\n", symtbl[t]);
	fprintf(fp, "-\n");
	fprintf(fp, ":=\n");
}


/* 스위치문 */

void switchstmt(num)
int num;
{
	fprintf(fp, "$ -- SWITCH STMT --\n");
	switchnum = num;
	switchmix = 1;
}

void casestmt(t)
int t;
{
	outcount++;
	switchcount++;
	fprintf(fp, "RVALUE %s\n", symtbl[switchnum]);
	fprintf(fp, "RVALUE %s\n", symtbl[t]);
	fprintf(fp, "-\n");
	fprintf(fp, "GOTRUE out%d\n", outcount);
}

void switchoutstmt()
{
	fprintf(fp, "GOTO BOUT\n");
	fprintf(fp, "LABEL out%d\n", outcount);
}

void switchend()
{
	fprintf(fp, "LABEL BOUT\n");
}



/* 입출력 */

void printstmt(id)
int id;
{
	fprintf(fp, "$ -- PRINT STMT --\n");
	fprintf(fp, "RVALUE %s\n", symtbl[id]);
	fprintf(fp, "OUTNUM\n");
}

void scanstmt(id)
int id;
{
	fprintf(fp, "$ -- SCAN STMT --\n");
	fprintf(fp, "LVALUE %s\n", symtbl[id]);
	fprintf(fp, "INNUM\n");
	fprintf(fp, ":=\n");
}






int gentemp()
{
char buffer[MAXTSYMLEN];
char tempsym[MAXSYMLEN]="TTCBU";

	tsymbolcnt++;
	if (tsymbolcnt > MAXTSYMBOL) printf("temp symbol overflow\n");
	_itoa(tsymbolcnt, buffer, 10);
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

