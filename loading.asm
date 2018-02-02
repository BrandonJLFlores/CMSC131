TITLE		PROCEDURE (COM)
			.MODEL 	SMALL
			.STACK	64
			.CODE
			ORG		100H
			JMP 	A10MAIN
TEMP		DB		?
LOAD_STR	DB		'Loading...$'
COMPLETE_STR	DB		'Complete!     $'
;-------------------------------------------
A10MAIN		PROC	FAR

			;set DS to address of code segment
			MOV		AX, @CODE
			MOV 	DS, AX

			;clear screen
			CALL	_CLEAR_SCREEN

			;set cursor
			MOV		DL, 22H
			MOV		DH, 11
			CALL	_SET_CURSOR

			;display loading
			MOV		AH, 09H
			LEA		DX, LOAD_STR
			INT		21H

			MOV		TEMP, 00

	__ITERATE:
			;set cursor
			MOV		DL, TEMP
			MOV		DH, 12
			CALL	_SET_CURSOR

			;display char from register
			MOV		AL, 0DBH
			MOV		AH, 02H
			MOV		DL, AL
			INT		21H

			CALL	_DELAY

			INC		TEMP
			CMP		TEMP, 50H
			JE		_TERMINATE

			JMP		__ITERATE
A10MAIN		ENDP
;-------------------------------------------
_TERMINATE PROC	NEAR
			;set cursor
			MOV		DL, 22H
			MOV		DH, 11
			CALL	_SET_CURSOR

			;display complete string
			MOV		AH, 09H
			LEA		DX, COMPLETE_STR
			INT		21H

			;set cursor
			MOV		DL, 00
			MOV		DH, 13
			CALL	_SET_CURSOR

			MOV		AX, 4C00H
			INT		21H
_TERMINATE ENDP
;-------------------------------------------
_CLEAR_SCREEN PROC	NEAR
			MOV		AX, 0600H
			MOV		BH, 71H
			MOV 	CX, 0000H
			MOV		DX, 184FH
			INT		10H
			RET
_CLEAR_SCREEN ENDP
;-------------------------------------------
_SET_CURSOR PROC	NEAR
			MOV		AH, 02H
			MOV		BH, 00
			INT		10H
			RET
_SET_CURSOR ENDP
;-------------------------------------------
_DELAY PROC	NEAR
			mov bp, 2 ;lower value faster
			mov si, 2 ;lower value faster
		delay2:
			dec bp
			nop
			jnz delay2
			dec si
			cmp si,0
			jnz delay2
			RET
_DELAY ENDP
;-------------------------------------------
			END 	A10MAIN
