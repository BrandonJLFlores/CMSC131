.MODEL SMALL
.STACK 100H
.DATA

TEMP DB ?,'$'

PROMPT1 DB 0DH,0AH,'Are you ready to play? (y for YES, n for NO):', '$'
PROMPT2 DB 0DH,0AH,'Please try again ', '$'
PROMPT3 DB 0DH,0AH,'What letter do you guess?  ', '$'
PROMPT4 DB 0DH,0AH,'The word is:',0DH,0AH, '$'
PROMPT5 DB 0DH,0AH,'Congratulations! You won the game',0DH,0AH, '$'
PROMPT6 DB 0DH,0AH,'Sorry you missed.',0DH,0AH, '$'
PROMPT7 DB 0DH,0AH,'Sorry, duplicate entry.  Please try again.',0DH,0AH, '$'
PROMPT8 DB 0DH,0AH,'List of chosen letter(s): ', '$'
CRLF   DB  0DH, 0AH, '$'

FIG0    DB 0DH,0AH,' +=======+',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
FIG1    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
FIG2    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'/        |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
FIG3    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'/ \      |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
FIG4    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'/|\      |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
FIG5    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'/|\      |',0DH,0AH,' |       |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
FIG6    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'/|\      |',0DH,0AH,' |       |',0DH,0AH,'/        |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
FIG7    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'/|\      |',0DH,0AH,' |       |',0DH,0AH,'/ \      |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
FIG8    DB 0DH,0AH,' +=======+',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'   \O/   |',0DH,0AH,'    |    |',0DH,0AH,'    |    |',0DH,0AH,'   / \   |',0DH,0AH,' ========+',0DH,0AH,'$'

STACK_INPUT DB ?,'$'

PROMPT DB 0DH, 0AH,'Please Enter The Message Number (0-9) ', '$'
ERROR DB 0DH, 0AH,'Input Must be a digit. Please enter again:', 0DH, 0AH,'$' 
MSG0 DB  'temperature$'
MSG1 DB  'ceremony$'
MSG2 DB  'paradise$'
MSG3 DB  'memorial$'
MSG4 DB  'wonderful$'
MSG5 DB  'substance$'
MSG6 DB  'animation$'
MSG7 DB  'boutique$'
MSG8 DB  'dangerous$'
MSG9 DB  'element$'

CREDIT    DB ?
correct   DB ?
incorrect DB ?
STR_L	  DB ?

MSG  DB ?,'$'

.CODE

;***************************************************************************
;	Main procedure
;***************************************************************************
MAIN	PROC
	MOV	AX,@DATA	;initialize DS
	MOV	DS,AX

	MOV  AH, 9     		;ask user to put a number from 0-9
    	LEA  DX, PROMPT
    	INT  21H
LOOP1:
    	MOV  AH, 1    		;read in an integer from user
    	INT  21H  

    	CMP  AL, 30H   
    	JB   RE_ENTER
    	CMP  AL, 39H
    	JA   RE_ENTER

    	CALL wordTable		;******* wordTable function call *******
	CALL matchWord		;******* matchWord function call *******

;ask if user wants to play again.
	MOV AH,9
	LEA DX,PROMPT2		;again?
	INT 21H
	JMP ENDWHILE
RE_ENTER:
    	MOV AH, 9
    	LEA DX, ERROR
    	INT 21H

    	JMP LOOP1

ENDWHILE:
	MOV AH,4CH
	INT 21H			;DOS exit
MAIN 	ENDP

;*************************************************************************
;	Display (bitmap) procedure
;*************************************************************************
DISPLAY PROC
;checking score value and display
        CMP incorrect,0
        JE DISP0

        CMP incorrect,1
        JE DISP1

        CMP incorrect,2
        JE DISP2

        CMP incorrect,3
        JE DISP3

        CMP incorrect,4
        JE DISP4

        CMP incorrect,5
        JE DISP5

        CMP incorrect,6
        JE DISP6

        CMP incorrect,7
        JE DISP7

        CMP incorrect,8
        JE DISP8

        ret

;display message0
DISP0:
        LEA DX,FIG0
        MOV AH,9
        INT 21h
        RET

DISP1:
;display message1
        LEA DX,FIG1
        MOV AH,9
        INT 21h
        RET

DISP2:
;display message2
        LEA DX,FIG2
        MOV AH,9
        INT 21h
        RET

DISP3:
;display message3
        LEA DX,FIG3
        MOV AH,9
        INT 21h
        RET

DISP4:
;display message4
        LEA DX,FIG4
        MOV AH,9
        INT 21h
        RET

DISP5:
;display message5
        LEA DX,FIG5
        MOV AH,9
        INT 21h
        RET

DISP6:
;display message6
        LEA DX,FIG6
        MOV AH,9
        INT 21h
        RET

DISP7:
;display message7
        LEA DX,FIG7
        MOV AH,9
        INT 21h
        RET

DISP8:
;display message8
        LEA DX,FIG8
        MOV AH,9
        INT 21h
        RET

DISPLAY ENDP

;*************************************************************************
;  wordTable procedure
;*************************************************************************
wordTable PROC
        ;INPUT: an integer from 0-9 from user
        ;OUTPUT: a coresponding message
	
    	CMP AL, 30H
    	JE MESSAGE0

    	CMP AL, '1'
    	JE MESSAGE1

    	CMP AL, '2'
    	;JE MESSAGE2
		JE m2

    	CMP AL, '3'
    	;JE MESSAGE3
		JE m3

    	CMP AL, '4'
    	;JE MESSAGE4
		je m4

    	CMP AL, '5'
    	;JE MESSAGE5
		je m5
		
    	CMP AL, '6'
    	;JE MESSAGE6
		je m6

    	CMP AL, '7'
    	;JE MESSAGE7
		je m7

    	CMP AL, '8'
    	;JE MESSAGE8
		je m8

;**************************** CASE message 9 ********************************   	
;copy string
	XOR SI,SI
COPY9:
	CMP MSG9[SI],'$'
	JE END9
	MOV AL,MSG9[SI]
	MOV MSG[SI],AL
	INC SI
	LOOP COPY9
END9:
	MOV MSG[SI],'$'
    	CALL displayEmpty
    	JMP END_WTABLE

;**************************** CASE message 0 ********************************
MESSAGE0: 	
;copy string
	XOR SI,SI
COPY0:
	CMP MSG0[SI],'$'
	JE END0
	MOV AL,MSG0[SI]
	MOV MSG[SI],AL
	INC SI
	LOOP COPY0
END0:
	MOV MSG[SI],'$'
    	CALL displayEmpty    	
    	JMP END_WTABLE

m2:
jmp MESSAGE2		
m3:
JMP MESSAGE3
m4:
JMP MESSAGE4
m5:
JMP MESSAGE5
m6:
JMP MESSAGE6

;**************************** CASE message 1 ********************************
MESSAGE1:
;copy string
	XOR SI,SI
COPY1:
	CMP MSG1[SI],'$'
	JE END1
	MOV AL,MSG1[SI]
	MOV MSG[SI],AL
	INC SI
	LOOP COPY1
END1:
	MOV MSG[SI],'$'
    	CALL displayEmpty     	
    	JMP END_WTABLE

m7:
JMP MESSAGE7
m8:
JMP MESSAGE8
;**************************** CASE message 2 ********************************
MESSAGE2:
;copy string
	XOR SI,SI
COPY2:
	CMP MSG2[SI],'$'
	JE END2
	MOV AL,MSG2[SI]
	MOV MSG[SI],AL
	INC SI
	LOOP COPY2
END2:
	MOV MSG[SI],'$'
    	CALL displayEmpty    	
    	JMP END_WTABLE

;**************************** CASE message 3 ********************************
MESSAGE3:
;copy string
	XOR SI,SI
COPY3:
	CMP MSG3[SI],'$'
	JE END3
	MOV AL,MSG3[SI]
	MOV MSG[SI],AL
	INC SI
	LOOP COPY3
END3:
	MOV MSG[SI],'$'
    	CALL displayEmpty    	
    	JMP END_WTABLE

;**************************** CASE message 4 ********************************
MESSAGE4:
;copy string
	XOR SI,SI
COPY4:
	CMP MSG4[SI],'$'
	JE END4
	MOV AL,MSG4[SI]
	MOV MSG[SI],AL
	INC SI
	LOOP COPY4
END4:
	MOV MSG[SI],'$'
    	CALL displayEmpty    	
    	JMP END_WTABLE

;**************************** CASE message 5 ********************************
MESSAGE5:
;copy string
	XOR SI,SI
COPY5:
	CMP MSG5[SI],'$'
	JE END5
	MOV AL,MSG5[SI]
	MOV MSG[SI],AL
	INC SI
	LOOP COPY5
END5:
	MOV MSG[SI],'$'
    	CALL displayEmpty     	
    	JMP END_WTABLE

;**************************** CASE message 6 ********************************
MESSAGE6:
;copy string
	XOR SI,SI
COPY6:
	CMP MSG6[SI],'$'
	JE END6
	MOV AL,MSG6[SI]
	MOV MSG[SI],AL
	INC SI
	LOOP COPY6
END6:
	MOV MSG[SI],'$'
    	CALL displayEmpty     	
    	JMP END_WTABLE

;**************************** CASE message 7 ********************************
MESSAGE7:
;copy string
	XOR SI,SI
COPY7:
	CMP MSG7[SI],'$'
	JE END7
	MOV AL,MSG7[SI]
	MOV MSG[SI],AL
	INC SI
	LOOP COPY7
END7:
	MOV MSG[SI],'$'
    	CALL displayEmpty     	
    	JMP END_WTABLE

;**************************** CASE message 8 ********************************
MESSAGE8:
;copy string
	XOR SI,SI
COPY8:
	CMP MSG8[SI],'$'
	JE END8
	MOV AL,MSG8[SI]
	MOV MSG[SI],AL
	INC SI
	LOOP COPY8
END8:
	MOV MSG[SI],'$'
    	CALL displayEmpty     	

END_WTABLE:
        RET

wordTable ENDP

;**************************************************************************
;	displayEmpty Procedure
;**************************************************************************
displayEmpty PROC
	MOV STR_L,0		;initialize string length
	MOV BL,'-'
	MOV AH,9
	LEA DX,CRLF
	INT 21H
;display dash
	XOR SI,SI		;resets index
BEGIN:
	CMP MSG[SI],'$'
	JE End_
	MOV TEMP[SI],BL
	INC STR_L
	INC SI
	JMP BEGIN
End_ :
	MOV TEMP[SI],'$'

	MOV AH,9
	LEA DX,TEMP
	INT 21H
	MOV AH,9
	LEA DX,CRLF
	INT 21H

 	RET

displayEmpty ENDP

;***************************************************************************
;	matchWord Procedure
;***************************************************************************
matchWord PROC
	MOV CREDIT,0		;initialize Credit
	MOV  correct,0		;initialize values of correct & incorrect
	MOV  incorrect,0
	MOV CX,7
INPUT:	;*********************** user input loop ***************************
	CMP CX,0
	JE  looses
	MOV DL,correct
	CMP DL,STR_L
	JE  wins
OTHER_INPUT:
	MOV AH,9	
	LEA DX,PROMPT3		;asks "What letter do you guess?"
	INT 21H
	MOV AH,1
	INT 21H
	MOV BL,AL		;save input to BL
	XOR SI,SI
CHECK_DUP:			;check if there is a duplicate entry
	CMP STACK_INPUT[SI],'$'
	JE  STORE_INPUT		
	CMP AL,STACK_INPUT[SI]
	JE  DUPLICATE
	INC SI
	JMP CHECK_DUP
DUPLICATE:
	MOV AH,9
	LEA DX,PROMPT7
	INT 21H
	JMP OTHER_INPUT	
STORE_INPUT:
	MOV STACK_INPUT[SI],BL
	INC SI
	MOV STACK_INPUT[SI],'$'

	MOV AH,9
	LEA DX,PROMPT8
	INT 21H	
	MOV AH,9
	LEA DX,STACK_INPUT
	INT 21H	

	MOV AH,9
	LEA DX,PROMPT4
	INT 21H			;Comment the user's guessing 
	XOR SI,SI		;resets index
COMPARE:;*********************** compares an char input to a word ***********
	CMP MSG[SI],'$'
	JE GETINPUT
	CMP BL,MSG[SI]		;input matches any letter of the word?
	JE GAIN_CORRECT
	INC SI
	JMP COMPARE
wins:
jmp WINCASE
looses:
jmp LOOSE
	

GAIN_CORRECT:
	MOV TEMP[SI],BL
	INC SI
	INC correct
	INC CREDIT
	JMP COMPARE
GETINPUT:
	MOV AH,9
	LEA DX,TEMP
	INT 21H
	CMP CREDIT,0
	JG  GAIN_SCORE
	DEC CX
	INC incorrect
GAIN_SCORE:
	CALL DISPLAY
	XOR SI,SI		;resets index
	MOV CREDIT,0
	JMP INPUT
WINCASE:
	MOV incorrect,8
	CALL DISPLAY
	MOV AH,9
	LEA DX,PROMPT5
	INT 21H
	JMP RESULT
LOOSE:
	MOV AH,9
	LEA DX,PROMPT6
	INT 21H	
RESULT:
	RET			;return to main

matchWord ENDP

END MAIN
	