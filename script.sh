#!/bin/bash

clear

rm lex.yy.c prueba aux

lex plant.l
g++ -o prueba lex.yy.c -ll

./prueba codificar.cpp

clear

cat aux
