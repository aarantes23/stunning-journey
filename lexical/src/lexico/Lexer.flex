package lexico;

import static lexico.Tokens.*;
%%

%class Lexer 
%type Tokens
// Faz contagem de linhas disponivel via a variavel yyline
%line
// Faz contagem de colounas disponivel via a variavel yycolumn
%column
// Estados
%state COMENTARIO
%state CODIGO
%state STRING
%state END
// Inicialização
%init{
    initialize();
%init}

%{
  private String blockString = "";

  private Token token(TokenType type) {
        return new Token(type, yyline+1, yycolumn+1);
  }

  private void initialize(){ yybegin(CODIGO); }

%}
// Tipos de números, essa definição foi necessária para identificar se o número digitado 
// pelo usuário era Int, Float

// Digitos em base Octal
OCTAL                       =   [0-7]
// Digitos em base Decimal
DECIMAL                     =   [0-9]
// Numeros "não zero"
NOT_ZERO                    =   [1-9]
// Letras
LETRAS                      =   [a-zA-Z_]
// Alfabeto e base decimal
ALFANUMERICO                =   [a-zA-Z_0-9]
// Base Hexadecimal
HEXADECIMAL                 =   [a-fA-F0-9]
// Prefixo Hexadecimal 
HEXADECIMAL_PREFIX          =   (0[xX])
// Exponenciacao 
EXPONENT                    =   ([Ee][+-]?{DECIMAL}+)
// Power ~= Exponenciacao Hexadecimal 
POWER                       =   ([Pp][+-]?{DECIMAL}+)
// Constante de Float
FLOAT_SUFFIX                =   (f|F|l|L)
// Indefinido ou Long
INTEGER_SUFFIX              =   (((u|U)(l|L|ll|LL)?)|((l|L|ll|LL)(u|U)?))
// Prefixo Char 
CHAR_PREFIX           =   (u|U|L)
// Prefixo String 
STRING_PREFIX               =   (u8|u|U|L)
// Sequencias de escape
ESCAPE_SEQUENCE             =   ( (\\([\'\"\?\\abfnrtv]|[0-7]{1,3}|x[a-fA-F0-9]+)) | \R )
// Sequencias de caracteres em branco
SEQUENCIA_EM_BRANCO        =   ( [ \t\v\n\f] | \R )

%%
/*Regras*/

<STRING>{
        // String não são identificadores, são : ("Exemplo de String")
        // Pagina 23 , topico 3 
        ([^]*(\\\R)?)*\"    { yybegin(CODIGO); return token(STRING_LITERAL);}
        \R                  { yybegin(CODIGO); return token(STRING_ABERTA_ERRO); }
        [^]                 {  }
}

// Define o que são comentários 
<COMENTARIO>{
        "*/"                { yybegin(CODIGO); }
        <<EOF>>             { yybegin(END); return token(COMENTARIO_ABERTO_ERRO); }
        [^]                 {  }
}

<CODIGO> {

        // Para acelerar o desenvolvimento e para uma melhor leitura , 
        // foram definidos grupos para cada classe

        // Pre-processamento, exemplo, bibliotecas
        "/*"                { yybegin(COMENTARIO); }
        "//".*              { /* Ignore */ }
        "#".*               { /* Ignore */ }

        // Palavras reservadas, 
        "auto"                      |
        "break"                     |
        "case"			    |
        "char"			    |
        "const"			    |
        "continue"		    |
        "default"		    |
        "do"			    |
        "double"		    |
        "else"			    |
        "enum"			    |
        "extern"		    |
        "float"			    |
        "for"			    |
        "goto"			    |
        "if"			    |
        "inline"		    |
        "int"			    |
        "long"			    |
        "main"                      |
        "printf"                    |
        "register"		    |
        "restrict"		    |
        "return"		    |
        "scanf"                     |
        "short"			    |
        "signed"		    |
        "sizeof"		    |
        "static"		    |
        "struct"		    |
        "switch"		    |
        "typedef"		    |
        "union"			    |
        "unsigned"		    |
        "void"			    |
        "volatile"		    |
        "while"                                                                 { return token(PALAVRA_RESERVADA); }

        // Identificadores
        // Permite que o identificador comece por um sublinhado, paginas 23 a 25 do manual jflex em pdf 
        // definição de 255 é padrão do jflex, vide pagina 32 do manual em pdf
        {LETRAS}{ALFANUMERICO}*                                                 { return token(IDENTIFICADOR); }

        // Char 
        {CHAR_PREFIX}?"'"([^'\\\n]|{ESCAPE_SEQUENCE})+"'"		        { return token(CHAR_LITERAL); }

        // Inteiros
        {HEXADECIMAL_PREFIX}{HEXADECIMAL}+{INTEGER_SUFFIX}?			{ return token(INTEGER_LITERAL); }
        {NOT_ZERO}{DECIMAL}*{INTEGER_SUFFIX}?				        { return token(INTEGER_LITERAL); }
        "0"{OCTAL}*{INTEGER_SUFFIX}?				                { return token(INTEGER_LITERAL); }

        // Floats
        {DECIMAL}+{EXPONENT}{FLOAT_SUFFIX}?				        { return token(FLOAT_LITERAL); }
        {DECIMAL}*"."{DECIMAL}+{EXPONENT}?{FLOAT_SUFFIX}?			{ return token(FLOAT_LITERAL); }
        {DECIMAL}+"."{EXPONENT}?{FLOAT_SUFFIX}?			                { return token(FLOAT_LITERAL); }
        {HEXADECIMAL_PREFIX}{HEXADECIMAL}+{POWER}{FLOAT_SUFFIX}?		{ return token(FLOAT_LITERAL); }
        {HEXADECIMAL_PREFIX}{HEXADECIMAL}*"."{HEXADECIMAL}+{POWER}{FLOAT_SUFFIX}?	        { return token(FLOAT_LITERAL); }
        {HEXADECIMAL_PREFIX}{HEXADECIMAL}+"."{POWER}{FLOAT_SUFFIX}?		{ return token(FLOAT_LITERAL); }

        // Strings
        ({STRING_PREFIX}?\"([^\"\\\n]|{ESCAPE_SEQUENCE})*\"{SEQUENCIA_EM_BRANCO}*)+	        { return token(STRING_LITERAL); }
        \"                      { yybegin(STRING); }

        // Operadores
        "..."					|
        ">>="					|
        "<<="					|
        "+="					|
        "-="					|
        "*="					|
        "/="					|
        "%="					|
        "&="					|
        "^="					|
        "|="					|
        ">>"					|
        "<<"					|
        "++"					|
        "--"					|
        "->"					|
        "&&"					|
        "||"					|
        "<="					|
        ">="					|
        "=="					|
        "!="					|
        ";"					|
        ("{"|"<%")				|
        ("}"|"%>")				|
        ","					|
        ":"					|
        "="					|
        "("					|
        ")"					|
        ("["|"<:")				|
        ("]"|":>")				|
        "."					|
        "&"					|
        "!"					|
        "~"					|
        "-"					|
        "+"					|
        "*"					|
        "/"					|
        "%"					|
        "<"					|
        ">"					|
        "^"					|
        "|"					|
        "?"					{ return token(OPERADOR); }

        // Limite
        {SEQUENCIA_EM_BRANCO} {} // whitespace separates tokens  
        . { return token(CHAR_INVALIDO_ERRO); }
}

<END>{
       .     					                                                            { /* Ignore */ }
}