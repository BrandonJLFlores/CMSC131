;loop (iterative statements/iteration) in assembly (not recursion)
;C: for, while, do-while
;Java: for, while, do-while, foreach
;Assembly: jmp, loop, loopz/loope, loopnz/loopne
;(1) loop using jmp instruction (display character N times)
;(2) loop using loop instruction (display character N times)
;(3) loop using loop instruction (display all ASCII characters)
;ref: 4th edition, p. 118; 5th edition, p.???
TITLE LOOP USING JMP (.EXE MODEL/FORMAT)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;---------------------------------------------
DATASEG SEGMENT PARA 'Data'
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
  MOV AX, DATASEG
  MOV DS, AX

  ;set counter
  MOV CX, 128

  ;set to first ASCII char
  MOV AL, 0

  DISPLAY_CHAR:
    MOV AH, 02
    MOV DL, AL ;print one byte only
    INT 21H

    INC AL
    LOOP DISPLAY_CHAR

EXIT:
  MOV AH, 4CH
  INT 21H
CODESEG ENDS
END START
