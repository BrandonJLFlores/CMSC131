TITLE ASM1 (.EXE MODEL)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;---------------------------------------------
DATASEG SEGMENT PARA 'Data'
	MESSAGE DB "Cawfee! Gween Teeeeeaa! $"
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
	; SET DS to correct value
	MOV AX, DATASEG
	MOV DS, AX
	
	MOV AH, 09
	MOV DX, OFFSET MESSAGE
	; OR LEA DX, MESSAGE
	INT 21H
	
	
	; return/exit
	MOV AH, 4CH
	INT 21H
CODESEG ENDS
END START
