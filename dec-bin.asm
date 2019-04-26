print macro msg
	mov dx,offset msg
	mov ah,09h
	int 21h
	endm

takeinput macro 
	mov ah,01h
	int 21h
	endm

printcharacter macro x
	mov dl,x
	mov ah,02h
	int 21h
	endm

data segment
a dw ?
msg1 db 0dh,0ah,"enter number less than 65000: $"
newline db 0dh,0ah," $"
data ends

code segment
assume cs:code, ds:data
start:
mov ax,data
mov ds,ax

;;;;;;;;;;;;;;preprocess done

mov bh,0h
mov a,00h
print msg1
takeinput
call convertfromascii
mov bl,al
mov ax,10000
mul bx
add a,ax

takeinput
call convertfromascii
mov bl,al
mov ax,1000
mul bx
add a,ax

takeinput
call convertfromascii
mov bl,al
mov ax,100
mul bx
add a,ax

takeinput
call convertfromascii
mov bl,al
mov ax,10
mul bx
add a,ax

takeinput
call convertfromascii
mov bl,al
mov ax,1
mul bx
add a,ax

;;;;;;;;;;;;;;;;;;;now stored in a
print newline
clc

mov bx,a
mov cl,16

loop1:
	cmp cl,0
	jz loop2
	rol bx,1
	jc loop3
		mov al,0h
		call converttoascii
		printcharacter al
		JMP loop4

	loop3:
		mov al,1h
		call converttoascii 
		printcharacter al
	loop4:
		dec cl
		JMP loop1

loop2:




;;;;;;;;;;;;;;comes to the end
mov ah,4ch
int 21h

;;;;;;;;procedures


convertfromascii proc
	cmp al,41h
	jc pk
	sub al,07h
	pk:
		sub al,30h
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

code ends
end start