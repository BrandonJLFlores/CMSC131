;conditional jmp
;JE/JZ,JNE/JNZ,JA/JNBE,JB/JNAE,JAE/JNB,JBE/JNA
;refer to book by peter abel (IBM PC ASSEMBLY LANGUAGE AND PROGRAMMING):
;   - 4th edition: Chapter 8 (Conditional Jump Instructions, p.121)
;   - 5th edition: Chapter 7 (Conditional Jump Instructions, p.116)

TITLE CONDITIONAL JMP (UNSIGNED) (.EXE MODEL/FORMAT)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;---------------------------------------------
DATASEG SEGMENT PARA 'Data'
  CHAR_REF DB "B", "$"
  INPUT1 DB ?,0ah, 0dh,"$"
  STRING_EQUAL DB "EQUAL$"
  STRING_ABOVE DB "ABOVE$"
  STRING_BELOW DB "BELOW$"
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
  ;set DS correctly
  MOV AX, DATASEG
  MOV DS, AX

  ;get char input
  MOV AH, 10H
  INT 16H
  MOV INPUT1, AL

  ;display input
  MOV AH, 09
  LEA DX, INPUT1
  INT 21H

  ;comparison
  CMP AL, CHAR_REF ;cannot memory-memory, one must be at a register
  JA PRINT_ABOVE
  JB PRINT_BELOW

  MOV AH, 09
  LEA DX, STRING_EQUAL
  INT 21H

  JMP EXIT

PRINT_ABOVE:
  MOV AH, 09
  LEA DX, STRING_ABOVE
  INT 21H

  JMP EXIT

PRINT_BELOW:
  MOV AH, 09
  LEA DX, STRING_BELOW
  INT 21H

EXIT:
  ;return/terminate/exit
  MOV AH, 4CH
  INT 21H
CODESEG ENDS
END START
