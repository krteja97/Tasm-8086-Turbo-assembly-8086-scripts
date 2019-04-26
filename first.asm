Assume cs: code, ds: data
Data segment
Input equ 3000h
Result equ 4000h
Data ends
Code segment
Start:Mov ax,data
 Mov ds,ax
 Mov si,input
 Mov al,[si]
 Inc si
 Mov bl,si
 Add al,bl
 Mov [di],al
 Int 03h
Code ends
End start 