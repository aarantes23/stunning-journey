/*
 * Developed by Arthur Arantes Faria 
 * Graduating in Computer Science on UNIFOR-MG BRASIL
 * arthurarantes23@hotmail.com
 */

package lexico;

import java.util.*;

/**
 *
 * @author aarantes23
 */

public class TokenData {

    /**
     * Contém a data de cada token mapeada em uma tabela/map hash
     * Assim, um token pode ser repetido varias veses no codigo,
     * E a tabela mostrará ele somente uma vez, porem com todas suas posições
     * Usado na classe do Analisador
     */
    private TokenType tokens;

    public TokenType getTokenType() {
        return tokens;
    }

    public void setTokenType(TokenType tokens) {
        this.tokens = tokens;
    }

    private Map<Integer,List<Integer>> posicaoDicionario;

    public TokenData(TokenType tokens, int pLine, int pColumn) {
        this.tokens = tokens;
        this.posicaoDicionario = new HashMap<Integer,List<Integer>>();
        this.posicaoDicionario.put(pLine, Arrays.asList(pColumn));
    }

    public void addPosition(int pLine,int pColumn) {
        List<Integer> newColumnList = new ArrayList<Integer>();
        if (this.posicaoDicionario.containsKey(pLine)){
            newColumnList =  new ArrayList<Integer>(this.posicaoDicionario.get(pLine));
        }
        newColumnList.add(pColumn);
        this.posicaoDicionario.put(pLine, newColumnList);
    }

    public Map<Integer, List<Integer>> getPositionDictionary() {
        return posicaoDicionario;
    }
   
}