
            global    my_func
            section   .text                   ; which section of binary file this will be compiled into

my_func:    mov       rax, 5                  ; return value
            ret

message:    db        "Hello, World", 10      ; note the newline at the end
