package uclm.automatas;

%%
%class Lexer
%public
%unicode
%line
%column
%type void

/*
	Hemos creado este metodo auxiliar para no estar repitiendo constantemente 
	System.out.println(token + " => " + yytext()); al emitir los tokens
*/
%{
  private void emit(String token) {
    System.out.println(token + " => " + yytext());
  }
%}


/*
	Hacemos esto para simpleficar las expresiones y no repetirlas constantemente haciendo asi la lectura y 
	comprension del lexer mucho mas clara.
*/
LETRA       = [a-zA-Z]
DIGITO      = [0-9]
ID          = {LETRA}({LETRA}|{DIGITO}|_)*
/*
	Conjunto de digitos
*/
NUM         = {DIGITO}+
/*
 	Usamos \" para que se detecten las comillas, con esto lo que le decimos al programa esque 
 	cualquier cosa que se encuentre entre las comillas menos las mismas sera la string, igual lo haremos
 	con el simbolo *
*/
STRING      = \"[^\"]*\"

ESPACIOS    = [ \t\r\n\f]+


COMENT1     = "//".*
/*

Vamos a meter una "_" entremedias de *_/ ya que sino lo toma como fin de comentario y da error.
	Esta segunda forma de comentar es para el ejemplo visto en el campus donde los comentarios podian saltar lienas,
	vamos a comentar la parte dificil: 
		([^*]|\*+[^*_/])*: 
		Se divide en 2 partes separadas por "|", [^*]: cualquier carácter que no sea * y luego
		\*+[^*_/]: que significa uno o mas asteriscos seguidos de un caracter que no es ni / ni *,
		la barra la quitamos ya que la formacion *_/ indicaria cierre de comentario
		
		por ultimo la parte final *"+"/ indica que se van a encontrar tantos * como se quiera y por ultimo / para 
		cerrar.
*/
COMENT2 = "/*"([^*]|\*+[^*/])*"*"+"/"
COMENT3     = "#".*

%%


{ESPACIOS}  { /* ignorar */ }
{COMENT1}   { /* ignorar */ }
{COMENT2}   { /* ignorar */ }
{COMENT3}   { /* ignorar */ }


/*
	Hemos puesto las palabras reservadas antes de la definicion de ID ya que estas pueden ser consideredas 
	perfectamente como una, por lo que las definimos antes para que asi sean detectadas antes de una ID.
*/
"arbol"     { emit("ARBOL"); }
"node"      { emit("NODE"); }
"edge"      { emit("EDGE"); }
"hijos"     { emit("HIJOS"); }

"{"         { emit("LLAVEI"); }
"}"         { emit("LLAVED"); }
"["         { emit("CORCHETEI"); }
"]"         { emit("CORCHETED"); }
"="         { emit("ASSIG"); }
","         { emit("COMA"); }
";"         { emit("PCOMA"); }

{STRING}    { emit("STRING"); }
{NUM}       { emit("NUM"); }
{ID}        { emit("ID"); }

.           { System.out.println("ERROR_LEXICO => " + yytext()); }

<<EOF>>     { return; }