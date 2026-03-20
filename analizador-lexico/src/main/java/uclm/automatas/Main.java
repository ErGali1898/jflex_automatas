package uclm.automatas;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.nio.charset.StandardCharsets;

public class Main {
  public static void main(String[] args) throws Exception {

    // Si pasan un fichero por argumento, lo lees de disco (modo prueba)
    if (args.length > 0) {
      try (Reader r = java.nio.file.Files.newBufferedReader(
              java.nio.file.Paths.get(args[0]), StandardCharsets.UTF_8)) {
        Lexer lexer = new Lexer(r);
        lexer.yylex();
      }
      return;
    }

    // Si no hay args, lee src/main/resources/input.txt desde el classpath
    try (InputStream in = Main.class.getClassLoader().getResourceAsStream("input.txt")) {
      if (in == null) {
        throw new IllegalStateException("No encuentro input.txt en src/main/resources");
      }
      try (Reader r = new InputStreamReader(in, StandardCharsets.UTF_8)) {
        Lexer lexer = new Lexer(r);
        lexer.yylex();
      }
    }
  }
}