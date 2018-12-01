import java_cup.runtime.Symbol;

%%
%class Yylex 
%cup
%full
%line
%state COMMENT


%eofval{
	return new Symbol(sym.EOF,new String("Fim do arquivo"));
%eofval}

/* Inteiros */
INTEIRO=[0-9]+

/* palavras IDENTIFICADOR*/
IDENTIFICADOR=[_a-zA-Z][_a-zA-Z0-9]*

/* quebra de linha e tab */
QUEBRA=[ \t\r\n]

/* comentario */
COMENTARIO= "/*" + [ \t\r\n]* ~"*/" | "/*" "*"+ "/" | \{[^}]*\}

/*Strings */ 
STRING = "\"" + [ \t\r\n]* ~"\""

/*Invalido */ 
INVALIDO=[0-9a-zA-Z]*





%% 

 "+"       { System.out.print(" + "); return new Symbol(sym.MAIS, yychar, yyline, yytext());}
 "-"       { System.out.print(" - "); return new Symbol(sym.MENOS, yychar, yyline, yytext());}
 "*"       { System.out.print(" * "); return new Symbol(sym.MULT, yychar, yyline, yytext());}
 "/"       { System.out.print(" / "); return new Symbol(sym.DIVI, yychar, yyline, yytext());} 
 "("       { System.out.print(" ( "); return new Symbol(sym.A_PARENTESE, yychar, yyline, yytext());} 
 ")"       { System.out.print(" ) "); return new Symbol(sym.F_PARENTESE, yychar, yyline, yytext());}
 ","       { System.out.print(" , "); return new Symbol(sym.VIRGULA, yychar, yyline, yytext());} 
 ";"       { System.out.print(" ;\n "); return new Symbol(sym.PONTO_VIRGULA, yychar, yyline, yytext());}
 "="       { System.out.print(" = "); return new Symbol(sym.ATR, yychar, yyline, yytext());}
 "<"       { System.out.print(" < "); return new Symbol(sym.MENOR, yychar, yyline, yytext());}
 "<="      { System.out.print(" <= "); return new Symbol(sym.MENOR_IGUAL, yychar, yyline, yytext());}
 "=="      { System.out.print(" == "); return new Symbol(sym.IGUAL, yychar, yyline, yytext());}
 ">="      { System.out.print(" >= "); return new Symbol(sym.MAIOR_IGUAL, yychar, yyline, yytext());} 
 ">"       { System.out.print(" > "); return new Symbol(sym.MAIOR, yychar, yyline, yytext());} 
 "<>"      { System.out.print(" <> "); return new Symbol(sym.DIFERENTE, yychar, yyline, yytext());} 

 "begin" { System.out.print(" begin\n "); return new Symbol(sym.BEGIN, yychar, yyline, yytext());} 
 "end"   { System.out.print(" end\n "); return new Symbol(sym.END, yychar, yyline, yytext());}
 "int"   { System.out.print(" int "); return new Symbol(sym.INT, yychar, yyline, yytext());} 
 "byte"  { System.out.print(" byte "); return new Symbol(sym.BYTE, yychar, yyline, yytext());} 
 "string"  { System.out.print(" string "); return new Symbol(sym.STRING, yychar, yyline, yytext());} 
 "boolean" { System.out.print(" boolean "); return new Symbol(sym.BOOLEAN, yychar, yyline, yytext());} 
 "true"    { System.out.print(" true "); return new Symbol(sym.LIT_BOOLEANO, yychar, yyline, yytext());}
 "false"   { System.out.print(" false "); return new Symbol(sym.LIT_BOOLEANO, yychar, yyline, yytext());} 
 "final"   { System.out.print(" final "); return new Symbol(sym.FINAL, yychar, yyline, yytext());}
 "write"   { System.out.print(" write "); return new Symbol(sym.WRITE, yychar, yyline, yytext());}
 "writeln" { System.out.print(" writeln "); return new Symbol(sym.WRITELN, yychar, yyline, yytext());} 
 "readln"  { System.out.print(" readln "); return new Symbol(sym.READLN, yychar, yyline, yytext());}
 "and"     { System.out.print(" and "); return new Symbol(sym.AND, yychar, yyline, yytext());} 
 "or"      { System.out.print(" or "); return new Symbol(sym.OR, yychar, yyline, yytext());}
 "not"     { System.out.print(" not "); return new Symbol(sym.NOT, yychar, yyline, yytext());}
 "while"   { System.out.print(" while "); return new Symbol(sym.WHILE, yychar, yyline, yytext());} 
 "if"      { System.out.print(" if "); return new Symbol(sym.IF, yychar, yyline, yytext());}
 "else"    { System.out.print(" else "); return new Symbol(sym.ELSE, yychar, yyline, yytext());}

 {IDENTIFICADOR} { System.out.print(yytext()); return new Symbol(sym.IDENTIFICADOR, new String(yytext())); } 

 {INTEIRO}       { System.out.print(yytext()); return new Symbol(sym.LIT_INTEIRO, new Integer(yytext())); } 

 {STRING}        { System.out.print(yytext()); return new Symbol(sym.LIT_STRING, new String(yytext())); } 
 
 {COMENTARIO}  {/*Ignore*/} 

 {QUEBRA}      {/*Ignore*/}
 
 {INVALIDO} {  System.out.println(" Caracter Invalido: <" + yytext() +  ">"); System.exit(-1);  }
 
.			{ System.out.println("Caracter ilegal: " + yytext()); }