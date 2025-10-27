%{
#include "demo.tab.h"
#include<stdlib.h>
%}

%%

"for" {return FOR;}
"(" {return LPAREN;}
")" {return RPAREN;}

[a-zA-Z_][a-zA-Z0-9_]* {return VAR;}
"=" {return EQ;}
[0-9][0-9]* {return NUM;}
";" {return SEMICOLON;}
"<" {return RELOP;}
">"	{return RELOP;}
"{"  {return LCURL;}
"}"  {return RCURL;}
"++" {return INCREMENT;}
[+\-*/] {return OPERATOR;}
[ \t] ;
[\n] return 0;

%%

int yywrap()
{
return 1;
}

%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int valid=1;
int yyerror(char *s);
int yylex(void);
int yyparse();
%}

%token FOR LPAREN RPAREN LCURL RCURL VAR RELOP SEMICOLON OPERATOR NUM EQ INCREMENT

%%
start :
	FOR LPAREN init condn inc RPAREN LCURL start RCURL
|
	;
	
init:  VAR EQ NUM SEMICOLON
	| VAR EQ VAR SEMICOLON
;
condn:
	VAR RELOP NUM SEMICOLON
	| VAR RELOP VAR SEMICOLON
;
inc:
	VAR INCREMENT 
| VAR  RELOP VAR OPERATOR NUM 
;


%%

int main()
{
	yyparse();
if(valid==1) printf("valid");
return 0;
}
int yyerror(char *s)
{
valid=0;
	printf("error");
}
