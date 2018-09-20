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
; arg2: Pointer to the integer which will contains the address
allocmem: 
    push bp
    mov bp, sp
    
    ; Load total of bytes going to be alloc
    mov bx, [bp + 4]
    mov ah, 48h
    
    int 21h
    
    push bx
    
    jc allocfail
 
allocsuccess:
    ; Load the allocated address to the given pointer
    mov di, [bp + 6]
    mov word [di], ax

    jmp finishalloc
    
allocfail:
    ; Just set the given pointer address to 0
    mov di, [bp + 6]
    mov word [di], 0
    
finishalloc:
    pop bx
    pop bp
    ret
 
; Free an allocated memory segment
; arg1: address
; arg2: Pointer to 16-bit integer will contain the error code. 
;       The integer will be 0 if there is no error.
freemem:
    push bp
    mov bp, sp
    
    mov es, [bp + 4]
    mov ah, 49h
    
    int 21h
    
    push bx
    
    jc freefail
    
freesucc:
    mov di, [bp + 6]
    mov word [di], 0
    
    jmp finishfree
    
freefail:
    mov di, [bp + 6]
    mov word [di], ax
    
finishfree:
    pop bx
    
    pop bp
    ret