#! /bin/sh

nasm -felf64 -g hello.asm
ld -g -o hello hello.o

nasm -felf64 -g my_prog.asm
ld -g -o my_prog my_prog.o

nasm -felf64 -g funcs.asm -o funcs.o
g++ -c -g -std=c++17 -Wall -ansi -o main.o main.cpp
g++ -g -o main main.o funcs.o
