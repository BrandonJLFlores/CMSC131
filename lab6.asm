TITLE LAB6 (SIMPLIFIED .EXE )
.MODEL SMALL
;---------------------------------------------
.DATA
  CHARA DB 'A$'
  TEMProw DB ?
  TEMPcol DB ?
  NEW_INPUT DB ?
  
;---------------------------------------------
.CODE
MAIN PROC FAR
	;SET DS
  MOV AX, @data
  MOV DS, AX

  ;clear the screen  
  MOV TEMProw, 12
  MOV TEMPcol, 03H
  
  LOOP_KUNO:  
  CALL CLEAR_SCREEN
  CALL CLEAR_SCREEN2
  
  ;SET CURSOR
  MOV DL, TEMPcol
  MOV DH, TEMProw
  CALL SET_CURSOR
  
  ;display CHARA
  lea dx, CHARA
  call display
	
  ;delay
  CALL	_DELAY
  
  ;get input
  CALL GET_KEY
  
  ;COMPARE
  CMP NEW_INPUT, 48H
  JE UP
  
  CMP NEW_INPUT, 4BH
  JE LEFT
  
  CMP NEW_INPUT, 4DH
  JE RIGHT
  
  CMP NEW_INPUT, 50H
  JE DOWN
  
  CMP NEW_INPUT, 01H
  JE EXIT
  JNE STOP
  
  EXIT:
  MOV AH, 4CH
  INT 21H

MAIN ENDP

;-------------------------------------
;INC & DEC
UP:
	DEC TEMProw
	CMP TEMProw, 0H
	JE RESETUP
    JMP LOOP_KUNO

LEFT:
	DEC TEMPcol
	CMP TEMPcol, 1H
	JE RESETLEFT
	JMP LOOP_KUNO
	
RIGHT:
	INC TEMPcol
	CMP TEMPcol, 4EH
	JE RESETRIGHT
	JMP LOOP_KUNO
	
DOWN :
	INC TEMProw
	CMP TEMProw, 18H
	JE RESETDOWN
	JMP LOOP_KUNO
 
STOP:
	JMP LOOP_KUNO
	
;--------------------------------------
;RESETS
RESETUP:
	MOV TEMProw, 17H
	JMP LOOP_KUNO
	
RESETLEFT:
	MOV TEMPcol, 4EH
	JMP LOOP_KUNO

RESETRIGHT:
	MOV TEMPcol, 01H
	JMP LOOP_KUNO
	
RESETDOWN:
	MOV TEMProw, 01H
	JMP LOOP_KUNO
	
;------------------------------------
DISPLAY PROC NEAR
  
  MOV AH, 9
  INT 21H

  RET
DISPLAY ENDP

;--------------------------------------
CLEAR_SCREEN PROC NEAR
  MOV AX, 0600H   
  MOV BH, 07H     
  MOV CX, 0000H   
  MOV DX, 184FH   
  INT 10H

  RET
CLEAR_SCREEN ENDP

;-------------------------------------
CLEAR_SCREEN2 PROC NEAR
  MOV AX, 0600H   
  MOV BH, 17H     
  MOV CX, 0101H   
  MOV DX, 174EH   
  INT 10H

  RET
CLEAR_SCREEN2 ENDP

;--------------------------------------
SET_CURSOR PROC NEAR
  MOV AH, 02H   ;function code to request for set cursor
  MOV BH, 00    ;page number 0, i.e. current screen
  INT 10H

  RET
 SET_CURSOR ENDP
 
;-------------------------------------
GET_KEY PROC NEAR	
	MOV		AH, 01H		;check for input
			INT		16H

			JZ		__LEAVETHIS

			MOV		AH, 00H		;get input	MOV AH, 10H; INT 16H
			INT		16H

			MOV		NEW_INPUT, AH

	__LEAVETHIS:
			RET
GET_KEY 	ENDP	

;-------------------------------------------
_DELAY PROC	NEAR
			mov bp, 1 ;lower value faster
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

END MAIN