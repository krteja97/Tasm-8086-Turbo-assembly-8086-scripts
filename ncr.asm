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
	call convertToAscii
	int 21h
	endm


DATA SEGMENT
msg1 db 0dh,0ah, "Enter n: $"
msg2 db 0dh,0ah, "Enter r: $"
newline db 0dh,0ah, " $"
msg3 db 0dh,0ah, "Result is: $"

n db ?
r db ?
dummy dw ?
nfac dw ?
rfac dw ?
nrfac dw ?
ncr dw ?
DATA ENDS



CODE SEGMENT
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax

print msg1
mov bx, offset n
call acceptNumber

print msg2
mov bx, offset r
call acceptNumber

;;finding factorials
mov bh,0h
mov bl,n
call findFactorial
mov nfac,ax

mov bh,0h
mov bl,r
call findFactorial
mov rfac,ax

mov bh,0h
mov bl,n
sub bl,r
call findFactorial
mov nrfac,ax
;;finding factorials

;; division occured now
mov ax,nrfac
mul rfac
mov dummy,ax
mov ax,nfac
div dummy
mov nfac,ax

;;print number now
mov cl,al
mov bl,cl
shr bl,4h
printcharacter bl
mov bl,cl
shl bl,4h
shr bl,4h
printcharacter bl


mov ah,4ch
int 21h

acceptNumber proc
	mov byte ptr [bx],0
	takeinput 
	call convertToInt
	shl al,4
	mov byte ptr [bx],al
	takeinput 
	call convertToInt
	add [bx],al
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

convertToAscii proc
	cmp dl,10
	jc pk
	add dl,7h
	pk:
		add dl,48
	ret
	endp

findFactorial proc
	mov ax,1h
	loop1:
		cmp bx,0
		JZ end1
		mul bx
		sub bx,1h
		JMP loop1

	end1:
		ret
		endp

CODE ENDS
END START




	