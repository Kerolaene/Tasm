masm
model small
stack 256
.data
Per_1 db 0
Per_2 db 4
.code
main: mov ax,@data
        mov ds,ax
        
        mov cx,16;????? ????????
        mov al,0;???????? ??????
        mov ax,1003h;????????? 15 ??????
cycle:
        push cx
        mov bh,bl;?????????? 
        shl bh,4
        
        
        mov ch,0;??????? ????? ???????  ?????? 
        mov cl,Per_1;??????
        mov dh,24;?????? ????? ??????? ??????
        mov dl,Per_2;?????? 
         
        int 10h;??????? bios
        
        
        add Per_1,5;????????
        add Per_2,5;????????
        inc bl;?????????? ?? 1
        
        mov ah,7;???????????? ???????
        int 21h;??????????
        pop cx
loop cycle

       
        mov ax,4c00h
        int 21h
end main  