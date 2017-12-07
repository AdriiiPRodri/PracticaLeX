/**
  * @file imagenES.cpp
  * @brief Fichero con definiciones para la E/S de imágenes
  *
  * Permite la E/S de archivos de tipo PGM,PPM
  *
  */
#include <iostream>
#include <cstring>
#include "codificar.h"
#include "imagenES.h"
using namespace std;

struct product {
	int weight;
	double price;
}

const int MAXBUFFER= 1000000;
const int MAXNOMBRE= 100;
const int MAXMENSAJE= 125000;

int main() {
	switch(caracola) {
		case this->value:
			int a;
			break;
		case that->value:
			break;
		case 1:
			if(LeerTipoImagen(nom_img_in, filas, columnas) == IMG_PGM) {
				if(LeerImagenPGM(nom_img_in, filas, columnas, buffer)) {
					if(Revelar(buffer, mensaje)) {
						cout << "revelando.." << endl;
						cout << "el mensaje obtenido es: " << endl << mensaje << endl;
					}

					else
						error_terminador = true;
				}

				else
					error_lectura = true;
			}

			else
				if(LeerTipoImagen(nom_img_in, filas, columnas) == IMG_PPM) {
					if(LeerImagenPPM(nom_img_in, filas, columnas, buffer)) {
						if(Revelar(buffer, mensaje)) {
							cout << "revelando.." << endl;
							cout << "el mensaje obtenido es: " << endl << mensaje << endl;
						}

						else
							error_terminador = true;
					}

					else
						error_lectura = true;
				}

				else
					error_formato = true;
				break;
			case a:
				break;
			default://Code to execute if <variable> does not equal the value following any of the cases
				break;
		}

		int filas, columnas;
		bool error_lectura = 0, error_formato = 0, error_terminador = 0;
		char nom_img_in[maxnombre];
		unsigned char buffer[maxbuffer];
		char mensaje[maxmensaje]= "";
		cout << "introduzca la imagen de entrada: ";
		cin >> nom_img_in;
		if(LeerTipoImagen(nom_img_in, filas, columnas) == IMG_PGM) {
			if(LeerImagenPGM(nom_img_in, filas, columnas, buffer)) {
				if(Revelar(buffer, mensaje)) {
					cout << "revelando.." << endl;
					cout << "el mensaje obtenido es: " << endl << mensaje << endl;
				}

				else
					error_terminador = true;
			}

			else
				error_lectura = true;
		}

		else
			if(LeerTipoImagen(nom_img_in, filas, columnas) == IMG_PPM) {
				if(LeerImagenPPM(nom_img_in, filas, columnas, buffer)) {
					if(Revelar(buffer, mensaje)) {
						cout << "revelando.." << endl;
						cout << "el mensaje obtenido es: " << endl << mensaje << endl;
					}

					else
						error_terminador = true;
				}

				else
					error_lectura = true;
			}

			else
				error_formato = true;
			if(error_formato)
				cerr << "error: el formato de la imagen es desconocido." << endl;
			if(error_lectura)
				cerr << "error: no existe la imagen." << endl;
			if(error_terminador)
				cerr << "error: la imagen no contiene un terminador o contiene un mensaje demasiado grande." <<endl;
		}
