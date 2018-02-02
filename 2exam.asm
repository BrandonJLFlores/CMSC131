TITLE	LAB7 (SIMPLFIED .EXE FORMAT)
    		.MODEL SMALL
;---------------------------------------------
.STACK 32
;---------------------------------------------
.DATA

	MESSAGE1		DB		'Enter string: $'
	MESSAGE2		DB		'Enter search:  $'
	MESSAGE3		DB		'Program terminated successfully!$'

	STR_INPUT1	DB	31	DUP('$')
	STR_INPUT2	DB	31	DUP('$')

	TEMP1		DB	31	DUP('$')
	TEMP2		DB	31	DUP('$')

	TWO_PALI		DB		'You got 2 palindromes!$'
	ONE_PALI		DB		"It's just $"
	NO_PALI		DB		'Finals is coming!$'

	SPACE		DB	' $'
	FLAG			DB	0

	PALINDROME	DB	0,	'$'
	CNT			DB	0
	
	MAX_LENGTH	DW	30
;---------------------------------------------
.CODE
MAIN PROC FAR
	MOV	AX,	@data
	MOV	DS,	AX
	MOV	ES,	AX ;needs to set ES register

					;get first input
	LEA	DX,	MESSAGE1
	CALL	DISPLAY_STR

	MOV	AH,	3FH
	MOV	BX,	00
	MOV	CX,	MAX_LENGTH
	LEA	DX,	STR_INPUT1
	INT	21H
					;get second input
	LEA	DX,	MESSAGE2
	CALL	DISPLAY_STR

	MOV	AH,	3FH
	MOV	BX,	00
	MOV	CX,	MAX_LENGTH
	LEA	DX,	STR_INPUT2
	INT	21H 
	
;---------------------------------------------
	
	START:
	LEA	DX,	STR_INPUT1
	CALL DISPLAY_STR
	
	LEA	DX,	STR_INPUT2
	CALL	DISPLAY_STR
		
;---------------------------------------------

	EXIT:
		MOV	AH,	4CH
		INT	21H
		
 ;---------------------------------------------
   
	DISPLAY_STR	PROC	NEAR
		MOV	AH,	09H
		INT	21H
		RET
	DISPLAY_STR	ENDP
	
;---------------------------------------------	

MAIN ENDP
END MAIN