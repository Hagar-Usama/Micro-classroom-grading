
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

;org 100h
.MODEL SMALL
.STACK 100H 
.DATA
MSG1 DB 'ENTER THE FIRST NUMBER:$'
MSG2 DB 0DH , 0AH, 'ENTER THE SECOND NUMBER:$'
MSG3 DB 0DH , 0AH
MSG  DB ?,'$'

.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        LEA DX ,MSG1
        MOV AH,9
        INT 21H
        
        MOV AH,1
        INT 21H
        
        MOV CH,AL 
        
        LEA DX,MSG2
        MOV AH,9
        INT 21H
        
        MOV AH,1
        INT 21H
        
        ADD AL,CH  
        SUB AL,30H
        MOV MSG, AL
        
        LEA DX,MSG3
        MOV AH,9
        INT 21H
        
        
           
              
        MOV AH,4CH
        INT 21H
        MAIN ENDP
    END MAIN
; add your code here

ret




