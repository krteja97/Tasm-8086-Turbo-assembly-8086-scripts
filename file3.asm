printstring macro str
	mov ah,09h
	mov dx,offset str
	int 21h
	endm

DATA SEGMENT
filename db "ravi.txt",0
msg db 0dh,0ah,"error is there: $"
len db ?
string db 100 dup('$')
handle dw ?

DATA ENDS

CODE SEGMENT
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax

mov ax,3d02h
mov dx, offset filename
int 21h
mov handle,ax

;;read

mov ax,3f00h
mov bx,handle
mov cx,100
mov dx,offset string
int 21h

;;close file

mov ax,3e00h
mov bx,handle
int 21h

printstring string



mov ah,4ch
int 21h

CODE ENDS
end start