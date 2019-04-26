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



data segment
a dw ?
b dw ?
c dw ?

msg1 db 0dh,0ah,"enter first number: $"
msg2 db 0dh,0ah,"enter second number: $"
newline db 0dh,0ah," $"
data ends

code segment
assume cs:code,ds:data
mov ax,data
mov ds,ax


mov bx, offset a
print msg1
takeinput
call convertFromAscii



;;final touches

mov ah,4ch
int 21h
code ends
end start