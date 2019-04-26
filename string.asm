printstring macro msg
	mov dx, offset msg
	mov ah,09h
	int 21h
	endm

printcharacter macro x
	mov ah,2h
	mov dl,x
	int 21h
	endm

stringinput macro str
	mov ah,0ah
	lea dx,str
	int 21h
	endm

characterinput macro
	mov ah,01h
	int 21h
	endm



DATA SEGMENT
msg db 0dh,0ah,"Enter first string: $"
msg1 db 0dh,0ah,"Enter second string: $"
result1 db 0dh,0ah,"Equal $"
result2 db 0dh,0ah,"Not equal $"
newline db 0dh,0ah,"$"
len1 db ?
len2 db ?

str1 db 16 dup ('$')
str2 db 16 dup ('$')
DATA ENDS

CODE SEGMENT
assume cs:code, ds:data
start:
	 mov ax,data
	 mov ds,ax
	 printstring msg
	 stringinput str1
	 printstring newline

	 printstring msg1
	 stringinput str2
	 printstring newline

	 ;find length of strings
	 lea di,str1
	 call findStringLength
	 mov len1,cl
	 lea di,str2
	 call findStringLength
	 mov len2,cl

	 add len1,30h
	 printcharacter len1
	 printstring newline
	 add len2,30h
	 printcharacter len2
	 printstring newline

	 printstring str1
	 printstring newline
	 printstring str2




mov ah,4ch
int 21h

findStringLength proc
	mov al,'$'
	mov cl,0

	label1:
		cmp [di],al
		je label2
		inc cl
		inc di
		JMP label1
	label2:
		ret
		endp

CODE ENDS
end start



