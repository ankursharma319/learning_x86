; ----------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls. Runs on 64-bit Linux only.
; To assemble and run:
;     nasm -felf64 hello.asm && ld hello.o && ./a.out
; ----------------------------------------------------------------------------------------

; GLOBAL is the other end of EXTERN: if one module declares a symbol as EXTERN and
; refers to it, then in order to prevent linker errors, some other module must
; actually define the symbol and declare it as GLOBAL.
; _start is the default entry point
            global    _start
            section   .text                   ; which section of binary file this will be compiled into

_start:     mov       rax, 1                  ; system call for write
            mov       rdi, 1                  ; file handle 1 is stdout
            mov       rsi, message            ; address of string to output
            mov       rdx, 13                 ; number of bytes
            syscall                           ; invoke operating system to do the write
            mov       rax, 60                 ; system call for exit
            xor       rdi, rdi                ; exit code 0
            syscall                           ; invoke operating system to exit
            section   .data

message:    db        "Hello, World", 10      ; note the newline at the end
