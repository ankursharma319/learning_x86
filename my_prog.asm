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
            mov         rax, 60                 ; system call for exit
            mov         r8, [exit_c_1]          ; [] means contents at. "[esp]" is same as C "*esp".
            mov         r9, [exit_c_2]          ; exit_c_1 is simply an adress in the memory
            mov         r10, exit_c_1           ; puts the adress into r10; only for demo
            mov         r11, exit_c_2           ; puts the adress into r11; only for demo
            lea         r11, [exit_c_2]         ; should be same as above line
            add         r8, r9
            mov         [res_var_1], r8         ; copy value into memory from register
            mov         rdi, r8                 ; exit code
            syscall                             ; invoke operating system to exit

            section     .data
message:    db          "Hello, World", 10      ; note the newline at the end
exit_c_1:   dq          24d
exit_c_2:   dq          11d

            section     .bss
res_var_1:  resb        4                       ; reserve 4 bytes
