#! /bin/sh

nasm -felf64 -g hello.asm
ld -g -o hello hello.o

nasm -felf64 -g my_prog.asm
ld -g -o my_prog my_prog.o
