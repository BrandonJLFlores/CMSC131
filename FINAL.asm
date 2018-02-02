TITLE ASM1 (.EXE MODEL)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;---------------------------------------------
DATASEG SEGMENT PARA 'Data'
	QUESTION1 DB "> Enter initial of first name:$"
	QUESTION2 DB 0AH, 0DH, "> Enter initial of middle name:$"
	QUESTION3 DB 0AH, 0DH, "> Enter initial of last name:$"
	MESSAGE1 DB 0AH, 0DH, 0AH, 0DH, "Initial of your first name is "
	INPUT1 DB ? 
	MESSAGE2 DB ", middle name is "
	INPUT2 DB ? 
	MESSAGE3 DB " and last name is "
	INPUT3 DB ?
	MESSAGE4 DB "!$"
	NEW_INPUT DB ?
	
	PRESS_ENTER DB 10,13,"PRESS ENTER TO CONTINUE$"
	GAME_TITLE DB 10,13
	DB "	    .----.                                               ",10,13
	DB "	   / .--. \                                _______       ",10,13
	DB "	  ' '    ' '                               \  ___ `'.    ",10,13
	DB "	  \ \    / /    ____________  ____________  ' |--.\  \   ",10,13
	DB "	   `.`'--.'    /___________/\/___________/\ | |    \  '  ",10,13
	DB "	   / `'-. `.   \___________\/\___________\/ | |     |  ' ",10,13
	DB "	  ' /    `. \                               | |     |  | ",10,13
	DB "	 / /       \ '  ____________  ____________  | |     ' .' ",10,13
	DB "	| |         | |/___________/\/___________/\ | |___.' /'  ",10,13
	DB "	| |         | |\___________\/\___________\//_______.'/   ",10,13
	DB "	 \ \       / /                             \_______|/    ",10,13
	DB "	  `.'-...-'.'                                            ",10,13
	DB "	     `-...-'											$",10,13
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
	; SET DS to correct value
	MOV AX, DATASEG
	MOV DS, AX
	
	MOV AH, 09
	LEA DX, GAME_TITLE
	INT 21H
	
	
	TITLESCREEN:
	CALL GET_KEY
	CMP NEW_INPUT, 0DH
	JE UP
	JMP TITLESCREEN
	
	UP:
	LEA DX, PRESS_ENTER
	MOV AH,9
	INT 21H
	
	; return/exit
	MOV AH, 4CH
	INT 21H
	
	COMPARE PROC NEAR
		CMP NEW_INPUT, 0DH
		JE UP
	RET
	COMPARE ENDP
	
	
	GET_KEY PROC NEAR	
	MOV		AH, 01H		;check for input
			INT		16H

			JZ		__LEAVETHIS

			MOV		AH, 00H		;get input	MOV AH, 10H; INT 16H
			INT		16H

			MOV		NEW_INPUT, AH
			
			;CALL COMPARE

	__LEAVETHIS:
			RET
GET_KEY 	ENDP


CODESEG ENDS
END START

