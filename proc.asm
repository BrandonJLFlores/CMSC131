;PROCEDURES (functions/routines/programs)
;function/procedure name; receives parameters; returns values
;<proc name> PROC <address (near/far)>

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

  ;call proc
  CALL FUNC2

  MOV AH, 4CH
  INT 21H
MAIN ENDP

  ;FUNC2
  FUNC2 PROC NEAR
    ;display string
    MOV AH, 09
    LEA DX, STRING
    INT 21H

    CALL FUNC3
    RET
  FUNC2 ENDP

  ;FUNC3
  FUNC3 PROC NEAR
    ;display string
    MOV AH, 09
    LEA DX, STRING2
    INT 21H
    RET
  FUNC3 ENDP

CODESEG ENDS
END MAIN
