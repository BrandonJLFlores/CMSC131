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
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
	; SET DS to correct value
	MOV AX, DATASEG
	MOV DS, AX
	
	;first question
	;print
	MOV AH, 09
	LEA DX, QUESTION1
	INT 21H
	
	;ask input
	MOV AH,10H
	INT 16H 
	MOV INPUT1,AL 
	
	
	;second question
	;print
	MOV AH, 09
	LEA DX, QUESTION2
	INT 21H
	
	;ask input
	MOV AH,10H
	INT 16H 
	MOV INPUT2,AL
	
	;third question
	;print
	MOV AH, 09
	LEA DX, QUESTION3
	INT 21H
	
	;ask input
	MOV AH,10H
	INT 16H 
	MOV INPUT3,AL
	
	;final message
	MOV AH,09H 
	LEA DX, MESSAGE1
	INT 21H 
	
	; return/exit
	MOV AH, 4CH
	INT 21H
CODESEG ENDS
END START
