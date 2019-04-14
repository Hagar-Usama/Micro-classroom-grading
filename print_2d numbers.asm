
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

;org 100h
ORG 100H
; add your code here
; tyb
; Microprocessor Project #0
; Hagar Usama   4970
;First part : bubble sort
; Apr 14, 2019

.DATA
;GRADES[10] = 1,25,30,....
GRADES : DB   17,30,15,24,25,22,27,13,12,18
;12,30,15,24,25,22,27,13,12,18,20,17,10,4,19,29,28,21,11,5,0,9,7,18,26
.CODE
MOV   CX , 10    
MOV   SI , 00 ; AS COUNTER

 MOV AX,30
 AAM
 ADD AX,3030H
 

PRINT:
    CMP CX,SI
    JZ  EXIT
    MOV AL,GRADES[SI]
    AAM
    MOV BX,AX
    MOV DL,BH
    ADD DL,30H
    MOV AH,2
    INT 21H
    
    MOV DL,BL
    ADD DL,30H
    INT 21H
    
    MOV DL, 20H ; SPACE
    INT 21H
    
    INC SI
    JMP PRINT    

  
EXIT:  
; mov ax , [data]  

ret




