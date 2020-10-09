masm
model small
.stack 256

.data
    ugol db 1
    Ug db ?
    ad db ?
    addSub db ?
.code

line proc
    m0:
        push cx
        mov ah, 0ch
        mov bh, 0
        mov cx, si
        mov dx, di
        int 10h
        
        cmp addSub, 1
        jne toSub
        xor bx, bx
        mov bl, ad
        add di, bx
        jmp skipSub
        toSub:
            mov bl, ad
            sub di, bx
        skipSub:
            xor bx, bx
            mov bl, ugol
            cmp Ug, bl
            jne m1
            inc si
            mov ugol, 0
            
        m1:
        pop cx
        inc ugol
    loop m0
    mov ugol, 1
    
    ret
line endp

main:
    mov ax, @data
    mov ds, ax
    
    mov ah, 0h
    mov al, 12h
    int 10h
    
    mov si, 330;x
    mov di, 100;y
    mov cx, 50;len
    mov al, 7;color
    mov Ug, 0;ugol naklona 
    mov ad, 1;horizontal  0 vertical  1
    ;addSub, 1;left 0 rigth 1
    
    ;truba
    call line
    mov si, 340
    mov di, 100
    mov cx, 50
    
    ;vertikal
    call line ; stena
    mov si,500
    mov di, 360
    mov cx, 200
    
    
    call line ; stena
    mov si,140
    mov di, 360
    mov cx, 200
   
    ;okno
    call line 
    mov si,250
    mov di, 320
    mov cx, 100
    
    call line 
    mov si,300
    mov di, 320
    mov cx, 100
    mov al,5
    
    
    call line 
    mov si,200
    mov di, 320
    mov cx, 100
    
    ;dver
    call line 
    mov si,480
    mov di, 340
    mov cx, 140   
   
    call line 
    mov si,400
    mov di, 340
    mov cx, 140 
    
    call line 
    mov si,420
    mov di, 280
    mov cx, 10
    
    ;---------------
    call line
    mov si,330
    mov di, 50
    mov cx, 10
    mov Ug, 1
    mov ad, 0
    
    ;dver
    call line 
    mov si,400
    mov di, 340
    mov cx, 80 
    
    call line 
    mov si,400
    mov di, 200
    mov cx, 80 
    
    call line 
    mov si,480
    mov di, 340
    mov cx, 20 
    
    
    ;---------------
    

    
    mov si,140;fundament
    mov di,360
    mov cx,360
    call line
    
    ;--------------------okno
    mov si,200
    mov di,320
    mov cx,100
    call line
    
    mov si,200
    mov di,220
    mov cx,100
    call line
    
    ;krisha
    mov si,140
    mov di, 160
    mov cx, 360
    mov Ug, 1
    mov ad, 0
    call line
    
    mov si, 200
    mov di, 100
    mov cx, 240
    call line
    
    mov si, 140
    mov di, 160
    mov cx, 60
    mov ad, 1
    mov addSub, 0
    call line
    
    ;-------------Naclonay left
    mov si, 380
    mov di, 160
    mov cx, 60
    call line
    ;------------------
    mov si, 440;Naclonay right
    mov di, 100
    mov cx, 60
    mov addSub,1
    call line
    ;-----------------
    
    
    
    mov ax, 4c00h
    int 21h
end main