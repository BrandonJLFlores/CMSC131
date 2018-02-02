TITLE PALINDROME (SIMPLFIED .EXE FORMAT)
.MODEL SMALL
;---------------------------------------------
.STACK 32
;---------------------------------------------
.DATA
	INPUT1 DB ?, "$"
	INPUT2 DB ?, "$"
	SIZE1 DW ?, "$"
	SIZE2 DW ?, "$"
  
	STRING1 DB "String 1>$"
	STRING2 DB 10,13,"String 2>$"
	STRING_IF2 DB 10,13,"You got 2 panlindromes!$"
	STRING_IF1 DB 10,13,"It's just '$"
	STRINGQUIT DB 10,13,"Program terminated successfully$"
	STRINGBOTH DB 10,13,"Finals is coming!$"
	
	TEMP1  DB 32 DUP(' ')
	TEMP2  DB 32 DUP(' ')
	KBINPUT1 DB 32 DUP('$')
	KBINPUT2 DB 32 DUP('$')
	NEWLINE DB 10,13,'$'
	CTR DB ?
;---------------------------------------------
.CODE
MAIN PROC FAR
  MOV AX, @data
  MOV DS, AX
  MOV ES, AX ;needs to set ES register

  
  ITERATE:
	MOV CTR, 0
	
	;SIZE + REVERSE1
	LEA DX, KBINPUT1
	CALL CHECK_SIZE
	LEA SI, KBINPUT1
    LEA DI, TEMP1
	CALL REVERSE
	;CALL PALINDROME1
	
	;SIZE + REVERSE2
    LEA DX, KBINPUT2
	CALL CHECK_SIZE
	LEA SI, KBINPUT2
    LEA DI, TEMP2
	CALL REVERSE
	;CALL PALINDROME2
	
	CLD               ;clear direction flag (left to right)
	;MOV CX, 16        ;initializes CX (counter) to 16 bytes
	LEA DI, TEMP2  ;initialize receiving/destination address
	LEA SI, KBINPUT2  ;initialize sending/soure address

	ITERATE2:

   ; MOV AL, [SI]
   ; MOV AH, [DI]
   ; CMP AL, AH
    ;JNE nEQUAL

    ;INC SI
    ;INC DI

	lea DX,STRING_IF1
	MOV AH,9
	int 21h
	
	
	
	;LEA DX, STRINGBOTH
	;CALL PRINT
	
    LOOP ITERATE2
	
	;CLD    ;clear direction flag (left to right)
	;ADD CX,2
	;LEA DI, KBINPUT2  ;initialize receiving address
	;LEA SI, TEMP2  ;initialize sending address
	;REPE CMPSB        ;compare byte by byte (repeat if equal)
	;JE EQUAL  
	;JNE	nEQUAL
	;PRINT
	;LEA DX, TEMP1
	;CALL PRINT
	;LEA DX, TEMP2
	;CALL PRINT
	
  
	CMP KBINPUT1, 51H
	JE EXIT
	CMP KBINPUT1, 71H
	JE EXIT
	CMP KBINPUT2, 51H
	JE EXIT
	CMP KBINPUT2, 71H
	JE EXIT
	
	JMP ITERATE
  

EXIT:
  MOV AH, 4CH
  INT 21H
MAIN ENDP

PALINDROME1 PROC NEAR
	CLD               ;clear direction flag (left to right)
	LEA DI, KBINPUT1  ;initialize receiving address
	LEA SI, TEMP1  ;initialize sending address
	REPE CMPSB        ;compare byte by byte (repeat if equal)
	JE EQUAL     ;alternative, CMPSW
	
	RETT1:
	RET
PALINDROME1 ENDP

PALINDROME2 PROC NEAR
	CLD               ;clear direction flag (left to right)
	LEA DI, KBINPUT2  ;initialize receiving address
	LEA SI, TEMP2  ;initialize sending address
	REPE CMPSB        ;compare byte by byte (repeat if equal)
	JE EQUAL     ;alternative, CMPSW
	
	RETT2:
	RET
PALINDROME2 ENDP

nEQUAL:
	LEA DX, STRING2
	CALL PRINT
	jmp EXIT
	
EQUAL:
	LEA DX, STRING1
	CALL PRINT
	jmp EXIT
	;JMP RETT1

REVERSE PROC NEAR
	ADD CX, -2
    ADD SI, CX
    
    L1:
       MOV AL, [SI]
       MOV [DI], AL
       DEC SI
       INC DI
    LOOP L1
	
       MOV AL, [SI]                                    
       MOV [DI], AL
       INC DI
       MOV DL, '$'
       MOV [DI], DL
	   
	RET
REVERSE ENDP

CHECK_SIZE PROC NEAR
	MOV AH, 3FH
	MOV BX, 00
	MOV CX, 32
	INT 21H
	MOV CX, AX ;size
	
	RET
CHECK_SIZE ENDP
	
PRINT PROC NEAR
	MOV AH, 09
	INT 21H
	LEA DX, NEWLINE
	MOV AH,9
	INT 21H
	
	RET
PRINT ENDP

END MAIN
