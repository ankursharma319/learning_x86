# Learning x86 Assembly

## Quick start

```
nasm -felf64 -g hello.asm
ld -o -g hello hello.o
./hello
```

## GDB

```
gdb hello
info frame
bt
help x
# stack memory
x/10x $sp
# examine adress pointed to at by rsi
x/x $rsi
# next instruction pointers
x/i $rip
# registers
info registers
```