#!/bin/bash

clear

rm lex.yy.c prueba auxx.cpp
lex plant.l
g++ -o prueba lex.yy.c -ll

./prueba imagenES.cpp

#clear

#cat auxx.cpp
