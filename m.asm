printString macro msg
	mov dx,offset msg
	mov ah,09h
	int 21h
	endm

takeinput macro
	mov ah,01h
	int 21h
	endm

DATA SEGMENT
msg1 db 0dh,0ah,"Enter the dimension of matrix: $"
msg2 db 0dh,0ah,"Enter the element of matrix: $"
msg3 db 0dh,0ah,"Non identity matrix: $"
msg4 db 0dh,0ah,"Identity Matrix: $"
newline db 0dh,0ah, " $"

dimension db ?
matrix db 100 dup(?)
elementscount db ?
stretch db ?
DATA ENDS

CODE SEGMENT
assume cs:code, ds:data
start:
mov ax,data
mov ds,ax

printString msg1
mov bx,offset dimension
call AcceptNumber

mov al,dimension
mov stretch,al
add stretch,1h
mov al,dimension
mov cl,dimension
mul cl
mov ch,al
mov elementscount,al

; accept the dimension size as input

mov bx,offset matrix
mov cl,0h

; accept all the elements

loop1: 
	cmp elementscount,cl
	jz loopx
	printString msg2
	call AcceptNumber
	add bx,1h
	inc cl
	JMP loop1

loopx:
	mov cl,0
	mov si,0
	mov dh,0

; check for diagonal elements

loop2:
	cmp matrix+si,1
	JNZ nonIdentity
	inc cl
	mov dl,stretch
	add si,dx
	cmp cl,dimension
	JNE loop2

printString msg1

;; check for non diagonal elements

mov cl,0
mov si,0
mov bl,stretch
mov ch,elementscount


loop3:
	cmp cl,elementscount
	JNC loop5
	mov ah,0
	mov al,cl
	div bl
	cmp ah,0h
	JNZ loop4
	inc cl
	inc si
	cmp cl,elementscount
	JNC loop5

	loop4:
		cmp matrix+si,0h
		JNZ nonIdentity
		inc cl
		inc si
		JMP loop3




;; finishing touches

loop5:
printString msg4
mov ah,4ch
int 21h

nonIdentity:
	printString msg3

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



CODE ENDS
END START
