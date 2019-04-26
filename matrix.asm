printString macro msg
	mov dx,offset msg
	mov ah,09h
	int 21h
	endm

takeinput macro
	mov ah,01h
	int 21h
	endm

printcharacter macro x
	mov ah,2h
	mov dl,x
	int 21h
	endm

printhyphen macro
	mov ah,2h
	mov dl,45
	int 21h
	endm

DATA SEGMENT
msg1 db 0dh,0ah,"Enter the dimension1 of matrix: $"
msg2 db 0dh,0ah,"Enter the dimension2 of matrix: $"
msg3 db 0dh,0ah,"Enter the element of matrix1: $"
msg4 db 0dh,0ah,"Enter the element of matrix2: $"
newline db 0dh,0ah, " $"

dimension1 db ?
dimension2 db ?
matrix1 db 100 dup(?)
matrix2 db 100 dup(?)
elementscount db ?
DATA ENDS

CODE SEGMENT
assume cs:code, ds:data
start:
mov ax,data
mov ds,ax

printString msg1
mov bx,offset dimension1
call AcceptNumber

printString msg2
mov bx,offset dimension2
call AcceptNumber

; accept all the elements

mov al,dimension1
mov bl,dimension2
mul bl
mov elementscount,al

mov bx,offset matrix1
mov cl,0h

loop1: 
	cmp elementscount,cl
	jz loopx1
	printString msg3
	call AcceptNumber
	add bx,1h
	inc cl
	JMP loop1

loopx1:
	mov bx,offset matrix2
	mov cl,0h

loop2: 
	cmp elementscount,cl
	jz loopx2
	printString msg4
	call AcceptNumber
	add bx,1h
	inc cl
	JMP loop2


;;elements accepted
;; do subtraction

printString newline
printString newline

loopx2:
	mov si,0
	mov di,0
	mov cl,0

loop3:
	cmp elementscount,cl
	JZ final
	mov bx,offset matrix1
	mov al,byte ptr [bx+si]
	mov bx,offset matrix2
	mov dl,byte ptr [bx+di]
	sub al,dl
	call printNumber 
	inc si
	inc di
	inc cl
	JMP loop3


final:
	mov ah,4ch
	int 21h

AcceptNumber proc
	mov ah,0h
	mov [bx],ah
	takeinput
	call convertToascii
	add [bx],al
	shl al,4
	takeinput
	call convertToascii
	add [bx],al
	ret
	endp

convertToascii proc
	cmp al,41h
	jc noalphabet
	sub al,7h
	noalphabet: 
		sub al,30h
	ret
	endp

printNumber proc
	cmp al,0
	JGE f1
	neg al
	mov bl,al
	printhyphen
	mov al,bl

f1:
	mov bl,al
	shr al,4h
	cmp al,10h
	JC pk
		add al,7h
	pk:
		add al,30h
	printcharacter al
	mov al,bl
	shl al,4h
	shr al,4h
	cmp al,10h
	JC pk1
		add al,7h
	pk1:
		add al,30h
	printcharacter al

	printString newline
	ret 
	endp


CODE ENDS
END START
