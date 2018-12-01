/*
 * Developed by Arthur Arantes Faria 
 * Graduating in Computer Science on UNIFOR-MG BRASIL
 * arthurarantes23@hotmail.com
 */

package lexico;

import UserInterface.UserInterface;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author aarantes23
 */
public class Analisador {

    UserInterface ui;
    private Map<String, TokenData> tokenMap;

    /**
     * Construtor, Inicia um objeto Token junto, vide classe Token
     * @param pUI UserInterface class, this can act as a controller
     */
    public Analisador(UserInterface pUI) {
        this.tokenMap = new HashMap<String, TokenData>();
        ui = pUI; // User interface
    }

    /**
     * Adiciona o token a sua respectiva tabela hash, contendo:
     * @param pToken String do token
     * @param pTokenType Tipo do token (Grupo)
     * @param pLine Linha do Token
     * @param pColumn Coluna do Token
     */
    public void addToken(String pToken, TokenType tokens, int pLine, int pColumn) {
        if (this.tokenMap.containsKey(pToken)) {
            this.tokenMap.get(pToken).addPosition(pLine, pColumn);
        } else {
            this.tokenMap.put(pToken, new TokenData(tokens, pLine, pColumn));
        }
    }

    /**
     * Recebe um leitor com o código fonte do arquivo para ser analisado
     * Fica em loop até que todos os tokens sejam classificados em seus grupos
     * @param arquivoFonte = Text área ou arquivo mesmo
     * @throws IOException
     */
    public void analisaArquivo(Reader arquivoFonte) throws IOException {
        Lexer lexer = new Lexer(arquivoFonte);
        Token token;

        while (true) {
            // Pega o token atual do Lexer
            token = lexer.yylex();

            if (token == null) {
                // Fim do arquivo, para
                break;
            }

            // Classifica os tokens
            switch (token.getTokens()) {
                case PALAVRA_RESERVADA:
                    this.addToken(lexer.yytext(), token.getTokens(), token.getLine(), token.getColumn());
                    break;
                case IDENTIFICADOR:
                    this.addToken(lexer.yytext(), token.getTokens(), token.getLine(), token.getColumn());
                    break;
                case INTEGER_LITERAL:
                    this.addToken(lexer.yytext(), token.getTokens(), token.getLine(), token.getColumn());
                    break;
                case CHAR_LITERAL:
                    this.addToken(lexer.yytext(), token.getTokens(), token.getLine(), token.getColumn());
                    break;
                case FLOAT_LITERAL:
                    this.addToken(lexer.yytext(), token.getTokens(), token.getLine(), token.getColumn());
                    break;
                case STRING_LITERAL:
                    this.addToken(lexer.yytext(), token.getTokens(), token.getLine(), token.getColumn());
                    break;
                case OPERADOR:
                    this.addToken(lexer.yytext(), token.getTokens(), token.getLine(), token.getColumn());
                    break;
                case COMENTARIO_ABERTO_ERRO:
                    this.addToken(lexer.yytext(), token.getTokens(), token.getLine(), token.getColumn());
                    break;
                case STRING_ABERTA_ERRO:
                    this.addToken(lexer.yytext(), token.getTokens(), token.getLine(), token.getColumn());
                    break;
                case CHAR_INVALIDO_ERRO:
                    this.addToken(lexer.yytext(), token.getTokens(), token.getLine(), token.getColumn());
                    break;
                case END_OF_FILE:
                    this.addToken(lexer.yytext(), token.getTokens(), token.getLine(), token.getColumn());
                    break;
                default:
                    // Token desconhecido, erro
                    break;
            }
        }
    }

    /**
     * Recebe uma string e passa para o BufferedReader para o Lexer poder analisar
     * @param pString
     * @return
     */
    public Reader fromStringParaReader(String pString) {
        File tempFile = new File("temp.txt");
        PrintWriter writer;
        Reader reader = null;
        try {
            writer = new PrintWriter(tempFile);
            writer.print(pString);
            writer.close();
            reader = new BufferedReader(new FileReader("temp.txt"));
        } catch (FileNotFoundException exception) {
            // Catch exception
        }
        return reader;
    }

    /**
     * Mostra os tokens com seu conteúdo na tabela.      
     */
    public void printTokens() {
        TokenData tokenData;

        for (String key : this.tokenMap.keySet()) {
            tokenData = this.tokenMap.get(key);
            String lines = "";
            String columns = "";
            String errorLines = "";
            String errorColumns = "";
            for (Integer mkey : tokenMap.get(key).getPositionDictionary().keySet()) {
                if (tokenData.getTokenType().toString().contains("ERRO")) {
                    errorLines += mkey + ", ";
                    errorColumns += tokenMap.get(key).getPositionDictionary().get(mkey) + ", ";
                } else {
                    lines += mkey + ", ";
                    columns += tokenMap.get(key).getPositionDictionary().get(mkey) + ", ";
                }
            }
            lines = lines.substring(0, lines.lastIndexOf(",") < 0 ? 0 : lines.lastIndexOf(","));
            columns = columns.substring(0, columns.lastIndexOf(",") < 0 ? 0 : columns.lastIndexOf(","));
            errorLines = errorLines.substring(0, errorLines.lastIndexOf(",") < 0 ? 0 : errorLines.lastIndexOf(","));
            errorColumns = errorColumns.substring(0, errorColumns.lastIndexOf(",") < 0 ? 0 : errorColumns.lastIndexOf(","));
            if (tokenData.getTokenType().toString().contains("ERRO"))
                ui.getDmErrorTable().addRow(new Object[]{key, tokenData.getTokenType().toString().toString(), errorLines, errorColumns});
            else
                ui.getDmTokenTable().addRow(new Object[]{key.toString(), tokenData.getTokenType().toString(), lines, columns});
        }
    }
}
