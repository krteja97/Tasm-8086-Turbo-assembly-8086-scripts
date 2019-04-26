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

data segment
str1 db 16 dup('$')
str2 db 16 dup('$')
msg1 db 0dh,0ah,"enter string1: $"
msg2 db 0dh,0ah,"enter string2: $"
msg3 db 0dh,0ah,"equal strings $"
msg4 db 0dh,0ah,"non equal strings $"
newline db 0dh,0ah," $"

len1 db ?
len2 db ?

data ends


code segment
assume cs:code, ds:data
start:
mov ax,data
mov ds,ax

;;;take string input

printstring msg1
stringinput str1
printstring msg2
stringinput str2

mov di,offset str1
inc di
inc di
call findstringlength
mov len1,cl

mov di,offset str2
printstring newline
inc di
inc di
call findstringlength
mov len2,cl




mov al,len1
mov bl,len2
cmp al,bl
jnz loop3

mov di,offset str1
mov si,offset str2
inc di
inc di
inc si
inc si

mov cl,len1
loopx:
	cmp cl,0
	;printstring msg3
	je loopy
	mov al,[si]
	mov bl,[di]
	inc di
	inc si
	cmp al,bl
	jnz loop3
	dec cl
	jmp loopx	

loopy:
	printstring msg3
	jmp loop4



loop3:
	printstring msg4


loop4:
	mov ah,4ch
	int 21h

findstringlength proc
	mov bl,'$'
	mov cl,0
	loop1:
		cmp [di],bl
		jz loop2
		inc di
		inc cl
		jmp loop1
	loop2:
		ret
		endp


code ends
end start