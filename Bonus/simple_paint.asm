.data
color db 2

code segment
main proc far
 
 
 
mov al, 13h
mov ah, 0   ; set graphics video mode.
int 10h   

mov al, 2 
mov color ,al

Next:

mov ax, 3   ;get cursor positon in cx,dx
int 33h

;call hide_cursor

    
cmp bx , 2
je  change  

cmp bx , 1
jne Next
;if left click

  
call putpix ;call procedure 
 
jmp Next

change :
    mov al , color
    add al ,1
    mov color , al
    jmp Next


mov ah,4ch
int 21h
main endp
 
 
;procedure to print
putpix proc   
mov al, color  ;color of pixel  
mov ah, 0ch    
shr cx,1    ; cx will get double so we divide it by two
int 10h     ; set pixel.
ret
putpix endp 


;******************************************
show_cursor proc
mov ax, 1 
int 33h   

ret
show_cursor endp
;*********************
 
hide_cursor proc
mov ax, 2 
int 33h   

ret
hide_cursor endp 

;*********************
get_pos_stat proc

mov ax , 3
int 33h

ret
get_pos_stat endp
;******************** 


code ends 