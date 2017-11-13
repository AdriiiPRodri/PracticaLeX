/*DECLARACIONES*/

%{
#include <stdio.h>
#include <fstream>
#include <string>

using namespace std;

void EscribirFileaux(const string &una_cadena);
%}

/*ALIAS*/


/*REGLAS 
printf("%s\n", yytext);
*/

%%

"endif\n"	

.   {EscribirFileaux("jijijPrueba\n");}

%%

int main(int argc, char *argv[]){
	if(argc==2){
		yyin = fopen(argv[1], "rt");
		if(yyin==NULL){
			printf("El fichero %s no se puede abrir\n", argv[1]);
			exit(-1);
		}
	}else yyin= stdin;


yylex ();

return 0;

}

void EscribirFileaux(const string &una_cadena){
	fstream os("test.txt", fstream::in|fstream::out|fstream::app);
	os<<una_cadena;
	os.close();
}
