;PROCEDURES (functions/routines/programs)
;function/procedure name; receives parameters; returns values
;<proc name> PROC <address (near/far)>
;passing parameter thru the register
;IMPORTANT: make sure that DX is not changed in between (ie. before printing)

TITLE PROC (.EXE MODEL/FORMAT)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
  DW 32 DUP('X')
STACKSEG ENDS
;---------------------------------------------
DATASEG SEGMENT PARA 'Data'
  STRING DB 'Hello world!$'
  STRING2 DB 10, 13, 'Hi universe!$'
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
MAIN PROC FAR
  MOV AX, DATASEG
  MOV DS, AX

  ;call proc; pass STRING
  LEA DX, STRING
  CALL FUNC2

  ;call proc; pass STRING2
  LEA DX, STRING2
  CALL FUNC2

  MOV AH, 4CH
  INT 21H
MAIN ENDP

  ;FUNC2; receive parameter
  FUNC2 PROC NEAR
    ;display string
    MOV AH, 09
    ;LEA DX, STRING
    INT 21H
    RET
  FUNC2 ENDP

CODESEG ENDS
END MAIN
