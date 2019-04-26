printcharacter macro x
	mov ah,2h
	mov dl,x
	int 21h
	endm

print macro msg
	mov dx,offset msg
	mov ah,09h
	int 21h
	endm

DATA SEGMENT
array dw 1235H,3451H,7678H,4547H,234H,9876H
len db 6
nl dw ?
nr dw ?
n dw ?
newline db 0dh,0ah," $"

DATA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA
START:
MOV AX,DATA
MOV DS,AX

;;;;;;;;;;;;;;;;;;;;start here

mov cl,len
mov ch,0
mov si,offset array



loop1:
	cmp len,ch
	JZ loop11	
	mov si,offset array
	mov cl,len
	sub cl,1

	loop2:
		cmp cl,0h
		JZ loop4
		mov ax,[si]
		mov nl,ax
		add si,2
		mov bx,[si]
		mov nr,bx
		clc
		sub ax,bx
		JC loop3
		;;swap here
		mov ax,nl
		mov [si],ax
		clc
		sub si,2h
		mov ax,nr
		mov [si],ax
		add si,2h

		loop3:
			dec cl
			JMP loop2

	loop4:
		inc ch
		JMP loop1


loop11:
mov cl,0
mov si,offset array
mov di,offset array


loop12:

	print newline

	mov ax,[si]
	mov bx,ax
	add si,2h
	call printNumber
	
		

	cmp len,cl
	JZ loopout
	mov ax,[di]
	mov bx,ax
	inc di
	inc di
	call printNumber
	inc cl
	JMP loop12




loopout:

	mov ah,4ch
	int 21h

printNumber proc
	mov al,bh
	shr al,4h
	call converttoascii
	printcharacter al
	mov al,bh
	shl al,4h
	shr al,4h
	call converttoascii
	printcharacter al

	mov al,bl
	shr al,4h
	call converttoascii
	printcharacter al
	mov al,bl
	shl al,4h
	shr al,4h
	call converttoascii
	printcharacter al	

	print newline
	ret
	endp




converttoascii proc
	cmp al,10
	jc pk1
		add al,07h
	pk1:
		add al,30h
	ret
	endp





CODE ENDS
END START