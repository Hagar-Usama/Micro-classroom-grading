
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
                     
.DATA
 MSG DB 'HELLO WORLD FROM ASSEMBLY  :)$'
 
 .CODE
 MAIN PROC
      MOV AX, @DATA
      MOV DS ,AX
      LEA DX,MSG
      MOV AH,09H ;OUTPUT >>02h INPUT>>01H ,
      INT 21H
      END MAIN
; add your code here

ret




