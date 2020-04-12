
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.DATA
;GRADES[10] = 1,25,30,....
GRADES : DB   17,30,15,24,25,22,27,13,12,18 
IDS:     DB   "4970" , "5566","4999","4852","1256" 
TEMP:    DB    111 
TEMP2:   DB    111
;12,30,15,24,25,22,27,13,12,18,20,17,10,4,19,29,28,21,11,5,0,9,7,18,26
.CODE

;LETS USE STACK FOR SWAPING ID
MOV   SI,00
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

 






MOV   CX , 20 ; 4*5   
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



