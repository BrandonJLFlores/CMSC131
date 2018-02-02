TITLE LONGEXAM1 (.EXE FORMAT)
.MODEL SMALL
;-------------------------------------
.STACK 100H
;-------------------------------------
.DATA
	PROMPT0 DB "MAX NUM IS 99", 10, 13, '$'
	PROMPT1 DB 10,13, 10, 13, "Enter N: $"
	INPUT 	DB 3
			DB ?
			DB 3 DUP (?)
	NEWLINE DB 10, 13, '$'
	SPACE   DB ' $'
	NUM     DB 71H
	COUNT   DB ?
;-------------------------------------
.CODE
	MAIN PROC FAR
		;initialise DS
		MOV AX, @DATA
		MOV DS, AX
;-------------------------------------
		MOV AH, 09
		LEA DX, PROMPT0
		INT 21H
;-------------------------------------
	MAINLOOP:	
		;display message
		MOV AH, 09
		LEA DX, PROMPT1
		INT 21H
;-------------------------------------
		MOV	AH, 00H
		INT	16H

		CMP AL, 27
		JE EXIT

		;capture characters
		MOV AH, 0AH
		MOV DX, OFFSET INPUT
		INT 21H
;-------------------------------------
		CALL CONVERT
;-------------------------------------
		MOV CX, 0
		MOV COUNT, 0
		MOV CX, BX

		MOV AH, 09
		LEA DX, NEWLINE
		INT 21H

		INLOOP:
			MOV AH, 02
			MOV DL, 36
			INT 21H

			CMP COUNT, 4
			JE  SPACES

			CMP COUNT, 9
			JE  NEWLINES

			INC COUNT

			CONTINUE:
				DEC CX
				CMP CX, 0

			JNE INLOOP

		JMP MAINLOOP
;-------------------------------------
	NEWLINES:
		MOV AH, 09
		LEA DX, NEWLINE
		INT 21H

		MOV COUNT, 0
		JMP CONTINUE
;-------------------------------------
	SPACES:
		INC COUNT

		MOV AH, 09
		LEA DX, SPACE
		INT 21H

		JMP CONTINUE
;-------------------------------------	
	EXIT:
		MOV AH, 4CH
		INT 21H	
	MAIN ENDP
;-------------------------------------
	CONVERT PROC NEAR
		MOV SI, OFFSET INPUT + 1
		MOV CL, [SI]
		MOV CH, 0
		ADD SI, CX

		MOV BX, 0
		MOV BP, 1

		L1:	
			MOV AL, [SI]
			SUB AL, 48
			MOV AH, 0
			MUL BP
			ADD BX, AX

			MOV AX, BP
			MOV BP, 10
			MUL BP
			MOV BP, AX

			DEC SI
			LOOP L1
			RET
	CONVERT ENDP
;--------------------------------------
GET_KEY PROC NEAR	
		
		RET
GET_KEY ENDP
;--------------------------------------

END MAIN	