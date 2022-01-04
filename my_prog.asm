; ----------------------------------------------------------------------------------------
; To assemble and run:
;     nasm -felf64 my_prog.asm && ld my_prog.o && ./a.out
; ----------------------------------------------------------------------------------------
            global      _start
            section     .text                   ; which section of binary file this will be compiled into
_start:     mov         rax, 1                  ; system call for write
            mov         rdi, 1                  ; file handle 1 is stdout
            mov         rsi, message            ; address of string to output
            mov         rdx, 13                 ; number of bytes
            syscall                             ; invoke operating system to do the write

            mov         r8, [exit_c_1]          ; [] means contents at. "[esp]" is same as C "*esp".
            mov QWORD   r9, [exit_c_2]          ; exit_c_1 is simply an adress in the memory
                                                ; QWORD is implied here but other times need explicitly
            mov QWORD   r10, exit_c_1           ; puts the adress into r10; only for demo
            mov         r11, exit_c_2           ; puts the adress into r11; only for demo
            lea         r11, [exit_c_2]         ; should be same as above line
            add         r8, r9
            mov         [res_var_1], r8         ; copy value into memory from register
            mov BYTE    [res_var_1], 99         ; copy immediate value into memory; requires size

            ; 128 bit dividend, RDX:RAX
            mov         rax, 890
            mov         rdx, 2
            ; 64 bit divisor
            mov         rbx, 890
            ; result rax, remainder rdx
            div         rbx

            ; 890 = 1101111010
            ; 2 = 10
            ; dividend = 10 0000000000000000000000000000000000000000000000000000001101111010
            ; dividend = 36893488147419104122
            ; divisor = 890
            ; result should be = 4.1453357e+16
            ; remainder should be = 312
            ; result is 56 bits: 10010011010001011001101111100110101100000000100100110101
            ; which fits in the 64 bit result register

            ; if the result would overflow, for e.g. by changing the divisor to 1
            ; we get a floating point exception

            mov         rdi, r8                 ; exit code
            mov         rax, 60                 ; system call for exit
            syscall                             ; invoke operating system to exit

            section     .data
message:    db          "Hello, World", 10      ; note the newline at the end
exit_c_1:   dq          24d
exit_c_2:   dq          -24d

            section     .bss
res_var_1:  resb        4                       ; reserve 4 bytes
