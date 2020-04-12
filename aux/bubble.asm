
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
GRADES : DB   12,30,15,24,25,22,27,13,12,18
;12,30,15,24,25,22,27,13,12,18,20,17,10,4,19,29,28,21,11,5,0,9,7,18,26
.CODE
MOV   CX , 9    
MOV   SI , 00 ; AS COUNTER

BUBBLE:
    CMP CX,SI
    JZ  NEXT  
    MOV AL, GRADES[SI]
    MOV BL , GRADES[SI + 1]
    CMP AL , BL
    JB  SWAP
    ADD SI , 1
    JMP BUBBLE
    
    SWAP:
    MOV GRADES[SI],BL
    MOV GRADES[SI+1],AL 
    ADD SI,1
    JMP BUBBLE
    
    NEXT:
    MOV SI,00
    SUB CX,1
    CMP CX,0
    JNZ BUBBLE
; mov ax , [data]  

ret




