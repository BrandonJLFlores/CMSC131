TITLE ASM1 (.EXE MODEL)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;---------------------------------------------
DATASEG SEGMENT PARA 'Data'
	LIN1 DB 0AH, 0DH, "         *           *          *       *"
	LIN2 DB 0AH, 0DH, "         *          * *          *     *"
	LIN3 DB 0AH, 0DH, "         *         *   *          *   *"
	LIN4 DB 0AH, 0DH, "         *        *     *          * *"
	LIN5 DB 0AH, 0DH, "         *       *********          *"
	LIN6 DB 0AH, 0DH, "         *      *         *         *"
	LIN7 DB 0AH, 0DH, "*        *     *           *        *"
	LIN8 DB 0AH, 0DH, "*        *    *             *       *"
	LIN9 DB 0AH, 0DH, "**********   *               *      *$"
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
	; SET DS to correct value
	MOV AX, DATASEG
	MOV DS, AX
	
	;code part
	
	LEA DX, LIN1
	MOV AH, 9
	INT 21H
	
	
	; return/exit
	MOV AH, 4CH
	INT 21H
CODESEG ENDS
END START
