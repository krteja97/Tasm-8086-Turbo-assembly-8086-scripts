print macro msg
	mov dx, offset msg
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


DATA SEGMENT
msg1 db 0dh,0ah,"Enter first Number: $"
msg2 db 0dh,0ah,"Enter second Number: $"
newline db 0dh,0ah," $"

num1 db 3 dup(?)
num2 db 3 dup(?)
result db 3 dup(?)
DATA ENDS

CODE SEGMENT
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax

print msg1
mov bx, offset num1
call AcceptNumber

mov bx, offset num2
call AcceptNumber

call Addnumbers

mov ah,4ch
int 21h


AcceptNumber proc
	mov cl,3
	mov si,0
	label1:
		cmp cl,0
		JZ label2	
		takeinput
		call ConvertToAscii
		mov [bx+si],al
		inc si
		dec cl
		JMP label1
	label2:
		ret
		endp


ConvertToAscii proc
	cmp al,41h
	jc pk
	sub al,07h
	pk:
		sub al,30h
	ret
	endp

Addnumbers proc
	mov cl,3
	mov si,2
	mov bh,0
	clc
	label3:
		cmp cl,0
		JE label4
		mov al,num1+si
		mov bl,num2+si
		cmp bh,0
		JE label5
		setc
	label5:	
		addc al,bl
		mov result+si,al
		setc bh
		dec si
		dec cl
		JMP label3
	label4:
		ret
		endp



CODE ENDS
END START

; write procedures


