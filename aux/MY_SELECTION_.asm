
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.DATA
NUM DB 15,20,05,70,80,67
MAX DB ?
MSG DB 0Dh,0Ah, 0Dh,0Ah, 'SORTED ARRAY: $'

ID  DW '4970','5020','1020','1234'.'9862'

INDEX DB ?
.CODE

;SELECTION SORT

MOV DX,6 ; 6=SIZE , N
DEC DX
MOV SI,0

OUTLOOP:
    MOV CX,DX        ;CX = SIZE-1
    MOV DI,SI        ;J=I
    MOV AL,NUM[DI]   ;AL = NUM[I]
    MOV MAX,AL       ;MAX = NUM[I]
    MOV BX,DI        ;BX = J
    
INLOOP:
    ADD DI,01        ;J++
    MOV AL,NUM[DI]   ;AL = NUM[J]
    CMP MAX,AL       ;IF(MAX < NUM[J]
    JAE XXX          ;
    MOV MAX,AL       ;MAX = NUM[J] 
    MOV BX,DI        ;BX = J
    
    
    ;MOV SI,DX
    ;MOV INDEX[SI],BL
    
    
XXX:
    LOOP INLOOP
    
    PUSH BX         
    MOV AL,NUM[SI]   ;AL = NUM[I]
    MOV DI,BX        ;J=BX >> HOLDS MAX
    
    
    
    MOV NUM[DI],AL   ;NUM[J] = NUM[I]
    MOV BL,MAX       ;BL = MAX
    MOV NUM[SI],BL   ;NUM[I] = MAX
    ADD SI,01H       ;I++
    DEC DX           ;N--
    JNZ OUTLOOP      ;END LOOP IF DX=0
    
;*****************************************
MOV CX,5
MOV SI,00

SPUSH: POP AX
LOOP SPUSH
    
;*****************************************
MOV CX,6
MOV SI,00

MOV DX,OFFSET MSG
MOV AH,9
INT 21H
    
;PRINT GRADES IN ORDER 
PRINT:
    CMP CX,SI
    JZ  EXIT
    MOV AL,NUM[SI]
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



MOV DX,OFFSET MSG
MOV AH,9
INT 21H


MOV CX,5
MOV SI,00


;PRINT GRADES IN ORDER 
PRINT2:
    CMP CX,SI
    JZ  EXIT2
    MOV AL,INDEX[SI]
    AAM
    MOV BL,AL
    MOV DL,BL
    ADD DL,30H
    MOV AH,2
    INT 21H
    
    MOV DL, 09H ; SPACE: 20H , TAB:09H
    INT 21H
    
    
    INC SI
    JMP PRINT2    

  
EXIT2:             


ret




