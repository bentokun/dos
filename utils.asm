; Convert an integer to string
; Args:
;
; - Arg1: The integer
; - Arg2: Pointer to the heap memory that will store the string
; - Arg3: String max capacity
; - Returns: cf carry means that there is error, Get error with AX
; 
; Error:
; - 5: String not large enough
inttostr:
    push bp
    mov bp, sp
    
    mov ax, [bp + 4]
    xor si, si
    
    mov bx, [bp + 8]
    
counttotalchar:
    mov dx, 0
    mov cx, 10
    div cx
   
    add si, 1
    
    cmp ax, 0
    jnz counttotalchar
    
checkmem:
    add si, 3
    cmp si, bx
    
    jle dotrans
    
nomem:
    mov ax, 5
    xor si, si
    
    ; Set the carry flag
    cmp si, ax
    jmp transfinish

dotrans:
    mov ax, [bp + 4]
    xor bx, bx
     
addterm:
    mov di, [bp + 6]
    
    add di, si
    sub di, 3
    
    mov byte [di], 0Dh
    add di, 1
    mov byte [di], 0Ah
    add di, 1
    mov byte [di], '$'
   
looptrans:
    xor dx, dx
    mov cx, 10
    div cx
   
    add bx, 1
    
    mov di, [bp + 6]
    
    add di, si
    sub di, bx
    sub di, 3
    
    add dx, 48
    mov byte [di], dl
    
    cmp ax, 0
    jnz looptrans
   
transfinish:
    pop bp
    ret
   
; chartodigit
; Error in AX, if the carry is set:
;   4: Not in number ASCII range ('0' (48) to '9' (58))
chartodigit:
    push bp
    mov bp, sp
    
    mov al, byte [bp + 4]
    cmp al, 48
    
    jl outofrange
    
    cmp al, 58
    jg outofrange
    
    sub al, 48
    jmp ctdendfinish
    
outofrange:
    xor bx, bx
    mov ax, 4
    
    cmp bx, ax
    
ctdendfinish:    
    pop bp