;unconditional jump instruction (jmp <offset/label>)
;jmp before (backward) or after (forward) a certain point in the code
;refer to book by peter abel (IBM PC ASSEMBLY LANGUAGE AND PROGRAMMING):
;   - 4th edition: Chapter 8 (The JMP Instruction, p.116)
;   - 5th edition: Chapter 7 (The JMP Instruction, p.111)

TITLE UNCONDITIONAL JMP (.EXE MODEL/FORMAT)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;---------------------------------------------
DATASEG SEGMENT PARA 'Data'
  DATA1 DB "Display 1...$"
  DATA2 DB "Display 2...$"
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
  ;set DS correctly
  MOV AX, DATASEG
  MOV DS, AX

  JMP DISPLAY_DATA2

DISPLAY_DATA1:
  ;display DATA1
  MOV AH, 09
  LEA DX, DATA1
  INT 21H

  JMP EXIT

DISPLAY_DATA2:
  ;display DATA2
  MOV AH, 09
  LEA DX, DATA2
  INT 21H

  JMP DISPLAY_DATA1

EXIT:
  ;return/terminate/exit
  MOV AH, 4CH
  INT 21H
CODESEG ENDS
END START
