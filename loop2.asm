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
  MOV CX, 10

  DISPLAY_CHAR:
    MOV AH, 02
    MOV DL, 'A'
    INT 21H
    LOOP DISPLAY_CHAR ;decrement CX by 1 implicitly and check if CX = 0, if so, exit
    ;using loop, no need to (1) check for counter and (2) inc/dec counter
    ;what's needed is to set the counter

EXIT:
  MOV AH, 4CH
  INT 21H
CODESEG ENDS
END START
