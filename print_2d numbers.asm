
ORG 100H
; Microprocessor Project #0
; Hagar Usama   4970
;First part : bubble sort
; Apr 14, 2019 >> START
; Apr 15, 2019 2:17 AM >> END OF PROGRAM


.DATA
;GRADES[10] = 1,25,30,....
GRADES : DB   17,30,15,24,25,22,27,13,12,18,2,18,15,50,14,29,28,21,11,5,0,9,7,18,26 
IDS:   DB   "4970" , "5566","4999","4852","1256","5100" , "4120","4800","4020","3070","4121" , "4122","4123","4124","4125","4126" , "4127","4128","4129","4130","4131" , "4132","4133","4134","4135"
;12,30,15,24,25,22,27,13,12,18,20,17,10,4,19,29,28,21,11,5,0,9,7,18,26
.CODE

MOV CX,24 ; N-1 : 25-1 = 24
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
    ;SWAPPING GRADES
    MOV GRADES[SI],BL
    MOV GRADES[SI+1],AL
                       
                       
    ;SWAPPING IDS                       
    MOV   AX,IDS[SI+2] ; 70
    PUSH  AX
    MOV   AX,IDS[SI] ;49
    PUSH  AX
    MOV   AX,IDS[SI+6] ; 66
    PUSH  AX
    MOV   AX,IDS[SI+4] ;55
    PUSH  AX 

    POP  IDS[SI]
    POP  IDS[SI+2]
    POP  IDS[SI+4]
    POP  IDS[SI+6]
 
    ADD SI,1
    JMP BUBBLE
    
    NEXT:
    MOV SI,00
    SUB CX,1
    CMP CX,0
    JNZ BUBBLE



    MOV   CX , 25 ;N = 25    
    MOV   SI , 00 ; AS COUNTER

    ;MOV AX,30
    ;AAM
    ;ADD AX,3030H

              
;PRINT GRADES IN ORDER 
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
    

MOV DL, 0AH ; NEW LINE
MOV AH,2
INT 21H
INT 21H
;PRINT IDS
MOV   CX , 100 ;4*N = 4*25= 100   
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
 


ret




