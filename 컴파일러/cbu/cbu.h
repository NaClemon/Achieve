
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ADD = 258,
     SUB = 259,
     MULTI = 260,
     DIV = 261,
     OF = 262,
     POW = 263,
     ROOT = 264,
     IF = 265,
     THEN = 266,
     IS = 267,
     CONAND = 268,
     WHILE = 269,
     EQUAL = 270,
     NEQUAL = 271,
     BIGTHAN = 272,
     SMALLTHAN = 273,
     ASSGN = 274,
     STMTEND = 275,
     START = 276,
     END = 277,
     ID = 278,
     NUM = 279,
     INCOPE = 280,
     DECOPE = 281,
     STARTLOOP = 282,
     LBRA = 283,
     RBRA = 284,
     BIGETHAN = 285,
     SMALLETHAN = 286,
     MOD = 287,
     AND = 288,
     OR = 289,
     ADDASSGN = 290,
     SUBASSGN = 291,
     MULASSGN = 292,
     DIVASSGN = 293
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


