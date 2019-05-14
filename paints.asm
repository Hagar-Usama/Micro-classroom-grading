; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    color db 2
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    ;**************************************************
    ;##################################################

main proc far
                     
 
; preparing for graphics mode 
mov al, 13h
mov ah, 0   ; set graphics video mode.
int 10h   

;making initial color is green
mov al, 2 
mov color ,al

call color_indicate
 

;start of program :
Next:
mov ax, 3   ;get cursor positon in cx,dx
int 33h

;useless for some reason
call show_cursor

; if left_click , then draw 
cmp bx , 1
jne Step_2

call putpix ;call procedure


Step_2:
; if right_click, then change color
cmp bx , 2
jne Step_3
call inc_color
call color_indicate

Step_3:
cmp bx,3
jne Next
call dec_color
call color_indicate


jmp Next

 
main endp
 
 
;procedure to print
putpix proc 
      
mov al, color  ;color of pixel  
mov ah, 0ch    
shr cx,1    ; cx will get double so we divide it by two
int 10h     ; set pixel.
ret
putpix endp 
;**************************************************
color_indicate proc
; ah = 0ah >> print character
mov ah , 0ch
mov al, color 

xor bx, bx
mov cx, 007h 
mov dx, 007h 

lineloop:
int 10h 
mov al , color
dec CX
jns lineloop
; draw another pixel.
    
ret
color_indicate endp
;*****************************************
tele proc
; ah = 0ah >> print character

mov al , 'a'
mov ah, 0eh
int 10h



; draw another pixel.
    
ret
tele endp

;*****************************************
inc_color proc 
    mov al , color
    inc al
    mov color , al
    
ret
inc_color endp

;******************************************
dec_color proc 
    mov al , color
    ;dec al
    sub al , 1
    mov color , al
    
ret
dec_color endp

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
CLRSCR PROC
        MOV     AH,6     ; SCROLL UP FUNCTION
        XOR     AL,AL    ; CLEAR SCREEN
        XOR     CX,CX    ;UPPER LEFT CORNER >> CH(ROW) , CL(COL)
        MOV     DX,184FH ;LOWER RIGHT CORNER>> DH(ROW) , DL(COL)
        MOV     BH,1EH  ; BLUE BACK , YELLOW FONT 
        INT     10H
        RET
CLRSCR ENDP             
;********************

code ends 
    

    ;##################################################
    ;**************************************************        
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
