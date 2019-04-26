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
msg1 db 0dh,0ah,"enter number less then 65000: $"
newline db 0dh,0ah," $"
data ends

code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax

;;;;;;;;;;;;;;preprocessing done

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

;;;;;;;;;;;;;;;;;;now stored in a----
print newline

mov bx,a

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


;;reached end

mov ah,4ch
int 21h

;;;;;;;;;;;;procedures bloody fook

converttoascii proc
	cmp al,10
	jc pk
	add al,07h
	pk:
		add al,30h
	ret
	endp

convertfromascii proc
	cmp al,41h
	jc pk1
	sub al,07h
	pk1:
		sub al,30h
	ret
	endp

code ends
end start