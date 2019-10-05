masm 
model small
.stack 256
.data
a db 16; 00010110
b db 89; 10001001
d db 45; 01000101
buf db '**h' , 10,13, '$'
tabl db '0123456789ABCDEF'
.code
begin: mov ax, @data
				mov ds, ax
				;Copy Умножения на а и перемещай младший регстр в старший
				mov al,a
				mul al
				mov bx, ax
				;Copy Умножения на б и обмен ах и бх 
				mov al,b
				mul al
				xchg ax,bx
				;Вычитание ах из бх и умножения 
				sub ax, bx
				mul bx, ax
				;Копир ал в д и ah в 2 умножения ah
				mov al, d 
				mov ah, 2
				mul ah
				;Обмен мл,на стр
				xchg ax, bx
				;Деление 
				idiv bl
				;Перенос ах в стек и copy 
				push ax
				mov cx, ax
				and al, 0fh
				lea bx, tabl
				xlat
				mov buf[1], al
				;Copy и логич сдвиг в право на 4 
				mov ax, cx
				and ax, 0f0f
				shr ax, 4 
				xlat
				mov buf[0], al
				;Copy 
				mov ah, 7 
				int 21h
				;Copy  and управлн цикло Loop cx
				mov bx, cx
				mov ah, 2
				mov cx, 8
				type2:
					xor dl, dl
					shl bl, 1
					adc dl, 30h
					int 21h
				loop type2
				;copy 
				mov ah, 7
				int 21h
				;
				mov ax,4c00h
				int 21h
end begin