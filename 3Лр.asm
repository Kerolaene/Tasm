DATA SEGMENT
PER1 DB 56
PER2 DW -350
FORT DD -456986
DATA ENDS
STK SEGMENT STACK
DB 256 DUP(?)
STK ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA,SS:STK;
	START:
	MOV AX,DATA
	MOV DS,AX
	MOV BX,345H
	MOV CX,BX
	MOV BP,BX
	MOV AH,BL
	MOV AL,PER1
	MOV DI,PER2
	PUSH WORD PTR FORT
	PUSH WORD PTR FORT+2
	POP FORT
	POP FORT+2
	XCHG CH,AL
	MOV AX,4C00H
	INT 21H
CODE ENDS
END START
