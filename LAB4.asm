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
MESSAGE1 DB "Digits: $"
MESSAGE2 DB 10,13,"Uppercase: $"
MESSAGE3 DB 10,13, "Lowercase: $"
SPACE DB " $"
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
  MOV AX, DATASEG
  MOV DS, AX

  ;set counter
  MOV CX, 10

  ;set to first ASCII char
  MOV AL, 48

  MOV AH, 9
  LEA DX, MESSAGE1
  INT 21H
  
  
  DISPLAY_DIGITS:
    MOV AH, 02
    MOV DL, AL ;print one byte only
    INT 21H
	
	;, 32
	;JMP PRINT_SPACE
	MOV AH,09
	LEA DX, SPACE
	INT 21H

    INC AL
    LOOP DISPLAY_DIGITS
	
	MOV AL, 65
	MOV CX, 26
	
	MOV AH, 9
  LEA DX, MESSAGE2
  INT 21H
	
	DISPLAY_UPPER:
	MOV AH, 02
    MOV DL, AL ;print one byte only
    INT 21H

	;JMP PRINT_SPACE
	MOV AH,09
	LEA DX, SPACE
	INT 21H
	
    INC AL
    LOOP DISPLAY_UPPER
	
	MOV AH, 9
  LEA DX, MESSAGE2
  INT 21H
	
	MOV AL, 97
	MOV CX, 26
	
	DISPLAY_LOWER:
	MOV AH, 02
    MOV DL, AL ;print one byte only
    INT 21H

	;JMP PRINT_SPACE
	MOV AH,09
	LEA DX, SPACE
	INT 21H
	
    INC AL
    LOOP DISPLAY_LOWER

EXIT:
  MOV AH, 4CH
  INT 21H
CODESEG ENDS
END START
