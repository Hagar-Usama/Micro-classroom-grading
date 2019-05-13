
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
name "inc"
include "emu8086.inc"


.data
 result dw ? 
 button dw ? 
 row dw ?
 col dw ?

.code      

main proc     
int 33h
 

;show cursor
call show_cursor

lp:
call print_pos
mov cx,20
loop $ 

jmp lp
  
main endp 

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

print_pos proc
    ;Bx = 1,2,3 <<we can use BL
    ;cx = x position
    ;dx = y position
    
    
mov ax , 3
int 33h
    ;printing button state
    mov al , bl
    aam
    mov bx , ax
    mov dl , bh
    
    add dl ,30h
    
    mov ah , 2
    int 21h
    
    ;print space
    MOV DL, 09H ; SPACE: 20H , TAB:09H
    INT 21H
    
ret    
print_pos endp

end main




