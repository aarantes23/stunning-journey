/*
 * Developed by Arthur Arantes Faria 
 * Graduating in Computer Science on UNIFOR-MG BRASIL
 * arthurarantes23@hotmail.com
 */

package lexico;

import lexico.TokenType;

/**
 *
 * @author aarantes23
 */

public class Token {
    private TokenType tokens;
    private int line;
    private int column;

    // Cada token é um objeto, afim de mostrar na tabela e salvar as informações

    public Token(TokenType tokens, int line, int column) {
        this.tokens = tokens;
        this.line = line;
        this.column = column;
    }

    public TokenType getTokens() {
        return tokens;
    }

    public int getLine() {
        return line;
    }

    public int getColumn() {
        return column;
    }

}
