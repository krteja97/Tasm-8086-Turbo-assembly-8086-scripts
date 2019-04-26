Data segment
msg db 0dh, 0ah, "enter string 1 $"
msg1 db 0dh, 0ah, "enter string 2 $"
msgl db 0dh, 0ah, "string 1 smaller $"
msge db 0dh, 0ah, "equal $"
msgg db 0dh, 0ah, "string 1 greater $"

len1 db ?
len2 db ?

str1 db 16 dup ('?')
str2 db 16 dup ('?')
Data ends

disp macro msg
mov ah,09h
lea dx,msg
int 21h
endm

Code segment
assume cs:Code, ds:Data
start:
    mov ax,Data
    mov ds,ax

    ;enter string1
    mov dx, offset msg
    mov ah, 09h
    int 21h
    ;getting str1
    mov ah,0ah
    lea dx, str1
    int 21h
    ;nextline
    mov ah,2h
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    ;getting len1
    mov bl, str1+1
    add bl,30h
    mov len1, bl

    ;getting string2
    mov dx, offset msg1
    mov ah,09h
    int 21h
    ;getting str2
    mov ah, 0ah
    lea dx, str2
    int 21h 
    ;nextline
    mov ah,2h
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    ;getting len1
    mov bl, str2+1
    add bl,30h
    mov len2, bl

    lea dx,str1
    mov ah, 09h
    int 21h

    cmp len1,bl

    je equal
    jg greater

    disp msgl
    jmp next
    equal:
        disp msge
        jmp next
    greater:
        disp msgg
        jmp next

    next:

    mov ah,4ch
    int 21h

Code ends
end start