print macro msg
	mov dx, offset msg
	mov ah,09h
	int 21h
	endm

takeinput macro
	mov ah,01h
	int 21h
	endm


DATA SEGMENT
array db 100 dup(?)
msg db 0dh,0ah,"Enter the length of the array: $"
msg1 db 0dh,0ah,"Enter a number: $"
msg2 db 0dh,0ah,"Enter the number to be searched: $"
newline db 0dh,0ah," $"
result1 db 0dh,0ah,"Found: $"
result2 db 0dh,0ah,"Not found: $"
len db ?
n db ?
counter db ?
DATA ENDS


CODE SEGMENT
assume cs:code, ds:data
start:
mov ax,data
mov ds,ax

print msg
call AcceptNumber
mov len,bl


mov cl,0
arrayInput: 
	cmp cl,len
	jnc searchNumberInput
	print msg1
	mov counter,cl
	call AcceptNumber
	mov cl,counter
	lea di,array
	mov ch,00h
	add di,cx
	mov [di],bl
	inc cl
	JMP arrayInput


searchNumberInput:
	print msg2
	call AcceptNumber
	mov n,bl

mov cl,0
linearSearch:
	cmp cl,len
	jnc notFound
	lea di,array
	mov ch,00h
	add di,cx
	mov bl,[di]
	cmp bl,n
	JE found
	inc cl
	JMP linearSearch



found:
	print result1
	JMP finalEnd

notFound:
	print result2

finalEnd:
mov ah,4ch
int 21h



AcceptNumber proc
	mov cl,4
	takeinput
	call ConvertToAscii
	shl al,cl
	mov bl,al
	takeinput
	call ConvertToAscii
	add bl,al
	ret
	endp


ConvertToAscii proc
	cmp al,41h
	jc pk
	sub al,07h
	pk:
		sub al,30h
	ret
	endp	

code ends
end start