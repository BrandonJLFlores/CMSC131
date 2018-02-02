;Clearing the Screen
;reference: p. 139, Clearing the Screen

TITLE ASM1 (SIMPLIFIED .EXE )
.MODEL SMALL
;---------------------------------------------
.DATA
  MESSAGE DB "HELLO WORLD!!!$"
;---------------------------------------------
.CODE
MAIN PROC FAR
  MOV AX, @data
  MOV DS, AX

  ;clear the screen
  CALL CLEAR_SCREEN

  LEA DX, MESSAGE
  MOV AH, 9
  INT 21H

  MOV AH, 4CH
  INT 21H

MAIN ENDP

CLEAR_SCREEN PROC NEAR
  MOV AX, 0600H   ;full screen
  MOV BH, 71H     ;white background (7), blue foreground (1)
  MOV CX, 0000H   ;upper left row:column (0:0)
  MOV DX, 184FH   ;lower right row:column (24:79)
  INT 10H

  RET
CLEAR_SCREEN ENDP
END MAIN
