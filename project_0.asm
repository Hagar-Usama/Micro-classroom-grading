
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
MSG3 DB 0Dh,0Ah, 0Dh,0Ah, 'ID           : $'
SPACE DB ' $'
GRADES DB ?
IDS DW ?



.CODE


;************** here my main function ***********************
MAIN PROC
 
 PRINT MSG0   
    
 MOV SI,00
 MOV CX,05 ; 5 GD2
 CALL READ_GRD   
 
 PRINT MSG1   
    
 MOV SI,05
 MOV CX,10 ; 5 GD2
 CALL READ_GRD   
              
 ;PRINT MSG1
 ;MOV SI,00
 ;MOV CX,10 ; N=5 >> CX =10 
 ;CALL READ_ID  
    
 
 ;PRINT MSG1
 ;MOV SI,00
 ;MOV CX,10 ; N=5 >> CX =10 
 ;CALL WRITE_ID  
 
              
 MOV   CX , 4 ;N = 25    
 MOV   SI , 00 ; AS COUNTER
 CALL  SORT
 
 PRINT MSG2            
 MOV   CX , 05 ;N = 25    
 MOV   SI , 00 ; AS COUNTER            
 CALL WRITE
 
 PRINT MSG3            
 MOV   CX , 10 ;N = 25    
 MOV   SI , 05 ; AS COUNTER            
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

READ_ID PROC
    
PUSH AX
PUSH BX
PUSH DX

RD_IDS:

        
;GET THE MOST SIGNIFICANT DIGIT:
        MOV     AH, 01H
        INT     21H
        MOV     BH,AL
       
        
;GET THE LEAST SIGNIFICANT DIGIT :
        
        
        MOV     AH,01H
        INT     21H
        MOV     BL,AL   
        
        
        MOV     AX,BX
        SUB     AX,3030H
        AAD
        MOV     IDS[SI],AX
        

;GET THE MOST SIGNIFICANT GD1IT:
        
        MOV     AH, 01H
        INT     21H
        MOV     BH,AL
       
        
;GET THE LEAST SIGNIFICANT GD1IT :        
        
        MOV     AH, 01H
        INT     21H
        MOV     BL,AL   
        
        
        MOV     AX,BX
        SUB     AX,3030H
        AAD
        MOV     IDS[SI+1],AX


;INCREMENT THE INDEX     
        ADD     SI,2        
        
        MOV     AH,02H
        MOV     DL, 20H ; SPACE: 20H , TAB:09H
        INT     21H
        
        
       
        CMP     SI,CX
        JNE     RD_IDS




POP DX
POP BX
POP AX


RET
READ_ID ENDP

;***************************************************

WRITE_ID PROC
    PUSH AX
    PUSH BX
    PUSH DX
    
    

  ;PRINT GRADES IN ORDER 
PRINT1:
    CMP CX,SI
    JZ  EXIT
    MOV AX,IDS[SI]
    AAM
    MOV BX,AX
    MOV DL,BH
    ADD DL,30H
    MOV AH,2
    INT 21H
           
           
    MOV DL,BL
    ADD DL,30H
    INT 21H
    
    MOV AX,IDS[SI+1]
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
    
    
    ADD SI , 2
    JMP PRINT1    

EXIT1:    

POP DX
POP BX
POP AX 
    
RET
WRITE_ID ENDP

;***************************************
SWAP_GRD PROC
PUSH AX
PUSH BX
PUSH DX    
MOV GRADES[SI],BL
MOV GRADES[SI+1],AL


POP DX
POP BX
POP AX     
RET
SWAP_GRD ENDP
;***************************************
SWAP_ID PROC
PUSH AX
PUSH BX
PUSH DX    

; SI + N : WHERE N IS THE SIZE OF ARRAY WHICH IS 5
MOV AL, GRADES[SI + 5]
MOV BL , GRADES[SI + 6]

MOV GRADES[SI + 5],BL
MOV GRADES[SI+ 6],AL


POP DX
POP BX
POP AX     
RET
SWAP_ID ENDP

;***************************************

    
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
    CALL SWAP_GRD                   
    CALL SWAP_ID
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
SORT ENDP
;END SORT
             

END MAIN













