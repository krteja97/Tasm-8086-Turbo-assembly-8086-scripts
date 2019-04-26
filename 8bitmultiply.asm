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
a db ?
b db ?
c dw ?

msg1 db 0dh,0ah,"enter number 1: $"
msg2 db 0dh,0ah,"enter number 2: $"
newline db 0dh,0ah," $"
data ends

code segment
assume cs:code, ds:data
start:
mov ax,data
mov ds,ax

;;;;;;;;;;;;;;preprocess done

print msg1
takeinput
call convertfromascii
shl al,4h
mov a,al
takeinput
call convertfromascii
add a,al

print msg2
takeinput
call convertfromascii
shl al,4h
mov	b,al
takeinput
call convertfromascii
add b,al

;;;;do multiply

mov al,a
mov bl,b
mul bl
mov c,ax

print newline

;;;;;;;;;;;;;;;;;;;now print result

mov bx,c
mov al,bh
shr al,4
call converttoascii
printcharacter al
mov al,bh
shl al,4
shr al,4
call converttoascii
printcharacter al

mov al,bl
shr al,4
call converttoascii
printcharacter al
mov al,bl
shl al,4
shr al,4
call converttoascii
printcharacter al



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