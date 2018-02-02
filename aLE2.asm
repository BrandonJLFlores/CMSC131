TITLE LONGEXAM2 (.EXE FORMAT)
.MODEL SMALL
;-------------------------------------
.STACK 100H
;-------------------------------------
.DATA
	PROMPT1    DB 'Enter string: $'
	PROMPT2    DB 10, 13, 'Enter search: $'
	PROMPT3	   DB 10, 13,  'Found at location: $'
	PROMPT4	   DB 10, 13,  'Not Found$'
	MAINSTRING DB 20 DUP ('$')
	SUBSTRING  DB 20 DUP ('$')
	NEWLINE    DB 10, 13, '$'
	DELIMETER  DB '$'
	COUNT      DB ?
;-------------------------------------
.CODE
	MAIN PROC FAR
		;initialise DS
		MOV AX, @DATA
		MOV DS, AX
		MOV ES, AX
;-------------------------------------
		MOV AH, 09
		LEA DX, PROMPT1
		INT 21H

		MOV AH, 3FH
      	MOV BX, 00
      	MOV CX, 20
      	LEA DX, MAINSTRING
      	INT 21H
;------------------------------------
		MOV AH, 09
		LEA DX, PROMPT2
		INT 21H

		MOV AH, 3FH
      	MOV BX, 00
      	MOV CX, 20
      	LEA DX, SUBSTRING
      	INT 21H
;-------------------------------------
		CALL GET_SUBSTRING
;-------------------------------------
	MAIN ENDP
;-------------------------------------	
	GET_SUBSTRING PROC NEAR
		LEA SI, MAINSTRING
		LEA DI, SUBSTRING

		MOV BX, 00
		MOV COUNT, 00

		FIRST:
			MOV BL, [SI]
			MOV BH, [DI]
			
			;check if every character in mainstring is checked
			CMP BYTE PTR[SI],"$"
			JE NOT_EQUAL

			;INC COUNT

			;if equal, continue to check
			CMP BL, BH
			JE CHECK
			
			;if not equal, SI increments to find the first char of substring in mainstring
			INC SI
			JMP FIRST
;-------------------------------------
		CHECK:
			CMP BYTE PTR[DI], "$"
			JE EQUAL

			MOV BL, BYTE PTR[SI]
			
			CMP BYTE PTR[DI], BL
			JNE FIRST

			INC SI
			INC DI
			
			JMP CHECK
;-------------------------------------
		EQUAL:
			MOV AH, 09
			LEA DX, PROMPT3
			INT 21H	

			MOV DL, COUNT
			ADD DL, 30H
			MOV AH, 2
			INT 21H

			JMP EXIT			
;-------------------------------------
		NOT_EQUAL:
			MOV COUNT, 0

			MOV AH, 09
			LEA DX, PROMPT4
			INT 21H

			JMP EXIT
;-------------------------------------
		EXIT:
			MOV AH, 4CH
			INT 21H
	GET_SUBSTRING ENDP
END MAIN