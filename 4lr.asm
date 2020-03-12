masm
model small
.stack 256
.data
message db 'ABREYAN',10,13,'KAREN',10,13,'ARTUROVICH$'
per1 dw 8373
per2 db 238
e_per1 dd 95019
e_per2 dd -498699
buf db 20
db 20 dup (?)
.code
begin: mov ax,@data
mov ds,ax
mov ah,9
lea dx,message
int 21h
mov ah,7
int 21h
mov ax,4c00h
int 21h
end begin
____________________________
data segment
    mes1 db 'Input your name-> $'
mes2 db 10,13,'Hello$'
buf db 20
db ?
db 20 dup (?)
data ends
stk segment stack
    db 256 dup(?)
stk ends
code segment
main:
assume cs:code,ds:data,ss:stk
mov ax,data
mov ds,ax
mov ah,9
lea dx,mes1
int 21h
mov ah,10
lea dx,buf
int 21h
mov bl,buf+1
mov bh,0
mov buf[bx+2],'$'
mov ah,9
lea dx,mes2
int 21h
lea dx,buf+2
int 21h
mov ah,7
int 21h
mov ax,4c00h
int 21h
code ends
end main