%{
#include <stdio.h>
#include <stdlib.h>

FILE *yyin;

int yylex();
int yyerror();
%}

%token FIN_SENTENCIA
%token CHAR_COMA
%token CONST_INTEGER
%token CONST_FLOAT
%token CONST_CADENA

%token OP_SUMA
%token OP_RESTA
%token OP_DIV
%token OP_MULT
%token OP_IGUAL
%token OP_MAYOR
%token OP_MENOR
%token OP_MAYORIGUAL
%token OP_MENORIGUAL
%token OP_COMP_IGUAL
%token OP_NEGACION
%token OP_DISTINTO
%token OP_ASIGNACION
%token OP_DOSPUNTOS

%token LLAVE_A
%token LLAVE_C
%token PARENTESIS_A
%token PARENTESIS_C
%token CORCHETE_A
%token CORCHETE_C
%token IF
%token ELSE
%token ENDIF
%token WHILE
%token INTEGER
%token FLOAT
%token WRITE
%token DISPLAY
%token GET
%token AND
%token OR
%token NOT
%token DIM
%token AS
%token IDENTIFICADOR

%%
s: programa FIN_SENTENCIA;
programa: DIM OP_MENOR l_asig OP_MAYOR;
l_asig: OP_MAYOR AS OP_MENOR;
l_asig: IDENTIFICADOR l_asig INTEGER|FLOAT;
%%

 
int main(int argc,char *argv[])
{
  if ((yyin = fopen(argv[1], "rt")) == NULL)
  {
	printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
  }
  else
  {
	yyparse();
  }
  fclose(yyin);
  getchar();
  return 0;
}