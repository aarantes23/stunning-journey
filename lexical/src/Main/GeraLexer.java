/*
 * Developed by Arthur Arantes Faria 
 * Graduating in Computer Science on UNIFOR-MG BRASIL
 * arthurarantes23@hotmail.com
 */
package Main;

import java.io.File;

/**
 *
 * @author aarantes23
 */
public class GeraLexer {
    
    private static final String LOCAL_ARQUIVO_ARTHUR_PC = "C:\\Users\\Arthur\\Documents\\NetBeansProjects\\Trabalho_Compilador\\src\\lexico\\Lexer.flex";
    private static final String LOCAL_ARQUIVO_GUSTAVO_PC ="C:\\Users\\Gustavo\\Google Drive\\Faculdade\\7º Período\\Compiladores\\Analisador\\Lexer.flex";
    
    /**
     * Observações :
     * Ao gerar Lexer.java o arquivo estará com erro
     * O erro pode ser corrigido alterando o import de :
     *          lexico.Tokens.*;  para lexico.TokenType.*;
     * Não sei o motivo, isso foi uma solução comum encontrada no stackoverflow
     * Também acusará erro na linha 813 , substitua :
     *      Tokens por Token
     * Depois de salvar os todos os erros serão corrigidos
     */    
    
    /**
     * 
     * @param args 
     */
    
    public static void main(String[] args) {        
        geraLexer(LOCAL_ARQUIVO_ARTHUR_PC);
    }
    
    /**
     * Gera o autômato relativo
     * @param caminho = Caminho do Arquivo definido no inicio da classe
     */
    public static void geraLexer(String caminho){
        File novoArquivo = new File(caminho);
        jflex.Main.generate(novoArquivo);
    }
    
}
