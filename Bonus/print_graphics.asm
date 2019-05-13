
.stack 100h
.data

Jan   db  "         January           ",13
      db  "Sun Mon Tue Wed Thu Fri Sat",13
      db  "                 1   2   3 ",13
      db  " 4   5   6   7   8   9  10 ",13
      db  "11  12  13  14  15  16  17 ",13
      db  "18  19  20  21  22  23  24 ",13
      db  "25  26  27  28  29  30  31 ",0
color db 181
x     db 0     ;SCREEN COORDINATE (COL).
y     db 0     ;SCREEN COORDINATE (ROW).

.code          
;INITIALIZE DATA SEGMENT.
  mov  ax,@data
  mov  ds,ax 

;SWITCH SCREEN TO GRAPHICS MODE.
  mov  ah,0
  mov  al,13h  ;320x240x256.
  int  10H

  mov  di, offset jan
while:      
  call gotoxy  ;SET CURSOR POSITION FOR CURRENT CHAR.
  mov  al, [ di ]  ;CHAR TO DISPLAY.
  cmp  al, 13    ;IF CHAR == 13
  je   linebreak ;THEN JUMP TO LINEBREAK.
  cmp  al, 0   ;IF CHAR == 0
  je   finish  ;THEN JUMP TO FINISH.
  call char_display  ;DISPLAY CHAR IN AL WITH "COLOR".
  inc  x  ;NEXT CHARACTER GOES TO THE RIGHT.
  jmp  next_char
linebreak:  
  inc  y  ;MOVE TO NEXT LINE.    
  mov  x, 0  ;X GOES TO THE LEFT.
next_char:
  inc  di  ;NEXT CHAR IN "JAN".
  jmp  while

finish:

;WAIT FOR ANY KEY.
  mov  ah,7
  int  21h

;FINISH THE PROGRAM PROPERLY.
  mov  ax,4c00h
  int  21h        

;-------------------------------------------------     
;DISPLAY ONE CHARACTER IN "AL" WITH "COLOR".

proc char_display
  mov  ah, 9
  mov  bh, 0
  mov  bl, color  ;ANY COLOR.
  mov  cx, 1  ;HOW MANY TIMES TO DISPLAY CHAR.
  int  10h
  ret
endp    

;-------------------------------------------------     
proc gotoxy
  mov dl, x
  mov dh, y
  mov ah, 2 ;SERVICE TO SET CURSOR POSITION.
  mov bh, 0 ;PAGE.
  int 10h   ;BIOS SCREEN SERVICES.  
  ret
endp

ret




