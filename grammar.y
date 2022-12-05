%language "c"
%skeleton "glr.c" 
%require "3.0.2"
%verbose
%defines 
%locations

%code
{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern void yyerror (char const *);
extern int yylex ();
extern char * yytext;
}

%token T_ID
%token T_NUM
%token T_ADD
%token T_SUB
%token T_MUL
%token T_DIV
%token T_LT
%token T_GT
%token T_LEQ
%token T_GEQ
%token T_EQ
%token T_NEQ
%token T_AND
%token T_OR
%token T_READ
%token T_WRITE
%token T_ASSIGN
%token T_BEGIN
%token T_END
%token T_FOREACH
%token T_IN
%token T_REPEAT
%token T_UNTIL
%token T_WHILE
%token T_IF
%token T_THEN
%token T_ELSE
%token T_DECLARE
%token T_INTEGER
%token T_FLOAT
%token T_LITERAL_STR



%%

program : stmt_list ';' ;

stmt_list : stmt_list ';' stmt
    | stmt
    ;

stmt : assignment
    | read 
    | write
    | while
    | repeat
    | block
    | foreach
    | if_stmt
    ;

block : T_BEGIN stmt_list T_END
  ;

foreach : T_FOREACH 
          T_IN 
          '(' ':' ')' 
          stmt
    ;

while : 
    ;

repeat : 
  ;

if_stmt : 
  ;

else_stmt : 
  |
  ;

assignment : varref T_ASSIGN l_expr ;

// question 2 (4 lines below)
a_expr : a_expr T_ADD a_term 
    | a_expr T_SUB a_term
    | a_term
    ;

a_term : a_term T_MUL a_fact
    | a_term T_DIV a_fact
    | a_fact
    ;

a_fact : 
    | 
    | 
    | 
    | 
    ;

varref : 
  | 
  ;

l_expr : l_expr T_AND l_term
  | l_term
  ;

l_term : l_term T_OR l_fact
  | l_fact
  ;
  
// question 3 (4 lines below) use oprel ???
l_fact : l_fact AND l_expr
  | l_fact oprel l_expr
  | (l_expr)
  ;


oprel : T_LT
  | T_GT
  | T_LEQ
  | T_GEQ
  | T_EQ
  | T_NEQ
  ;

//qustion 1 (one line)
read : T_READ varlist ;

write: T_WRITE expr_list;

//question 1 (3 lines below) varref
varlist : T_READ
      | n -> value =$1
      ;
      
//question 2 (3 lines below)
expr_list : 
  | n -> value = $1
  ;

%%

//void yyerror (YYLTYPE * loc, char const * msg)
void yyerror (char const * msg)
{
  #ifndef PL_GRADER
  printf ("Found error: %s (line %d, column %d)\n",
    yytext, yylloc.last_line, yylloc.last_column);
  #endif
}
