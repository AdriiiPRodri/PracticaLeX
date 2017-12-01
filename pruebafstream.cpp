#include <iostream>
#include <fstream>

using namespace std;


int main(){
	fstream prueba;
	prueba.open("prueba.cpp", ios::out|ios::app);
	int i=0;
	while(i!=5){
		prueba << "juane\n";
		i++;
	}
	prueba.close();

	return 0;
}
