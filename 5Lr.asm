;Vvesti s klaviaturi 2 slova i vivesti v sledusei stroke 1 i 2 poslednix bukvi pervogo slova, a dlinu vtorogo zapasit6s v peremenyou p1
data segment
    
    OneWord db "input one word = >","$"
    TwoWord  db "input two word = >","$"

    meseg db 10,13,"$"

    BufOne db 30, ?, 31 dup(?)
    BufTwo db 30, ?, 31 dup(?)
    
data ends
stk segment stack
    db 256 dup('?')
stk ends
code segment
    main:
        assume cs:code,ds:data,ss:stk
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
        
        mov ah,9
        lea dx,meseg
        int 21h
        lea dx,TwoWord
        int 21h

        mov ah,10
        lea dx,BufTwo
        int 21h
        mov bl,BufTwo+1
        mov bh,0
        mov BufTwo[bx+2],'$'

        mov ah,9
        lea dx,meseg
        int 21h
        

        mov si,1
        mov dl,BufTwo[si]
        
        mov ah,9
        lea dx,BufOne + 2
        int 21h
        
        mov ah,02h
        mov dl,' '
        int 21h


        mov ah,9
        lea dx,BufTwo + 2
        int 21h

        mov ah,7
        int 21h
        mov ax,4c00h
        int 21h
code ends
end main
