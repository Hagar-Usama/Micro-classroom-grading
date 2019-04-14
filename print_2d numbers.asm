
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
IDS:   DB   "4970" , "5566","4999","4852","1256"
;12,30,15,24,25,22,27,13,12,18,20,17,10,4,19,29,28,21,11,5,0,9,7,18,26
.CODE

MOV   CX , 20    
MOV   SI , 00 ; AS COUNTER

SUBLOOP:
MOV   AX,IDS[SI] ; LAST 2-DIGITS OF ID
MOV   DX,AX
MOV   AH,2
INT   21H
XCHG  DL,DH
INT   21H
ADD   SI,2 

MOV   AX,IDS[SI] 
MOV   DX,AX
MOV   AH,2
INT   21H
XCHG  DL,DH
INT   21H
ADD   SI,2

MOV DL, 09H ; SPACE: 20H , TAB:09H
INT 21H
   
CMP   CX,SI
JA    SUBLOOP  ; END OF PRININT IDS



MOV CX,09
MOV SI,00
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
    
    MOV DL, 09H ; SPACE: 20H , TAB:09H
    INT 21H
    
    INC SI
    JMP PRINT    

  
EXIT:  
; mov ax , [data]  

ret




