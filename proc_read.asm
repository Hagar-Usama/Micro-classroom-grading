
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.MODEL SMALL
;.STACK 100H
ORG 100H

.DATA
STR1 DB 'HELLO$'
STR2 DB 'HOW ARE YOU?$'
STR3 DB 'GOOD TO SEE YOU$'
GRADES DB ?



.code


;************** here my main function ***********************
MAIN PROC
    
 CALL READ   
 CALL WRITE   
    
    
;RET   
MAIN ENDP


WRITE PROC
;*****************************************
    MOV   CX , 5 ;N = 25    
    MOV   SI , 00 ; AS COUNTER


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
    
RET
WRITE ENDP


READ PROC
 
 MOV SI,00
 MOV CX,5 ; 5 GD2 
                
                
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
   
RET    
READ ENDP

             

END MAIN













