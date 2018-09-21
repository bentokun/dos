org 0x100

main:
    mov ax, inputMsg
    push ax
    call print
    pop ax
    
    mov ax, 17
    push ax
    call allocmem
    add sp, 2
    
    jnz allocSuccess
    
allocFail:
    mov ax, allocFailMsg
    push ax
    call print
    pop ax
    
    jmp term
    
allocSuccess:
    push ax
    
    mov ax, allocSuccessMsg
    push ax
    call print
    pop ax
    
    pop ax
    
printNum:
    mov di, ax
    mov ax, [num]
    push 17
    push di
    push ax
    call inttostr
    add sp, 6
    
    jnc transSucc
    
transFail:
    mov ax, translateFailMsg
    push ax
    call print
    pop ax
    
    jmp returnResources
    
transSucc:
    mov ax, translateSuccMsg
    push ax
    call print
    pop ax
    
    push di
    call print
    pop di
    
    mov ax, di
    
returnResources:
    push ax
    call freemem
    add sp, 2
    
term:
    jmp terminate
    
%include "dosstd.asm"
%include "utils.asm"

inputMsg db 'Please type your name!', 0x0d, 0x0a, '$'
allocFailMsg db 'Allocation failed!', 0x0d, 0x0a, '$'
allocSuccessMsg db 'Allocation success!', 0x0d, 0x0a, '$'
translateFailMsg db 'Translate failed!', 0x0d, 0x0a, '$'
translateSuccMsg db 'Translate success!', 0x0d, 0x0a, '$'
num dw 243