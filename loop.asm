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
  CHAR DB 'A', '$'
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
  MOV AX, DATASEG
  MOV DS, AX

  ;set the counter to 10
  MOV CX, 10

  DISPLAY_CHAR:

    ;check counter
    CMP CX, 0
    JE EXIT

    ;display char/string from data segment
    ;MOV AH, 09
    ;LEA DX, CHAR
    ;INT 21H

    ;display char from register/immediate value
    MOV AL, 'A'
    MOV AH, 02
    MOV DL, AL ;MOV DL, 41H ;MOV DL, 65 ;MOV DL, 'A'
    INT 21H

    ;decrement/increment
    DEC CX
    JMP DISPLAY_CHAR

EXIT:
  MOV AH, 4CH
  INT 21H
CODESEG ENDS
END START
