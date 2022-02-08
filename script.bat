@echo off
C:\GnuWin32\bin\flex "C:\Users\rocio\OneDrive\Escritorio\Lenguajes y Compiladores\Lexico.l"
echo "FLEX Compilo la especificacion lexica del archivo Lexico.l (Se creo un archivo lex.yy.c)"
pause
C:\MinGW\bin\gcc.exe lex.yy.c -o Compilado.exe
echo "Finalizo la ejecucion del compilador de C sobre el archivo lex.yy.c (Se creo un archivo Compilado.exe)"
pause
Compilado.exe Prueba.txt
echo "Se ejecuto el analizador lexico sobre el archivo Prueba.txt"
del lex.yy.c
del Compilado.exe
echo "Se borraron los archivos generados en todo este proceso, finalizando..."
pause
