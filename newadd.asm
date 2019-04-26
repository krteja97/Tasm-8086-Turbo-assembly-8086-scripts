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

printNumber macro x
	mov bl,x
	shr bl,4
	call addextra
	add bl,30h
	printcharacter bl

	mov bl,x
	shl bl,4
	shr bl,4
	call addextra
	add bl,30h
	printcharacter bl
	endm


DATA SEGMENT
msg1 db 0dh,0ah,"Enter first Number: $"
msg2 db 0dh,0ah,"Enter second Number: $"
newline db 0dh,0ah," $"

num1 db 3 dup(0)
num2 db 3 dup(0)
result db 3 dup(0)
DATA ENDS

CODE SEGMENT
assume cs:code, ds:data
start:
mov ax,data
mov ds,ax

print msg1
mov bx,offset num1
call AcceptNumber

print msg2
mov bx, offset num2
call AcceptNumber

call Addnumbers1
print newline
printNumber result
printNumber result+1
printNumber result+2

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
		shl al,4
		mov [bx+si],al
		takeinput
		call ConvertToAscii
		add [bx+si],al
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
	mov cx,3
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
		stc
	label5:	
		adc al,bl
		mov result+si,al
		mov bh,0
		adc bh,0
		dec si
		dec cl
		JMP label3
	label4:
		ret
		endp


Addnumbers1 proc
	clc
	mov si,offset num1
	mov di,offset num2
	mov al,[si+2]
	mov ah,[si+1]
	mov bl,[di+2]
	mov bh,[di+1]
	add ax,bx
	mov result+2,al
	mov result+1,ah
	mov al,[si]
	mov bl,[di]
	adc al,bl
	mov result,al
	ret
	endp


;;;;use clc for clearing carry flag

addextra proc
	cmp bl,10
	JC label7
	add bl,07h
	label7:
	ret
	endp

CODE ENDS
END START


