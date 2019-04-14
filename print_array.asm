
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.DATA
    ARR DB '10','20','30','40','50','60','70','80','90','00'
    
.CODE
MAIN PROC ; HAVE NO IDEA
    
    MOV  CX ,10
    LEA  SI,ARR
L1:
    MOV  DL , [SI]
    ;ADD  DL , 30H
    MOV  AH, 2
    INT  21H
    ;MOV  DL , 20H
    ;INT  21H
    INC  SI  
    
    MOV  DL , [SI]
    ;ADD  DL , 30H
    MOV  AH, 2
    INT  21H
    MOV  DL , 20H
    INT  21H
    INC  SI
    
    LOOP L1


ret




