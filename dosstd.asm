; Print a string to STDOUT
; arg1: The message pointer (ASCII)
print:
    push bp
    mov bp, sp
    
    ; Load the input message argument (arg1)
    mov dx, [bp + 4]
    mov ah, 09h
    int 21h
    
    pop bp
    ret
    
; Terminate the application
terminate:
    push bp

    mov ah, 0x4c
    int 0x21
    
    pop bp
    ret
    
; Alloc memory from DOS
; arg1: Total of bytes
; returns: AX contains the address. 0 if allocation fail
allocmem: 
    push bp
    mov bp, sp
    
    ; Load total of bytes going to be alloc
    mov ax, [bp + 4]
    
    xor dx, dx
    mov cx, 16    ; Group of 16 bytes
    
    div cx
    
    cmp dx, 0
    jz allocint
    
roundsize:
    add ax, 1
    
allocint:
    mov bx, ax
    mov ah, 48h
    
    int 21h
    
    jnc finishalloc
    
allocfail:
    mov ax, 0
    
finishalloc:
    pop bp
    ret
 
; Free an allocated memory segment
; arg1: address
; returns: ax contains the error code
freemem:
    push bp
    mov bp, sp
    
    mov es, [bp + 4]
    mov ah, 49h
    
    int 21h
    
    push bx
    
    jc finishfree
    
freesucc:
    mov ax, 0
    
finishfree:
    pop bx
    pop bp
    ret