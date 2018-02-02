_GET_KEY	PROC	NEAR
			MOV		AH, 01H		;check for input
			INT		16H

			JZ		__LEAVETHIS

			MOV		AH, 00H		;get input	MOV AH, 10H; INT 16H
			INT		16H

			MOV		NEW_INPUT, AH

	__LEAVETHIS:
			RET
_GET_KEY 	ENDP
