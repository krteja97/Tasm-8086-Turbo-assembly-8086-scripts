printcharacter macro x
	mov ah,2h
	mov dl,x
	call convertToAscii
	int 21h
	endm

DATA SEGMENT
n db 7H
r db 3H
nfac dw ?
rfac dw ?
nrfac dw ?

ffac dw ?
DATA ENDS


CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
MOV AX,DATA
MOV DS,AX



mov ax,1
mov bl,n
mov bh,0h
call factorial
mov nfac, ax

mov ax,1
mov bl,r
mov bh,0
call factorial
mov rfac,ax

clc
mov ax,1
mov bl,n
mov bh,0
sub bl,r
call factorial
mov nrfac,ax

mov bx,rfac
mov ax,nrfac
mul bx
;;;ax has denominator
mov bx,ax
mov ax,nfac
div bx
mov ffac, ax

;;;;;;now finally print karna parega
mov bx,ffac
mov al,bh
mov ah,0h
mov bl,16
DIV bl
mov cx,ax
mov al,cl
printcharacter al
mov al,ch
printcharacter al

mov bx,ffac
mov al,bl
mov ah,0h
mov bl,16
DIV bl
mov cx,ax
mov al,cl
printcharacter al
mov al,ch
printcharacter al





MOV AH,4CH
INT 21H

convertToAscii proc
	cmp dl,10
	jc pk
	add dl,7h
	pk:
		add dl,48
	ret
	endp

convertToInt proc
	cmp al,65
	JC jk1
	sub al,7h

	jk1:
		sub al,48
	ret
	endp

factorial proc
	
	loop1:
		cmp bx,0
		JZ loopout
		mul bx
		dec bx
		JMP loop1

		loopout:
			ret
			endp



CODE ENDS
END START