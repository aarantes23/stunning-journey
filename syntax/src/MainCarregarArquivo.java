/*
 * Developed by Arthur Arantes Faria 
 * Graduating in Computer Science on UNIFOR-MG BRASIL
 * arthurarantes23@hotmail.com
 */

/**
 * 
 * @author Arthur
 */
public class MainCarregarArquivo {

    public static void main(String[] args) {
        try {
            parser p = new parser(new Yylex(new java.io.FileInputStream("teste/Teste Parser.txt")));
            p.parse();
        }
        catch(Exception e) { System.out.println(e.getMessage());}
    }
}
