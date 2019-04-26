print macro msg
	mov dx, offset msg
	mov ah,09h
	int 21h
	endm


printcharacter macro x
	mov ah,2h
	mov dl,x
	call convertToAscii
	int 21h
	endm

DATA SEGMENT
msg db 0dh,0ah, "error is there: $"
filename db "ravi.txt",0
string db 100 dup(0)
newline db 0dh,0ah, " $"
endchar db '$'
handle dw ?
consonants db 0
vowels db 0
totalcount db 0
DATA ENDS

CODE SEGMENT
assume cs:code, ds:data
start:
mov ax,data
mov ds,ax

;; open file
mov ax,3d02h
lea dx,filename
int 21h
jc error
mov handle,ax

;; read from file
mov ah,3fh
mov bx,handle
mov cx,100
lea dx,string
int 21h
jc error

mov totalcount,al
;;print contents in file read
print string

;; close file
mov	ah,3eh
mov	bx,handle
int	21h


mov cl,0
mov si,0
loop1:
	cmp cl,al
	JZ end1
	inc cl
	cmp string[si],' '
	JZ space
	cmp string[si],'a'
	JZ vowel
	cmp string[si], 'e'
	JZ vowel
	cmp string[si], 'i'
	JZ vowel
	cmp string[si], 'o'
	JZ vowel
	cmp string[si], 'u'
	JZ vowel
	inc consonants
	inc si
	JMP loop1

	vowel:
		inc vowels
		inc si
		JMP loop1

	space:
		inc si
		JMP loop1

error:
	print msg
	JMP end2

end1:
printcharacter consonants
print newline
printcharacter vowels

end2:
mov ah,4ch
int 21h



convertToAscii proc
	cmp dl,10
	jc pk
	add dl,7h
	pk:
		add dl,48
	ret
	endp

CODE ENDS
END START