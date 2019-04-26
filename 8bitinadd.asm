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
	mov ah,2h
	mov dl,x
	int 21h
	endm


data segment
a db 4
b db 5
c db ?
msg1 db 0dh,0ah,"enter number 1: $"
msg2 db 0dh,0ah,"enter number 2: $"
newline db 0dh,0ah," $"
data ends

code segment
assume cs:code, ds:data
start:
mov ax,data
mov ds,ax



mov al,a
mov bl,b
add al,bl
mov c,al

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;print the result;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;call converttoascii
;printcharacter al

print newline

mov al,c
shr al,4
call converttoascii
printcharacter al
mov al,c
shl al,4
shr al,4
call converttoascii
printcharacter al



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;finishing touches;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov ah,4ch
int 21h

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
