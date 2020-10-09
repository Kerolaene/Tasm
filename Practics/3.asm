masm
model small
stack 256

.data
string db ' PO-327 Abreyan K.A'

len equ $-string
block macro x1, y1, x2, y2, atr;



mov ah, 6
mov al, 0
mov bh, atr
shl bh, 1
mov ch, y1
mov cl, x1
mov dh, y2
mov dl, x2

int 10h



sub bl, atr
push ds
pop es
int 10h

int 21h
endm



clean macro

mov ah, 6
mov al, 0
mov bh, 0
mov cx, 0
mov dh, 24
mov dl, 79
int 10h
endm

.code
main:
mov ax, @data
mov ds, ax

mov ax,600h ;?????? ??????
mov ax,1003h ; ????????? 16 ??????

clean



block 33, 6, 35, 11, 13    ;ruka right
block 20, 6, 22, 11,11      ;ruka left
block 25, 1, 30, 10, 11     ;shlypa

block 23, 2, 32, 4, 12      ;bus
block 26, 3, 26, 3, 7     ;left eys
block 30, 3, 30, 3, 7       ;right eys

block 27, 4, 28, 5, 12      ;sheya
block 22, 6, 33, 10, 12     ;tulovishe 
block 24, 10, 26, 15, 12    ;noga left
block 29, 10, 31, 15, 12    ;noga right


mov ah,02h
mov dh,20
mov dl,0
int 10h

lea si,string
mov bh,0
mov cx,len

m1:
push cx
mov ah,09h
lodsb
mov bl,6
mov cx,1
int 10h

pop cx
mov ah,02h
inc dl
int 10h

loop m1




mov ah, 7

int 21h
mov ax, 4c00h
int 21h
end main