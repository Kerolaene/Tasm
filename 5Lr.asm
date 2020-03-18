;Vvesti s klaviaturi 2 slova i vivesti v sledusei stroke 1 i 2 poslednix bukvi pervogo slova, a dlinu vtorogo zapasit6s v peremenyou p1
data segment
    
    OneWord db "input one word = >","$"
    TwoWord  db "input two word = >","$"

    probel db 10,13,"$"

    BufOne db 30, ?, 31 dup(?)
    BufTwo db 30, ?, 31 dup(?)

    
data ends
stk segment stack
    db 256 dup('?')
stk ends
code segment
    main:
        assume cs:code,ds:data,ss:stk
        ;input one word
        mov ax,data
        mov ds,ax
        mov ah,9
        lea dx,OneWord
        int 21h
        mov ah,10
        lea dx,BufOne
        int 21h
        mov bl,BufOne+1
        mov bh,0
        mov BufOne[bx+2],'$'
        mov si,1
        mov dl,BufOne[si]
        ;------------------
       
        
        mov [BufOne+3],'$'
        mov ah,9
        lea dx,probel
        int 21h
        
        ;input two word
        lea dx,TwoWord
        int 21h

        mov ah,10
        lea dx,BufTwo
        int 21h
        mov bl,BufTwo+1
        mov bh,0
        mov BufTwo[bx+2],'$'

        mov ah,9
        lea dx,probel
        int 21h
       
       ;outpot one
        mov ah,9
        lea dx,[BufOne + 2]
        int 21h

        ;probel
        mov ah,02h
        mov dl,' '
        int 21h
        ;poslednya bukvya
        
        lea si,[BufOne+1] 
        mov cx,0
        mov cl,[si]
        add si,cx
        mov ah,02h
        mov dl,[si]
        int 21h
        
        ;mov al,BufOne[si]
        ;mov 
        ;mov di,[di+2]
        ;int 21h
        ;probel
        mov ah,02h
        mov dl,' '
        int 21h

        ;outpot two
        mov ah,9
        lea dx,[BufTwo + 2]
        int 21h
        
        
        mov ah,7
        int 21h
        mov ax,4c00h
        int 21h
code ends
end main
