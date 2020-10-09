masm
model small

.386

.stack 256
.data
    len = 60
    
    a_ db len-1
    A db len dup(0)
    
    b_ db len-1
    B db len dup(0)
    
    R db len dup(0)  
    minus db 0
    
    PromptA db 'A = $'
    PromptB db 10,13,'B = $'
    result db 10,13,'Result = $'
    action db 10,13,'Enter + or - = $'
    ERROR db 10,13,'Inavlid numbers $'  
.code

RightShift macro array
local shift   
local skip 
local if3 
local negative
local skip__  
local skip2_

    xor bx,bx
    
    mov bl,byte ptr array
    mov byte ptr array[bx+1],0
    mov byte ptr array, 0
    
    mov cx, bx
    mov si, bx
    mov bx, len
    dec bx

    xor dl,dl
    cmp byte ptr array[1] , '-'
    jne shift
    mov dl,'-'
    mov byte ptr array[1], 0
    dec cx   
shift:
    mov al, array[si]
    
    cmp al,'0'
    jb whoops
    cmp al,'9'
    ja whoops

    sub al, '0'
    
    mov array[bx], al 
    
    mov byte ptr array[si],0

    dec si
    dec bx 
                  
    loop shift
    cmp dl, '-'
    je skip__
    mov dl, 0
    
    jmp skip2_
skip__: 
    mov dl, 1
skip2_: 
    
    xor dl, minus
    cmp dl, 0
    je if3 

    mov cx,len
    mov si,cx
    dec si
negative:
       
    mov ax,0
    sbb al, array[si]
    aas
    mov array[si],al
    
    pushf ; 
    dec si
    popf ;
    
    loop negative
if3: 
    
     
endm  

begin:
    mov ax, @data
    mov ds, ax
    mov es, ax
  
    mov ah, 09h            
    mov dx, offset PromptA       
    int 21h       

    mov dx, offset a_ 
    mov ah, 0Ah
    int 21h
    
    mov ah, 09h            
    mov dx, offset PromptB       
    int 21h        
    
    mov ah, 0Ah
    mov dx, offset b_
    int 21h 
  
    mov ah, 09h            
    mov dx, offset action       
    int 21h  
    
    mov ah, 07h             
    int 21h
    
    cmp al,'-'
    jne next_
    mov minus,1   
next_: 
    mov al,minus
    mov di,ax
    mov minus, 0
    
    RightShift A
      
    mov ax,di
    mov minus,al

    RightShift B
   
    clc
    mov cx, len
    mov si, len-1
math: 
    
    mov ax, 0
    
    mov al, A[si]

    adc al,B[si]
    aaa
    mov R[si],al

    dec si

    loop math

;; print result
     
    mov ah, 09h            
    mov dx, offset result       
    int 21h       
   
    cmp byte ptr R,9
    jne down 
    
    mov cx,len
    mov si,cx
    dec si
negative_:

    mov al,0
    sbb al, R[si]
    aas
    mov R[si],al 
    dec si
    
    loop negative_ 
    
    mov ah,02h
    mov dl,'-'
    int 21h
    
down: 
    mov cx, len
    mov bx, offset R
  
skipzero_:
    cmp cx, 1
    je print
    
    cmp byte ptr [bx], 0
    jne print
    
    inc bx
    dec cx
    jmp skipzero_      
print:
    mov al,byte ptr [bx]
    add al,'0'
    
    mov ah,02h
    mov dl,al
    int 21h
          
    inc bx

    loop print 

;; print result 

    jmp finish
    
whoops:     
    mov ah, 09h                                                                          
    mov dx, offset ERROR    
    int 21h  
         
finish:      
    mov ah,7
    int 21h        
    mov ax,4c00h
    int 21h

end begin
