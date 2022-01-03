# Learning x86 Assembly

## Quick start

Linux only

```
nasm -felf64 -g hello.asm
ld -g -o hello hello.o
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
# print bits of specific register
p/t $r8
# print adress of var
p/x &var_in_data_section
# examine value of var
x/x &var_in_data_section
```
