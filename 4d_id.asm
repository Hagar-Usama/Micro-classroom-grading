
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
  
  
 ;READ GRADES 
 PRINT MSG0      
 MOV SI,00
 MOV CX,05 ; 5 GD2
 CALL READ_GRD   
 
 ;READ IDS
 PRINT MSG1      
 MOV SI,05
 MOV CX,10 ; 5 GD2
 CALL READ_ID   
  
 ;SORT GRADES (BUBBLE)                          
 MOV   CX , 4 ;N = 25    
 MOV   SI , 00 ; AS COUNTER
 CALL  SORT
 
 ;PRINT SORTED GRADES
 PRINT MSG2            
 MOV   SI , 00 ; AS COUNTER
 MOV   CX , 05 ;N = 25            
 CALL WRITE
 
 ;PRINT SORTED GRADES
 PRINT MSG3            
 MOV   SI , 05 ; AS COUNTER
 MOV   CX , 10 ;N = 25              
 CALL WRITE_ID
 
 
    
;RET   
MAIN ENDP


;*****************************************
WRITE PROC

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


;*****************************************
WRITE_ID PROC

    PUSH AX
    PUSH BX
    PUSH DX
 
  ;PRINT GRADES IN ORDER 
PRNT:
    CMP CX,SI
    JZ  EXT
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
    
    MOV AL,GRADES[SI+5]
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
    
    
    ADD SI,1
    JMP PRNT    

EXT:    

POP DX
POP BX
POP AX 
    
RET
WRITE_ID ENDP

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
                
 RD_ID:
 ;GET THE LEAST SIGNIFICANT GD1IT:
        ; into AL:
        MOV     AH, 01H
        INT     21H
        MOV     BH,AL

;GET THE MOST SIGNIFICANT GD1IT :       
        
        MOV     AH, 01H
        INT     21h
        MOV     BL,AL   
        
        MOV     AX,BX
        SUB     AX,3030H
        AAD
        MOV     GRADES[SI],AL

;GET THE LEAST SIGNIFICANT GD1IT:
        ; into AL:
        MOV     AH, 01H
        INT     21H
        MOV     BH,AL

;GET THE MOST SIGNIFICANT GD1IT :       
        
        MOV     AH, 01H
        INT     21h
        MOV     BL,AL   
        
        MOV     AX,BX
        SUB     AX,3030H
        AAD
        MOV     GRADES[SI+5],AL
         
;INCREMENT THE INDEX     
        ADD     SI,1
        
        MOV     AH,02H
        MOV     DL, 20H ; SPACE: 20H , TAB:09H
        INT     21H
        
        
       
        CMP     SI,CX
        JNE     RD_ID
        
        
       
        MOV     DL, 0AH ; SPACE: 20H , TAB:09H
        INT     21H
   

POP DX
POP BX
POP AX

RET    
READ_ID ENDP


;***************************************************

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


MOV AL, GRADES[SI + 5]
MOV BL , GRADES[SI + 6] 

MOV GRADES[SI + 5],BL
MOV GRADES[SI+ 6],AL


MOV AL, GRADES[SI + 10]
MOV BL , GRADES[SI + 11] 

MOV GRADES[SI + 10],BL
MOV GRADES[SI+ 11],AL


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












