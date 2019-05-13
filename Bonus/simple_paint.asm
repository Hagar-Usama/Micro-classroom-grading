.data
color db 2

code segment
main proc far
 
 
; preparing for graphics mode 
mov al, 13h
mov ah, 0   ; set graphics video mode.
int 10h   

;making initial color is green
mov al, 2 
mov color ,al

;start of program :
Next:
mov ax, 3   ;get cursor positon in cx,dx
int 33h

;useless for some reason
call show_cursor

; if left_click , then draw 
cmp bx , 1
jne Next

call putpix ;call procedure

 call change_color
;if right_click, change_color
;cmp bx , 2
;jne Next

;call change_color
jmp Next

  
 
 
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
;mov al , 2
mov ah, 0ch    
shr cx,1    ; cx will get double so we divide it by two
int 10h     ; set pixel.
ret
putpix endp 

;*****************************************
change_color proc 
    mov al , color
    inc al
    mov color , al
    
ret
change_color endp

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