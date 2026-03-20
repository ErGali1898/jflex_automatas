package uclm.automatas;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.nio.charset.StandardCharsets;

public class Main {
  public static void main(String[] args) throws Exception {

    if (args.length > 0) {
      try (Reader r = java.nio.file.Files.newBufferedReader(
              java.nio.file.Paths.get(args[0]), StandardCharsets.UTF_8)) {
        Lexer lexer = new Lexer(r);
        lexer.yylex();
      }
      return;
    }

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