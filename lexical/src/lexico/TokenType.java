/*
 * Developed by Arthur Arantes Faria 
 * Graduating in Computer Science on UNIFOR-MG BRASIL
 * arthurarantes23@hotmail.com
 */
package lexico;
 
/**
 *
 * @author aarantes23
 */
public enum TokenType {
    /*
     * Contém o tipo dos tokens definidos anteriormente em Lexer.flex
     */
    
    IDENTIFICADOR,
    PALAVRA_RESERVADA,
    OPERADOR,
    STRING_LITERAL,
    INTEGER_LITERAL,
    FLOAT_LITERAL,
    CHAR_LITERAL,
    COMENTARIO_ABERTO_ERRO,
    STRING_ABERTA_ERRO,
    CHAR_INVALIDO_ERRO,
    END_OF_FILE
}
