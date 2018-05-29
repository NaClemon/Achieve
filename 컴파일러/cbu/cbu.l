%{
#include <string.h>
#include "cbu.h"
#define MAXSYM	100
#define	MAXSYMLEN	20
char symtbl[MAXSYM][MAXSYMLEN];
int lineno=1;
int insertsym();
int maxsym=0;
char s[30];

%}
sp		[ \t]
ws		{sp}+
nl		\n
eletter		[A-Za-z]
hletter		[\xb0-\xfe][\xa0-\xfe]
letter		({eletter}|{hletter})
digit		[0-9]
id			{letter}({letter}|{digit})*
%%
{ws}		{/* do nothing */}
{nl}		{lineno++; }
더하기			{return(ADD); }
빼기			{return(SUB);}
곱하기			{return(MULTI);}
나누기			{return(DIV);}
나머지			{return(MOD);}
의			{return(OF);}
제곱			{return(POW);}
루트			{return(ROOT);}
만약			{return(IF);}
면			{return(THEN);}
가			{return(IS);}
이			{return(IS);}
와			{return(CONAND);}
과			{return(CONAND);}
그리고			{return(AND);}
또는			{return(OR);}
증가			{return(INCOPE);}
감소			{return(DECOPE);}
일동안			{return(WHILE);}
같다			{return(EQUAL);}
다르다			{return(NEQUAL);}
보다크다		{return(BIGTHAN);}
보다작다		{return(SMALLTHAN);}
보다크거나같다	{return(BIGETHAN);}
보다작거나같다	{return(SMALLETHAN);}
는			{return(ASSGN); }
더하기는		{return(ADDASSGN);}
빼기는			{return(SUBASSGN);}
곱하기는		{return(MULASSGN);}
나누기는		{return(DIVASSGN);}
반복			{return(STARTLOOP);}
번			{return(COUNT);}
;			{return(STMTEND); }
시작			{return(START);}
"("			{return(LBRA);}
")"			{return(RBRA);}
끝			{return(END);}
{id}		{strncpy(s, yytext, yyleng); s[yyleng]='\0'; yylval=insertsym(s); return(ID);}
{digit}+	{sscanf(yytext, "%d", &yylval); return(NUM);}
.			{printf("invalid token %s\n", yytext); }
%%

int insertsym(s)
char *s;
{
int i;

	for(i=0;i<maxsym; i++) {
		if(strcmp(s, symtbl[i])==0) return(i);
		}
	if (i<MAXSYM-1) {
		strcpy(symtbl[maxsym],s);
		maxsym++;
		return(maxsym-1);
		}
	else
		{printf("symbol table overflow\n");}
	return(0);
}

yywrap() {}