data segment
message db "Input two words"
len dw $-message
error db "ERROR sym: "
len_error dw $-error
ok db "OK"
len_ok dw $-ok
sym dw 0
slovo_1 db 10 dup("?")
slovo_2 db 10 dup("?")
len_slovo_1 db 0
len_slovo_2 db 0
data ends
stk segment stack
db 256 dup("?")
stk ends

code segment
assume ds:data, ss:stk, cs:code
srav:
mov al, len_slovo_1
mov ah, len_slovo_2
cmp al, ah
jng Ng
mov cl, al
jmp skip2

Ng:
mov cl, ah

skip2:
mov si, 2

m1:
mov dl, slovo_1[si]
cmp dl, slovo_2[si]
jne false
inc si
loop m1

true:
;????? OK
mov ah, 13h
mov al, 0
mov bl, 1eh
mov bh, 0
mov cx, len_ok
mov dh, 12
mov dl, 35
push ds
pop es
lea bp, ok
int 10h
jmp skip

false:
;????? Error
mov sym, si
add sym, 2dh
mov ah, 13h
mov al, 0
mov bl, 4eh
mov bh, 0
mov cx, len_error
mov dh, 12
mov dl, 35
push ds
pop es
lea bp, error
int 10h
mov ah, 13h
mov al, 0
mov bl, 4eh
mov bh, 0
mov cx, 2
mov dh, 12
mov dl, 46
push ds
pop es
lea bp, sym
int 10h
jmp skip

main:
mov ax, data
mov ds, ax
mov ah, 0;???????? ?????
mov al, 3
int 10h
mov ah, 10h;???????
mov al, 03h
mov bl, 0
int 10h
;????? ?????????
mov ah, 13h
mov al, 0
mov bl, 7h
mov bh, 0
mov cx, len
mov dh, 0
mov dl, 0
push ds
pop es
lea bp, message
int 10h
;?????????? ?????? ? 1-?? ??????
mov ah, 02h

mov bh, 0
mov dh, 1
mov dl, 0
int 10h
;???? ??????? ?????
mov ah, 0Ah
lea dx, slovo_1
int 21h
mov al, slovo_1[1]
mov len_slovo_1, al
;????????? ??????? ?? 2-?? ??????
mov ah, 02h
mov bh, 0
mov dh, 2
mov dl, 0
int 10h

;???? ??????? ?????
mov ah, 0Ah
lea dx, slovo_2
int 21h
mov al, slovo_2[1]
mov len_slovo_2, al
jmp srav

skip:

mov ah, 7h
int 21h
mov ax, 4c00h
int 21h
code ends
end main