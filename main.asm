org 0x100

main:
    mov ax, inputMsg
    push ax
    call print
    add sp, 2
    jmp terminate
    
%include "dosstd.asm"

inputMsg db 'Please type your name!', 0x0d, 0x0a, '$'