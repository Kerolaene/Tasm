masm
model small
.stack 256
.data
sl1 dd 3f68119bh,0b1919123h
sl2 dd 552999cah,0ff331299h
res1 dd 2 dup(0)
res2 dd 2 dup(0)
oldb db 0
.code
begin:mov ax,@data
mov ds,ax
.386
;slojenia
mov eax, sl1;flagov net op1 3f68/119b
add eax,sl2;flagov net op1 5529/99cah posle 119b
mov res1,eax;s-1, o-1,p-1,a-1 op1 ab65
;slojenia s uchetom
mov eax,sl1+4;s-1, o-1,p-1,a-1 op1 b1919123
adc eax,sl2+4;s-1, o-1,p-1,a-1 op1 ff331299 posle 9123 posle - > op2
mov res1+4,eax;c-1,s-1,o-0,p-0,a-0 op1 0000 posle a3bc
adc bl,0;c-1,s-1,o-0,p-0,a-0 op1 0000

;vicitania
mov ax,word ptr sl1;vse flagi 0 op1 119b/f753 drob - > op2
sub ax,word ptr sl2;vse flagi 0 op1 99ca/119b
mov word ptr res2,ax;c-1,p-1    op1 0000 posle 77d1
mov ax,word ptr sl1+2;c-1,p-1   op1 3f68 
sbb ax,word ptr sl2+2;c-1,p-1   op1 5529/3f68
mov word ptr res2+2,ax;c-1,s-1,p-0,a-1 op1 0000/ea3e
mov ax,word ptr sl1+4;c-1,s-1,p-0,a-1  op1 9123

sbb ax,word ptr sl2+4;c-1,s-1,p-0,a-1 op1 1299/9123
mov word ptr res2+4,ax;c-0,s-0,o-1,p-o,a-1 op1 0000/7e89
mov ax,word ptr sl1+6;c-0,s-0,o-1,p-o,a-1  op1 b191
sbb ax,word ptr sl2+6;c-0,s-0,o-1,p-o,a-1  op1 ff33/b191
mov word ptr res2+6,ax;c-1,s-1,o-0,p-0,a-1 op1 0000/b25e

mov ax,4c00h
int 21h
end begin
