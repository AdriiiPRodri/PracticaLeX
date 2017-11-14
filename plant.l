/*DECLARACIONES*/

%{
#include <stdio.h>
#include <fstream>
#include <string>

using namespace std;

int ContadorLlaves;

void EscribirFileaux(const string &una_cadena);
void quitarEspacios(string &cadena);
void manejarGlobal(string &cadena);
void manejarLocal(string &cadena);
void ponerEspacios(string &cadena);
void meterTabuladores(string &cadena);
%}

/*ALIAS*/

%s LOCAL

TIPOS		"char"|"char16_t"|"char32_t"|"wchar_t"|"signedchar"|"signedshortint"|"int"|"signedint"|"signedlongint"|"signedlonglongint"|"unsignedchar"|"unsignedshortint"|"unsignedint"|"unsignedlongint"|"unsignedlonglongint"|"float"|"double"|"longdouble"|"bool"|"void"|"decltype(nullptr)"|"long"|"short"|"signed"|"unsigned"
VARIABLES	((" ")|"\n")*{TIPOS}" "*[A-Za-z0-9_, ]*;
MAIN		((" ")|"\n")*{TIPOS}" "*"main"" "*\(.*\)" "*
PRESERVADAS	"alignas"|"alignof"|"and"|"and_eq"|"asm"|"atomic_cancel"|"atomic_commit"|"atomic_noexcept"|"auto"|"bitand"|"bitor"|"break"|"case"|"catch"|"class"|"compl"|"concept"|"const"|"constexpr"|"const_cast"|"continue"|"co_await"|"co_return"|"co_yield"|"decltype"|"default"|"delete"|"do"|"double"|"dynamic_cast"|"else"|"enum"|"explicit"|"export"|"extern"|"false"|"for"|"friend"|"goto"|"if"|"import"|"inline"|"module"|"mutable"|"namespace"|"new"|"noexcept"|"not"|"not_eq"|"nullptr"|"operator"|"or"|"or_eq"|"private"|"protected"|"public"|"register"|"reinterpret_cast"|"requires"|"return"|"sizeof"|"static"|"static_assert"|"static_cast"|"struct"|"switch"|"synchronized"|"template"|"this"|"thread_local"|"throw"|"true"|"try"|"typedef"|"typeid"|"typename"|"union"|"using"|"virtual"|"void"|"volatile"|"while"|"xor"|"xor_eq"


/*REGLAS
printf("%s\n", yytext);
"endif\n"	{ EscribirFileaux("\n"); }

\n\n		{ EscribirFileaux("\n"); }
\n(\n)+		{ EscribirFileaux("\n\n"); }

\n*		{ EscribirFileaux(""); }

[A-Za-z0-9#\(\)_\-&\*;=\+/%"' <>\\\{\}\.,]*	{ EscribirFileaux(yytext); }

[^A-Za-z]*(" "|"\n"|"\{")*{TIPOS}(" ")*;				{ string meter = "\n"; meter += yytext; quitarEspacios(meter); EscribirFileaux(meter); }


"\)"(" ")*"\{"((\n)|(" "))*			{ EscribirFileaux(") {\n\t"); }

*/

%%

(\n|" ")*							{ EscribirFileaux(""); }
"#ifdef "[A-Za-z0-9_ ]*					{ string meter = yytext; quitarEspacios(meter); EscribirFileaux(meter); }
"#endif"							{ EscribirFileaux("\n#endif\n"); }
"#include "(" ")*.*					{ string meter = yytext; quitarEspacios(meter); meter.insert(meter.begin(), '\n'); EscribirFileaux(meter); }
\{									{ ContadorLlaves++; BEGIN LOCAL; }
\}									{ ContadorLlaves--; string meter = "\n"; meterTabuladores(meter); meter += "}\n"; EscribirFileaux(meter); if(ContadorLlaves == 0) BEGIN INITIAL; }
<LOCAL>({VARIABLES})				{ string meter = yytext; manejarLocal(meter); meter.insert(meter.begin(), '\n'); EscribirFileaux(meter); }
{VARIABLES}							{ string meter = yytext; manejarGlobal(meter); meter.insert(meter.begin(), '\n'); EscribirFileaux(meter); }
{MAIN}				{ string meter = yytext; quitarEspacios(meter); meter.insert(meter.begin(), '\n'); meter += " {"; EscribirFileaux(meter); }
.   								{ printf(" "); }

%%

int main(int argc, char *argv[]){
	if(argc==2){
		yyin = fopen(argv[1], "rt");
		if(yyin==NULL){
			printf("El fichero %s no se puede abrir\n", argv[1]);
			exit(-1);
		}
	}else yyin= stdin;

ContadorLlaves = 0;

yylex();

return 0;

}

void EscribirFileaux(const string &una_cadena) {
	fstream os("aux", fstream::out|fstream::app);
	os << una_cadena;
	os.close();
}

void quitarEspacios(string &cadena) {
	string aux;

	for(int i = 0; i < cadena.size() - 1; i++) {
		if(cadena[i] != ' ' || cadena[i + 1] != ' ')
			if(cadena[i] != '\n')
				aux += cadena[i];
	}

	if(cadena[cadena.size() - 1] != ' ')
		aux += cadena[cadena.size() - 1];

	cadena = aux;
}

void manejarGlobal(string &cadena) {
	quitarEspacios(cadena);
	ponerEspacios(cadena);

	for(int i = 1; i < cadena.size(); i++) {
		if(cadena[i - 1] == ' ')
			cadena[i] = toupper(cadena[i]);
		else if(cadena[i - 1] == '_') {
			cadena[i] = toupper(cadena[i]);
			cadena.erase(cadena.begin() + i - 1);
		}
		else
			cadena[i] = tolower(cadena[i]);

	}
}

void manejarLocal(string &cadena) {
	quitarEspacios(cadena);
	ponerEspacios(cadena);

	for(int i = 1; i < cadena.size(); i++) {
		cadena[i] = tolower(cadena[i]);
	}
}

void ponerEspacios(string &cadena) {
	for(int i = 0; i < cadena.size() - 1; i++) {
		if(cadena[i - 1] == ',' && cadena[i] != ' ')
			cadena.insert(cadena.begin() + i, ' ');
	}
}

void meterTabuladores(string &cadena) {
	for(int i = 0; i < ContadorLlaves; i++)
		cadena += "\t";
}
