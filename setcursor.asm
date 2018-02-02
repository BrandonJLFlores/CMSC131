;Setting the Cursor
;reference: p. 139, Clearing the Screen

TITLE ASM1 (SIMPLIFIED .EXE )
.MODEL SMALL
;---------------------------------------------
.DATA
  MESSAGE DB "HELLO WORLD!!!$"
  MESSAGE2 DB "HI UNIVERSE!!!$"
;---------------------------------------------
.CODE
MAIN PROC FAR
  MOV AX, @data
  MOV DS, AX

  ;clear the screen
  CALL CLEAR_SCREEN

  ;set the cursor
  MOV DX, 0100H
  PUSH DX
  CALL SET_CURSOR

  ;display MESSAGE
  LEA DX, MESSAGE
  PUSH DX
  CALL DISPLAY

  ;set the cursor
  MOV DX, 1800H
  PUSH DX
  CALL SET_CURSOR

  ;display MESSAGE2
  LEA DX, MESSAGE2
  PUSH DX
  CALL DISPLAY

  MOV AH, 4CH
  INT 21H

MAIN ENDP

DISPLAY PROC NEAR
  POP BX
  POP DX
  PUSH BX
  MOV AH, 9
  INT 21H

  RET
DISPLAY ENDP

CLEAR_SCREEN PROC NEAR
  MOV AX, 0600H   ;full screen
  MOV BH, 71H     ;white background (7), blue foreground (1)
  MOV CX, 0000H   ;upper left row:column (0:0)
  MOV DX, 184FH   ;lower right row:column (24:79)
  INT 10H

  RET
CLEAR_SCREEN ENDP

SET_CURSOR PROC NEAR
  POP BX
  POP DX
  PUSH BX
  MOV AH, 02H   ;function code to request for set cursor
  MOV BH, 00    ;page number 0, i.e. current screen
  ;MOV DH, 12    ;set row
  ;mov DL, 40    ;set column
  INT 10H

  RET
SET_CURSOR ENDP
END MAIN
