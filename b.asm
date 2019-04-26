Data segment
msg db 0dh, 0ah, "first is greater $"
msg1 db 0dh, 0ah, "enter string 2 $"
Data ends

code segment
assume cs:Code, ds:Data
start:
    mov ax,Data
    mov ds,ax

mov ax,-27
mov bx,-25

cmp ax,bx
JGE end1



mov ah,4ch
int 21h

end1:
mov ah,09h
lea dx,msg
int 21h

mov ah,4ch
int 21h

code ends
end start