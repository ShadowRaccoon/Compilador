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
ESPACIO         [" "]
INI_COMENTARIO  ["*/"]
FIN_COMENTARIO  ["/*"]
GUIONES         [-_]
CHAR_COMA       [","]
CHAR_PUNTO      ["."]
CHAR_PUNTOYCOMA [";"]
CHAR_DOSPUNTOS  [":"]

IDENTIFICADOR     {LETRA}({LETRA}|{DIGITO}|{GUIONES})*
CONST_INTEGER     (-?[1-9]{0,4})|0
CONST_FLOAT       {DIGITO}{0,8}{CHAR_PUNTO}{DIGITO}{1,8}
/* La regla de abajo considera string  a todo lo que este dentro de comillas doble excepto el caracter de fin de linea y la propia comilla doble */
CONST_CADENA      \"[^\n"]*\"

/* OPERADORES LOGICOS Y OPERADORES ARITMETICOS BASICOS */
OP_SUMA         ["+"]
OP_RESTA        ["-"]
OP_MULT         ["*"]
OP_DIV          ["/"]
OP_IGUAL        ["="]
OP_MAYOR        [">"]
OP_MENOR        ["<"]
OP_MAYORIGUAL   ">="
OP_MENORIGUAL   "<="
OP_COMP_IGUAL   "=="
OP_NEGACION     "!"
OP_DISTINTO     "!="
/* Tiene doble funcionalidad, definir un tipo de datos o asignar valor*/
OP_DOSPUNTOS    [":"]

/* Caracteres de apertura, cierre y fin de sentencia */
LLAVE_A         ["{"]
LLAVE_C         ["}"]
PARENTESIS_A    ["("]
PARENTESIS_C    [")"]
CORCHETE_A      ["\["]
CORCHETE_C      ["\]"]
PICO_A          ["<"]
PICO_C          [">"]
FIN_SENTENCIA   [";"]


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

/* SECCION REGLAS: (Patron y accion semantica (Bloque de codigo que se ejecuta al detectar un patron) ) */
/* Aca es importante el orden, donde se va a ir buscando el patron y ejecutando la accion en orden secuencial,
   si una regla hace match pasa al siguiente token y puede que la regla siguiente era lo que yo queria matchear
   Ej: Si pongo la regla del IDENTIFICADOR primero no va llegar a las reglas de las palabras reservadas */

%%

{FIN_SENTENCIA}   {printf("\nFIN_SENTENCIA (%s)",yytext);}
{CHAR_COMA}       {printf("\nCHAR_COMA (%s)",yytext);}
{CHAR_PUNTOYCOMA} {printf("\nCHAR_PUNTOYCOMA (%s)",yytext);}
{CONST_INTEGER}   {printf("\ncONST_INTEGER (%s)",yytext);}
{CONST_FLOAT}     {printf("\nCONST_FLOAT (%s)",yytext);}
{CONST_CADENA}    {printf("\nCONST_CADENA (%s)",yytext);}

{OP_SUMA}         {printf("\nOP_SUMA (%s)",yytext);}
{OP_RESTA}        {printf("\nOP_RESTA (%s)",yytext);}
{OP_DIV}          {printf("\nOP_DIV (%s)",yytext);}
{OP_MULT}         {printf("\nOP_MULT (%s)",yytext);}
{OP_IGUAL}        {printf("\nOP_IGUAL (%s)",yytext);}
{OP_MAYOR}        {printf("\nOP_MAYOR (%s)",yytext);}
{OP_MENOR}        {printf("\nOP_MENOR (%s)",yytext);}
{OP_MAYORIGUAL}   {printf("\nOP_MAYORIGUAL (%s)",yytext);}
{OP_MENORIGUAL}   {printf("\nOP_MENORIGUAL (%s)",yytext);}
{OP_COMP_IGUAL}   {printf("\nOP_COMP_IGUAL (%s)",yytext);}
{OP_NEGACION}     {printf("\nOP_NEGACION (%s)",yytext);}
{OP_DISTINTO}     {printf("\nOP_DISTINTO (%s)",yytext);}
{OP_DOSPUNTOS}    {printf("\nOP_DOSPUNTOS (%s)",yytext);}

{LLAVE_A}         {printf("\nLLAVE_A (%s)",yytext);}
{LLAVE_C}         {printf("\nLLAVE_C (%s)",yytext);}
{PARENTESIS_A}    {printf("\nPARENTESIS_A (%s)",yytext);}
{PARENTESIS_C}    {printf("\nPARENTESIS_C (%s)",yytext);}
{CORCHETE_A}      {printf("\nCORCHETE_A (%s)",yytext);}
{CORCHETE_C}      {printf("\nCORCHETE_C (%s)",yytext);}
{PICO_A}          {printf("\nPICO_A (%s)",yytext);}
{PICO_C}          {printf("\nPICO_C (%s)",yytext);}

{IF}              {printf("\nIF (%s)",yytext);}
{ELSE}            {printf("\nELSE (%s)",yytext);}
{ENDIF}           {printf("\nENDIF (%s)",yytext);}
{WHILE}           {printf("\nWHILE (%s)",yytext);}
{INTEGER}         {printf("\nINTEGER (%s)",yytext);}
{FLOAT}           {printf("\nFLOAT (%s)",yytext);}
{WRITE}           {printf("\nWRITE (%s)",yytext);}
{DISPLAY}         {printf("\nDISPLAY (%s)",yytext);}
{GET}             {printf("\nGET (%s)",yytext);}
{AND}             {printf("\nAND (%s)",yytext);}
{OR}              {printf("\nOR (%s)",yytext);}
{NOT}             {printf("\nNOT (%s)",yytext);}
{DIM}             {printf("\nDIM (%s)",yytext);}
{AS}              {printf("\nAS (%s)",yytext);}

{IDENTIFICADOR}   {printf("\nIDENTIFICADOR (%s)",yytext);}

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
  else{
    printf("\nEl archivo %s se abrio correctamente\n",argv[1]);
    yylex();
  }
  printf("\nFLEX finalizo la lectura del archivo %s \n",argv[1]);
  fclose(yyin);
  return 0;
}

int yyerror(void){
printf("Error lexico: Caracter invalido: %s, saliendo ... \n",yytext);
exit(1);
}
