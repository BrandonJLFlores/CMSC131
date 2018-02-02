TITLE PROCEDURES (.EXE MODEL)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;---------------------------------------------
DATASEG SEGMENT PARA 'Data'

;COPY PASTED FROM MY LAB 2 SUBMISSION
;--------------------QUESTIONS----------------------;
	QUESTION1 DB "> Enter initial of first name:$"
	QUESTION2 DB 0AH, 0DH, "> Enter initial of middle name:$"
	QUESTION3 DB 0AH, 0DH, "> Enter initial of last name:$"
;--------------------DATA----------------------;
	INPUT1 DB ? , "$"
	INPUT2 DB ? ,"$"
	INPUT3 DB ? , "$"
	INPUT DB ? , "$"
;--------------------MESSAGE----------------------;
	MESSAGE1 DB 0AH, 0DH, 0AH, 0DH, "Initial of your first name is $"
	MESSAGE2 DB ", middle name is $"
	MESSAGE3 DB " and last name is $"
	MESSAGE4 DB "!$"
	
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
	; SET DS to correct value
	MOV AX, DATASEG
	MOV DS, AX
	
	
;MAIN
MAIN PROC

;QUESTION1
	lea dx, question1
	push dx
	call ASKINPUT
	pop ax
	mov INPUT1,al


;QUESTION2
	LEA BX, QUESTION2
	PUSH BX
	CALL ASKINPUT	
	MOV INPUT2, AL
	
;QUESTION3
	LEA BX, QUESTION3
	PUSH BX
	CALL ASKINPUT
	MOV INPUT3, AL
	
;FOR DISPLAY
	MOV AX, INPUT1
	MOV BX, INPUT2
	MOV CX, INPUT3
	
	PUSH CX ;3rd param
	PUSH BX ;2nd param
	PUSH AX ;top of stack, 1st param

	CALL DISPLAY
	
	MOV AH,4CH
	INT 21H

MAIN ENDP
	
	
;------------------------------------------------
;ASK INPUT
ASKINPUT PROC
	pop bx
	pop dx
	
	MOV AH, 09H
	INT 21H
	
	MOV AH,10H
	INT 16H 
	MOV INPUT,AL 
	
	LEA DX, INPUT
	MOV AH,09
	INT 21H
	
	push bx
	push ax
	RET
	
ASKINPUT ENDP
	
;----------------------------------------------	
;DISPLAY INPUT
DISPLAY PROC
	PUSH BP				;SAVE BP
	MOV BP, SP			;BP = SP (2 return, 4, first param, 6, 2nd param, 8 3RD PARAM)

	MOV AH,09
	LEA DX, MESSAGE1
	INT 21H
	
	MOV AH,09
	LEA DX, 4[BP]
	INT 21H
	
	MOV AH,09
	LEA DX, MESSAGE2
	INT 21H
	
	MOV AH,09
	LEA DX, 6[BP]
	INT 21H
	
	MOV AH,09
	LEA DX, MESSAGE3
	INT 21H
	
	MOV AH,09
	LEA DX, 8[BP]
	INT 21H
	
	MOV AH,09
	LEA DX, MESSAGE4
	INT 21H
	
	MOV SP,BP
	POP BP
	
	RET
	
DISPLAY ENDP
	
CODESEG ENDS
END START
