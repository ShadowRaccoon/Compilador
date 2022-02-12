%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

FILE *yyin;

int yyerror(void);
%}

/* SECCION DE OPCIONES */
/* Esto indica al flex que solo lea un fichero de entrada */
%option noyywrap
/* Nos permite obtener el numero de linea */
%option yylineno

/* SECCION DE TOKENS */
DIGITO          [0-9]
LETRA           [a-zA-Z]
ESPACIO         " "
INI_COMENTARIO  "*/"
FIN_COMENTARIO  "/*"
CHAR_COMA       ","
CHAR_PUNTO      "."
CHAR_DOSPUNTOS  ":"

IDENTIFICADOR     {LETRA}({LETRA}|{DIGITO}|"_")*
CONST_INTEGER     (-?[1-9].(DIGITO)*)|0
CONST_FLOAT       (DIGITO){0,8}.(CHAR_PUNTO).(DIGITO){1,8}
/* La regla de abajo considera string  a todo lo que este dentro de comillas doble excepto el caracter de fin de linea y la propia comilla doble */
CONST_CADENA      \"[^\n"]*\"

/* OPERADORES LOGICOS Y OPERADORES ARITMETICOS BASICOS */
OP_SUMA         "+"
OP_RESTA        "-"
OP_MULT         "*"
OP_DIV          "/"
OP_IGUAL        "="
OP_MAYOR        ">"
OP_MENOR        "<"
OP_MAYORIGUAL   ">="
OP_MENORIGUAL   "<="
OP_COMP_IGUAL   "=="
OP_NEGACION     "!"
OP_DISTINTO     "!="
OP_ASIGNACION   ":="
/* Tiene doble funcionalidad, definir un tipo de datos o asignar valor*/
OP_DOSPUNTOS    ":"

/* Caracteres de apertura, cierre y fin de sentencia */
LLAVE_A         "{"
LLAVE_C         "}"
PARENTESIS_A    "("
PARENTESIS_C    ")"
CORCHETE_A      "\["
CORCHETE_C      "\]"
FIN_SENTENCIA   ";"


/* PALABRAS RESERVADAS */
IF        "if"|"IF"|"If"
ELSE      "ELSE"|"else"|"Else"
ENDIF     "ENDIF"|"endif"|"Endif"
WHILE     "while"|"WHILE"
DECVAR    "DECVAR"
ENDDEC    "ENDDEC"
INTEGER   "INGETER"|"Integer"
FLOAT     "FLOAT"|"Float"
WRITE     "WRITE"|"write"
DISPLAY   "DISPLAY"
GET       "GET"
NOT       "NOT"|"not"|"Not"
AND       "AND"|"and"|"And"
OR        "OR"|"or"|"Or"
DIM       "DIM"
AS        "AS"
CONTAR        "CONTAR"

/* SECCION REGLAS: (Patron y accion semantica (Bloque de codigo que se ejecuta al detectar un patron) ) */
/* Aca es importante el orden, donde se va a ir buscando el patron y ejecutando la accion en orden secuencial,*/
/*   si una regla hace match pasa al siguiente token y puede que la regla siguiente era lo que yo queria matchear*/
/*   Ej: Si pongo la regla del IDENTIFICADOR primero no va llegar a las reglas de las palabras reservadas */

%%

{FIN_SENTENCIA}   {printf("\nFIN_SENTENCIA (%s)",yytext); return FIN_SENTENCIA;}
{CHAR_COMA}       {printf("\nCHAR_COMA (%s)",yytext); return CHAR_COMA;}
{CONST_INTEGER}   {printf("\ncONST_INTEGER (%s)",yytext); return CONST_INTEGER;}
{CONST_FLOAT}     {printf("\nCONST_FLOAT (%s)",yytext); return CONST_FLOAT;}
{CONST_CADENA}    {printf("\nCONST_CADENA (%s)",yytext); return CONST_CADENA;}

{OP_SUMA}         {printf("\nOP_SUMA (%s)",yytext); return OP_SUMA;}
{OP_RESTA}        {printf("\nOP_RESTA (%s)",yytext); return OP_RESTA;}
{OP_DIV}          {printf("\nOP_DIV (%s)",yytext); return OP_DIV;}
{OP_MULT}         {printf("\nOP_MULT (%s)",yytext); return OP_MULT;}
{OP_IGUAL}        {printf("\nOP_IGUAL (%s)",yytext); return OP_IGUAL;}
{OP_MAYOR}        {printf("\nOP_MAYOR (%s)",yytext); return OP_MAYOR;}
{OP_MENOR}        {printf("\nOP_MENOR (%s)",yytext); return OP_MENOR;}
{OP_MAYORIGUAL}   {printf("\nOP_MAYORIGUAL (%s)",yytext); return OP_MAYORIGUAL;}
{OP_MENORIGUAL}   {printf("\nOP_MENORIGUAL (%s)",yytext); return OP_MENORIGUAL;}
{OP_COMP_IGUAL}   {printf("\nOP_COMP_IGUAL (%s)",yytext); return OP_COMP_IGUAL;}
{OP_NEGACION}     {printf("\nOP_NEGACION (%s)",yytext); return OP_NEGACION;}
{OP_DISTINTO}     {printf("\nOP_DISTINTO (%s)",yytext); return OP_DISTINTO;}
{OP_ASIGNACION}    {printf("\nOP_ASIGNACION (%s)",yytext); return OP_ASIGNACION;}
{OP_DOSPUNTOS}    {printf("\nOP_DOSPUNTOS (%s)",yytext); return OP_DOSPUNTOS;}

{LLAVE_A}         {printf("\nLLAVE_A (%s)",yytext); return LLAVE_A;}
{LLAVE_C}         {printf("\nLLAVE_C (%s)",yytext); return LLAVE_C;}
{PARENTESIS_A}    {printf("\nPARENTESIS_A (%s)",yytext); return PARENTESIS_A;}
{PARENTESIS_C}    {printf("\nPARENTESIS_C (%s)",yytext); return PARENTESIS_C;}
{CORCHETE_A}      {printf("\nCORCHETE_A (%s)",yytext); return CORCHETE_A;}
{CORCHETE_C}      {printf("\nCORCHETE_C (%s)",yytext); return CORCHETE_C;}

{IF}              {printf("\nIF (%s)",yytext); return IF;}
{ELSE}            {printf("\nELSE (%s)",yytext); return ELSE;}
{ENDIF}           {printf("\nENDIF (%s)",yytext); return ENDIF;}
{WHILE}           {printf("\nWHILE (%s)",yytext); return WHILE;}
{INTEGER}         {printf("\nINTEGER (%s)",yytext); return INTEGER;}
{FLOAT}           {printf("\nFLOAT (%s)",yytext); return FLOAT;}
{WRITE}           {printf("\nWRITE (%s)",yytext); return WRITE;}
{DISPLAY}         {printf("\nDISPLAY (%s)",yytext); return DISPLAY;}
{GET}             {printf("\nGET (%s)",yytext); return GET;}
{AND}             {printf("\nAND (%s)",yytext); return AND;}
{OR}              {printf("\nOR (%s)",yytext); return OR;}
{NOT}             {printf("\nNOT (%s)",yytext); return NOT;}
{DIM}             {printf("\nDIM (%s)",yytext); return DIM;}
{AS}              {printf("\nAS (%s)",yytext); return AS;}

{IDENTIFICADOR}   { yylval.strVal = strdup(yytext); printf("\nIDENTIFICADOR (%s)",yytext); return IDENTIFICADOR;}

"\n"
"\t"
" "
.                 yyerror(); /* Si llego aca es porque no encontro ningun regex o token que matchee con el caracter leido por FLEX */
%%

int main(int argc, char *argv[]){
  /*Abro el archivo en modo lectura y dejo apuntado el puntero yyvin que nos piden FLEX alli*/
  if((yyin = fopen(argv[1],"rt")) == NULL){
    printf("\n No se puede abrir el archivo: %s\n",argv[1]);
    return 1;
  }

  printf("\nEl archivo %s se abrio correctamente\n",argv[1]);
  yylex();
  yyparse();

  printf("\nFLEX finalizo la lectura del archivo %s \n",argv[1]);
  fclose(yyin);
  return 0;
}

int yyerror(void){
  printf("\nError lexico: Caracter invalido: %s, saliendo ... \n",yytext);
  exit(1);
}
