
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.MODEL SMALL
;.STACK 100H
ORG 100H
      
PRINT MACRO MSG
    ;PUSH AX
    LEA  DX,MSG
    MOV  AH,9
    INT  21H
    ;POP  AX
ENDM


.DATA
MSG0 DB 0Dh,0Ah, 0Dh,0Ah, 'ENTER Grades: $'
MSG1 DB 0Dh,0Ah, 0Dh,0Ah, 'ENTER IDs: $'
MSG2 DB 0Dh,0Ah, 0Dh,0Ah, 'SORTED ARRAY: $'
SPACE DB ' $'
STR1 DB 'HELLO$'
STR2 DB 'HOW ARE YOU?$'
STR3 DB 'GOOD TO SEE YOU$'
GRADES DB ?
IDS DW ?



.code


;************** here my main function ***********************
MAIN PROC
 
 PRINT MSG0   
    
 MOV SI,00
 MOV CX,5 ; 5 GD2
 CALL READ_GRD   
              
              
 MOV   CX , 4 ;N = 25    
 MOV   SI , 00 ; AS COUNTER
 CALL  SORT
 
 PRINT MSG2            
 MOV   CX , 5 ;N = 25    
 MOV   SI , 00 ; AS COUNTER            
 CALL WRITE   
    
    
;RET   
MAIN ENDP



WRITE PROC
;*****************************************
    PUSH AX
    PUSH BX
    PUSH DX
    
    

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

POP DX
POP BX
POP AX 
    
RET
WRITE ENDP

;***************************************

READ_GRD PROC
  
 PUSH AX
 PUSH BX
 PUSH DX               
                
 RD_INPUT:
 ;GET THE LEAST SIGNIFICANT GD1IT:
        ; into AL:
        MOV     AH, 01H
        INT     21H
        MOV     BH,AL
       
        
;GET THE MOST SIGNIFICANT GD1IT :
;STORE IT 100 BYTES FAR        
        
        MOV     AH, 01H
        INT     21h
        MOV     BL,AL   
        
        
        MOV     AX,BX
        SUB     AX,3030H
        AAD
        MOV     GRADES[SI],AL
        
;INCREMENT THE INDEX     
        INC     SI
        
        MOV     AH,02H
        MOV     DL, 20H ; SPACE: 20H , TAB:09H
        INT     21H
        
        
       
        CMP     SI,CX
        JNE     RD_INPUT
        
        
       
        MOV     DL, 0AH ; SPACE: 20H , TAB:09H
        INT     21H
   

POP DX
POP BX
POP AX

RET    
READ_GRD ENDP
;***************************************************

SORT PROC
PUSH AX
PUSH BX
PUSH DX               

;MOV CX,4 ; N-1 : 25-1 = 24
;MOV SI,00

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
                       
 
    ADD SI,1
    JMP BUBBLE
    
    NEXT:
    MOV SI,00
    SUB CX,1
    CMP CX,0
    JNZ BUBBLE
   

POP DX
POP BX
POP AX
    
RET
END SORT
             

END MAIN













