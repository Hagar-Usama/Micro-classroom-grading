
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.DATA

.CODE
   
    MOV  AL,0FH
    AAA 
    MOV  BX,AX 
    MOV  DL,BH    ; WHAT IS INSIDE DL IS TO BE PRINTED
    ADD  DL,30H
    MOV  AH,2      ; WHEN AH = 2  >> OUTPUT , AH = 1 >> INPUT
    INT  21H
    
    MOV  DL,BL
    ADD  DL,30H
    MOV  AH,2
    INT  21H
    
    MOV  DL,0AH  ; NEWLINE
    INT  21H
    
    MOV  DL,07H ;BEEP
    INT  21H 
    
    MOV  DL,BL
    ADD  DL,30H
    INT  21H
    
    MOV  DL,BH
    ADD  DL,30H
    INT  21H
    

ret




