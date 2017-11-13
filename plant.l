/*DECLARACIONES*/

%{
#include <stdio.h>
#include <fstream>
#include <string>

using namespace std;

void EscribirFileaux(const string &una_cadena);
%}

/*ALIAS*/

TIPOS		"char"|"char16_t"|"char32_t"|"wchar_t"|"signedchar"|"signedshortint"|"int"|"signedint"|"signedlongint"|"signedlonglongint"|"unsignedchar"|"unsignedshortint"|"unsignedint"|"unsignedlongint"|"unsignedlonglongint"|"float"|"double"|"longdouble"|"bool"|"void"|"decltype(nullptr)"|"long"

/*REGLAS
printf("%s\n", yytext);
"endif\n"	{ EscribirFileaux("\n"); }

\n\n		{ EscribirFileaux("\n"); }
\n(\n)+		{ EscribirFileaux("\n\n"); }

\n*		{ EscribirFileaux(""); }

[A-Za-z0-9#\(\)_\-&\*;=\+/%"' <>\\\{\}\.,]*	{ EscribirFileaux(yytext); }

*/

%%

(\n+|" "+)"#ifdef "		{ EscribirFileaux("#ifdef "); }
"#endif"		{ EscribirFileaux("\n#endif\n"); }
"#include ".*		{ string meter = "\n"; meter += yytext; EscribirFileaux(meter); }
")".*"{"((\n)*|(" ")*)			{ EscribirFileaux(") {\n"); }
(" ")*{TIPOS}(" ")*				{ string meter = yytext; meter += " "; EscribirFileaux(meter); }
.   { printf(" "); }

%%

int main(int argc, char *argv[]){
	if(argc==2){
		yyin = fopen(argv[1], "rt");
		if(yyin==NULL){
			printf("El fichero %s no se puede abrir\n", argv[1]);
			exit(-1);
		}
	}else yyin= stdin;

yylex();

return 0;

}

void EscribirFileaux(const string &una_cadena) {
	fstream os("aux", fstream::out|fstream::app);
	os << una_cadena;
	os.close();
}
