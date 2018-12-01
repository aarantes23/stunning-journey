package lexico;

import static lexico.Tokens.*;
%%

%class Lexer 
%type Tokens

white = [ \n\t\r]
primeiro = [a-z||A-Z||_]
seguintes = [0-9||a-z||A-Z||_]
numeros = [0-9]
strings = [!||%||'-?||A-}||\t|| ]
io = [!||'-?||A-}||\t|| ]

%{
public String lexeme;
%}

%%

/*expressoes regulares com palavras reservadas e combinacoes para identificadores*/

("#include") {lexeme=yytext(); return INCLUDE;}
("#define") {lexeme=yytext(); return DEFINE;}
("int") {lexeme=yytext(); return INT;}
("double") {lexeme=yytext(); return DOUBLE;}
("void") {lexeme=yytext(); return VOID;}
("char") {lexeme=yytext(); return CHAR;}
("float") {lexeme=yytext(); return FLOAT;}
("if") {lexeme=yytext(); return IF;}
("else") {lexeme=yytext(); return ELSE;}
("&&") {lexeme=yytext(); return AND;}
("||") {lexeme=yytext(); return OR;}
("!") {lexeme=yytext(); return NOT;}
("==") {lexeme=yytext(); return EQUALS;}
("=") {lexeme=yytext(); return IGUAL;}
("(") {lexeme=yytext(); return ABRE_PARENTESES;}
(")") {lexeme=yytext(); return FECHA_PARENTESES;}
("<") {lexeme=yytext(); return MENOR;}
(">") {lexeme=yytext(); return MAIOR;}
("!=") {lexeme=yytext(); return DIFERENTE;}
(">=") {lexeme=yytext(); return MAIOR_IGUAL;}
("<=") {lexeme=yytext(); return MENOR_IGUAL;}
(",") {lexeme=yytext(); return VIRGULA;}
("+") {lexeme=yytext(); return ADICAO;}
("-") {lexeme=yytext(); return SUBTRACAO;}
("*") {lexeme=yytext(); return MULTIPLICACAO;}
("/") {lexeme=yytext(); return DIVISAO;}
(";") {lexeme=yytext(); return PONTO_E_VIRGULA;}
("{") {lexeme=yytext(); return ABRE_CHAVES;}
("}") {lexeme=yytext(); return FECHA_CHAVES;}
("scanf") {lexeme=yytext(); return SCANF;}
("printf") {lexeme=yytext(); return PRINTF;}
("\n") {lexeme=yytext(); return NOVA_LINHA;}
("\t") {lexeme=yytext(); return TAB;}
("return") {lexeme=yytext(); return RETURN;}
("main") {lexeme=yytext(); return MAIN;}
("&") {lexeme=yytext(); return ASSOCIACAO;}
("%d") {lexeme=yytext(); return IO_INT;}
("%f") {lexeme=yytext(); return IO_FLOAT;}
("%c") {lexeme=yytext(); return IO_CHAR;}
("%") {lexeme=yytext(); return PORCENTAGEM;}
("<stdio.h>") {lexeme=yytext(); return BIBLIOTECA_STDIO;}
("while") {lexeme=yytext(); return WHILE;}

/* ( \"{io}*%d{io}*\" ) {lexeme="%d"; return IO_INT;} */
( \"{strings}*\" ) {lexeme=yytext(); return STRING;}

/* Nesse contexto de declaracoes de numeros sao reconhecidas */
( -?{numeros}{numeros}*.*{numeros}* ) {lexeme=yytext(); return NUMERO;}

/* Nesse contexto identificadores com mais de 255 caracteres sao erro*/
( {primeiro}{seguintes}{0,254} ) {lexeme=yytext(); return IDENTIFICADOR;}
( {primeiro}{seguintes}{0,254}{seguintes}+ ) {lexeme=yytext(); return ERRO;}
 
{white} {}

/* O . (ponto) considera apenas um caractere por vez */
. {return ERRO;} 