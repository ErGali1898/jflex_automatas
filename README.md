# jflex_automatas

CARLOS SALGADO ROJAS						50%.

ENRIQUE GALIANA	FERNÁNDEZ-CALVILLO			50%.

ABDELMOUIZ KOBRY							0%

## 1.	OBJETIVO

El objetivo de esta práctica es construir un traductor sencillo de un lenguaje para la especificación gráfica de un árbol (LEA), que genere la estructura del árbol en formato de grafo utilizando el lenguaje DOT (lenguaje de definición de grafos).
Para ello, en esta primera parte se realizará un análisis del lenguaje a partir de los ejemplos proporcionados en el campus virtual. A partir de dicho análisis se construirá una tabla que descomponga el lenguaje en sus distintos componentes léxicos.
En esta tabla se identificarán, por una parte, las palabras reservadas, que son aquellas que definen elementos estructurales del lenguaje. Por otra parte, se identificarán los símbolos, así como las cadenas de texto (strings), que corresponden a palabras o expresiones entrecomilladas que pueden contener espacios. Finalmente, se identificarán los identificadores (ID), que incluyen todas aquellas palabras que no son reservadas y que no aparecen entre comillas.
A continuación, se procede a identificar los distintos tokens del lenguaje que serán utilizados posteriormente en la implementación del analizador léxico mediante JFlex.


## 2.	TABLA DE TOKENS

EXPRESION	DESCRIPCION	TOKEN	EJEMPLO
arbol	Palabra reservada para definir un árbol	ARBOL	arbol
node	Palabra reservada para definir atributos generales de los nodos	NODE	node
edge	Palabra reservada para definir los atributos de los arcos del arbol	EDGE	edge
hijos	Palabra reservada para definir un hijo de un nodo	HIJOS	hijos
[a-zA-Z][a-zA-Z0-9_]*	Identificador del lenguaje	ID	label
[0-9]+	Numero entero	NUM	100
"[^"]*"	Cualquier cadena que vaya entre comillas	STRING	"E 14"
{	Llave izq	LLAVEI	{
}	Llave der	LLAVED	}
[	Corchete izq	CORCHETEI	[
]	Corchete der	CORCHETED	]
=	Asignacion	ASSIG	=
,	Separador	COMA	,
;	Fin	PCOMA	;


## 3.	MANUAL DE USO

Para ejecutar el analizador léxico desarrollado en esta práctica se ha utilizado un proyecto Maven en Eclipse, de forma que la generación del lexer y su compilación queden automatizadas.

La estructura básica del proyecto es la siguiente:
El fichero lexer.flex contiene la especificación léxica del lenguaje LEA. En él se definen, mediante expresiones regulares, los distintos componentes léxicos del lenguaje, junto con la acción asociada a cada uno de ellos. A partir de este fichero, JFlex genera automáticamente la clase Lexer.java, que implementa el autómata finito encargado de reconocer los tokens.

La clase Main.java se utiliza para ejecutar el analizador léxico. Su función es abrir el fichero de entrada, crear una instancia del lexer generado y recorrer el contenido del archivo, imprimiendo por pantalla el resultado.

El fichero input.txt, situado en la carpeta src/main/resources, contiene el código de entrada en lenguaje LEA que se desea analizar. 
En este fichero se encuentra lo que querremos probar con el lexer previamente creado

Una vez definido de lo que se encarga cada parte vamos a pasar a las instrucciones de ejecución: 
1.	Dirígete a https://github.com/ErGali1898/jflex_automatas/tree/main
2.	Clona el proyecto
3.	Run as Maven generate-resources, luego run as Maven clean.
4.	Click derecho a Main.java- Run as Java application.


## 4.	EJEMPLO DE ENTRADA Y SALIDA


Vamos a poner como ejemplo este código puesto en el campus ya que contiene todo lo que queremos analizar, pero añadiendo un comentario con #... que lo ponga en la practica general: 

// Este es un ejemplo con diferentes definciones de node y edge
#ejemplo de comentario2

arbol ejemplo2 {
node [shape = square, label = "a", color = "green", fontcolor = blue , style = bold]
edge [dir = forward, label = "0", color = "blue", fontcolor = red , style = dashed]

/*También tenemos diferentes comentarios
en diferentes lineas */

a hijos = {b [label = "6", color = "red"],c [label = "100"]}  [label = "A", color = "blue", shape = circle];
b hijos = {d [label = "80"] } [label = "B"];
c hijos = {f [color = blue], g [label = "22"]} [label = "C"];

edge [color = "red", fontcolor = green]

d hijos = {e [label = "14"] } [label ="D"];
e ;
f [shape = circle];
g [color = red, label = 4];

}


Y la salida que debería de salir es la siguiente: 
ARBOL => arbol
ID => ejemplo2
LLAVEI => {
NODE => node
CORCHETEI => [
ID => shape
ASSIG => =
ID => square
COMA => ,
ID => label
ASSIG => =
STRING => "a"
COMA => ,
ID => color
ASSIG => =
STRING => "green"
COMA => ,
ID => fontcolor
ASSIG => =
ID => blue
COMA => ,
ID => style
ASSIG => =
ID => bold
CORCHETED => ]
EDGE => edge
CORCHETEI => [
ID => dir
ASSIG => =
ID => forward
COMA => ,
ID => label
ASSIG => =
STRING => "0"
COMA => ,
ID => color
ASSIG => =
STRING => "blue"
COMA => ,
ID => fontcolor
ASSIG => =
ID => red
COMA => ,
ID => style
ASSIG => =
ID => dashed
CORCHETED => ]
ID => a
HIJOS => hijos
ASSIG => =
LLAVEI => {
ID => b
CORCHETEI => [
ID => label
ASSIG => =
STRING => "6"
COMA => ,
ID => color
ASSIG => =
STRING => "red"
CORCHETED => ]
COMA => ,
ID => c
CORCHETEI => [
ID => label
ASSIG => =
STRING => "100"
CORCHETED => ]
LLAVED => }
CORCHETEI => [
ID => label
ASSIG => =
STRING => "A"
COMA => ,
ID => color
ASSIG => =
STRING => "blue"
COMA => ,
ID => shape
ASSIG => =
ID => circle
CORCHETED => ]
PCOMA => ;
LLAVED => }
