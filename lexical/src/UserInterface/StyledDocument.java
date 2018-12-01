/*
 * Developed by Arthur Arantes Faria 
 * Graduating in Computer Science on UNIFOR-MG BRASIL
 * arthurarantes23@hotmail.com
 */

package UserInterface;

import java.awt.Color;

import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.DefaultStyledDocument;
import javax.swing.text.StyleConstants;
import javax.swing.text.StyleContext;

/**
 *
 * @author aarantes23
 */

public class StyledDocument extends DefaultStyledDocument {

    /**
     * Nessa classe contém a definição dos estilos da fonte dentro do text área do formulário principal
     * Sobrepõe métodos do sistema, Não altere a maioria das coisas aqui 
     */
    final StyleContext cont = StyleContext.getDefaultStyleContext();
    // Muda dinamicamente a cor das palavras no texto sendo :
    // Vermelho, para palavras reservadas
    final AttributeSet attr = cont.addAttribute(cont.getEmptySet(), StyleConstants.Foreground, Color.RED);           
    // Azul para Strings em " "
    final AttributeSet attrBlue = cont.addAttribute(cont.getEmptySet(), StyleConstants.Foreground, Color.BLUE);
    // Preto para outras palavras , exemplo Identificadores
    final AttributeSet attrBlack = cont.addAttribute(cont.getEmptySet(), StyleConstants.Foreground, Color.BLACK);
    final String lexemas = "(\\s)*(auto|char|break|case|char|const|continue|default|do|"
            + "double|else|enum|extern|float|for|goto|if|inline|long|main|printf|register|restrict|return|int|scanf|"
            + "short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while)";

    @Override
    // Metodos para a definição dos estilos no TextArea, sobrepoe metodos do sistema, não delete, pois o sistema gera-la novamente
    public void insertString(int offset, String str, AttributeSet a) throws BadLocationException {
        super.insertString(offset, str, a);

        String text = getText(0, getLength());
        int before = findLastNonWordChar(text, offset);
        if (before < 0) before = 0;
        int after = findFirstNonWordChar(text, offset + str.length());
        int wordL = before;
        int wordR = before;

        while (wordR <= after) {
            if (wordR == after || String.valueOf(text.charAt(wordR)).matches("\\s")) {
                if (text.substring(wordL, wordR).matches(lexemas))
                    setCharacterAttributes(wordL, wordR - wordL, attr, false);
                else
                    setCharacterAttributes(wordL, wordR - wordL, attrBlack, false);
                wordL = wordR;
            }
            wordR++;
        }
        String[] txt = text.split("\"");
        for (int index = 0; index < txt.length; index++) {
            if (text.indexOf("\"" + txt[index] + "\"") >= 0 && index % 2 == 1) {
                int indexOfWord = text.indexOf("\"" + txt[index] + "\"");
                setCharacterAttributes(indexOfWord,
                        txt[index].length() + 2, attrBlue, false);
            }
        }
    }
    
    @Override
    public void remove(int offs, int len) throws BadLocationException {
        super.remove(offs, len);

        String text = getText(0, getLength());
        int before = findLastNonWordChar(text, offs);
        if (before < 0) before = 0;
        int after = findFirstNonWordChar(text, offs);

        if (text.substring(before, after).matches(lexemas)) {
            setCharacterAttributes(before, after - before, attr, false);
        } else {
            setCharacterAttributes(before, after - before, attrBlack, false);
        }
    }

    private int findFirstNonWordChar(String text, int index) {
        while (index < text.length()) {
            if (String.valueOf(text.charAt(index)).matches("\\s")) {
                break;
            }
            index++;
        }
        return index;
    }

    private int findLastNonWordChar(String text, int index) {
        while (--index >= 0) {
            if (String.valueOf(text.charAt(index)).matches("\\s")) {
                break;
            }
        }
        return index;
    }

}
