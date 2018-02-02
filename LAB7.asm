TITLE PALINDROME (SIMPLFIED .EXE FORMAT)
.MODEL SMALL
;---------------------------------------------
.STACK 100
;---------------------------------------------
.DATA
	
	;********	ASK INPUT ********;
  STRING1    DB    10, 13, 'String 1> $'
  STRING2   DB    'String 2> $'
  
	;******** RESULTS *********;
	PROMPT_NO  DB 'Finals is coming!$', 10, 13
	PROMPT_ONE DB "It's just $", 10, 13
  PROMPT_TWO DB 'You got 2 palindromes!$', 10, 13
	TERMINATE_STR DB 'Program terminated successfully!$'

  ;********* INPUT STORE **********;
  KBINPUT1  DB   100 DUP('$')
  KBINPUT2  DB   100 DUP('$')
	ORIG1  DB   100 DUP('$')
	ORIG2  DB   100 DUP('$')

	;********* QUIT (FOR COMPARISON) **********;
  QUIT1 DB 'q$', '0DH', '$'
  QUIT2 DB 'Q$', '0DH', 'S'

  TESTQUIT DB 71H, '$'
  TESTQUIT_CAPS DB 51H,'$'
  TESTQUIT2 DB 0AH, '$'

  MAXLEN DW 30
  SPACE   DB ' $'
  PALI_CTR DB 0,'$'
  CHECK_CTR DB 0, '$'
  CTR DB 0
  TEMPVAL DW 0000
;------------------------------------------------------------


.CODE
PRINTSTR MACRO STRING
	LEA DX,STRING
	MOV AH,9
	INT 21H
ENDM

MAIN PROC FAR


  MOV AX, @data
  MOV DS, AX
  MOV ES, AX

	LOOP0: 

  PRINTSTR STRING1        

  ;first string

	LEA DX, KBINPUT1
  CALL ACCEPT_STR
	LEA DI, ORIG1  ;initialize receiving/destination address
  LEA SI, KBINPUT1  ;initialize sending/soure address
	CALL STRCOPY
	LEA SI,KBINPUT1
	CALL CHECK_QUIT

  LEA DI, KBINPUT1      
  CALL TO_LOWERCASE

  LEA SI, KBINPUT1      
  CALL GET_LAST_CH
  
  LEA DI, KBINPUT1
  CALL CHECK_PAL  

;----second string--------
  
  PRINTSTR STRING2     

  ;second string
	LEA DX, KBINPUT2
  CALL ACCEPT_STR
	LEA DI, ORIG2  ;initialize receiving/destination address
  LEA SI, KBINPUT2  ;initialize sending/soure address
	CALL STRCOPY
	LEA SI,KBINPUT2
	CALL CHECK_QUIT
  
  LEA DI, KBINPUT2       
  CALL TO_LOWERCASE

  LEA SI, KBINPUT2     
  CALL GET_LAST_CH
  
  LEA DI, KBINPUT2
  CALL CHECK_PAL       

  CMP PALI_CTR, 2
  JE TWO
  CMP PALI_CTR, 1
  JE ONE
  CMP PALI_CTR, 0
  JE ZERO

    TWO:
      PRINTSTR PROMPT_TWO
      JMP __RESET

      ZERO:
      PRINTSTR PROMPT_NO
      JMP __RESET
    
    ONE:
      PRINTSTR PROMPT_ONE
      CMP CTR, 1
      JE FIRST
      JNE SECOND

      FIRST:
        PRINTSTR ORIG1
        JMP __RESET

      SECOND:
        PRINTSTR ORIG2


  ;CALL EXIT
  __RESET:
  CALL RESET_VARIABLES
  JMP LOOP0

;------------------------------------------------------------

RESET_VARIABLES PROC NEAR
 
  MOV CTR, 0
  MOV CHECK_CTR, 0
  MOV PALI_CTR, 0

  MOV CX, 100
  MOV SI, 0000
  MOV DI, 0000

  _B30:
  MOV KBINPUT1[SI], '$'
  MOV KBINPUT2[DI], '$'
  INC SI
  INC DI
  LOOP _B30

  RET
RESET_VARIABLES ENDP

;------------------------------------------------------------

STRCOPY PROC NEAR
  ITERATE:
		MOV AL,[SI]
    MOV [DI], AL
    INC SI
    INC DI
		
		
		CMP AL,'$'
		JE RET0
    JMP ITERATE
RET0:
RET
STRCOPY ENDP

;------------------------------------------------------------

CHECK_QUIT PROC NEAR
	MOV BP,SI
  CLD               
  MOV CX, 2         
  LEA DI, TESTQUIT   

  REPNE CMPSB       
  JE DOUBLE_CHECK1_TERMINATE 


  CLD               
  MOV CX, 2         
  LEA DI, TESTQUIT_CAPS
  MOV SI,BP 

  REPNE CMPSB       
  JE DOUBLE_CHECK1_TERMINATE

  DOUBLE_CHECK1_TERMINATE:

  INC SI
  MOV AL, TESTQUIT2
  MOV AH, [SI]
  CMP AL, AH
  JE CHECK_TERMINATE

  RET
  
CHECK_QUIT ENDP

;------------------------------------------------------------

CHECK_TERMINATE:

  PRINTSTR TERMINATE_STR

  JMP EXIT

;------------------------------------------------------------

TO_LOWERCASE PROC NEAR
  LOOP1:
    MOV AL, [DI]
    CMP AL, '$'
    JE RETURN
    CMP AL, 'A'
    JGE LOWER
    JL CONT

    RETURN:
      RET

    LOWER:
      CMP AL, 'Z'
      JLE TO_LOWER
      JG CONT

    TO_LOWER:
      ADD AL, 32
      MOV [DI], AL

    CONT:
      INC DI
      JMP LOOP1
TO_LOWERCASE ENDP

;------------------------------------------------------------

GET_LAST_CH PROC NEAR
  COUNT:
    MOV AL, [SI]
    CMP AL, '$'
    JE TRIM
    JNE _INCR

    TRIM:
      DEC SI
      DEC SI
      DEC SI
      RET

    _INCR:
      INC SI
      JMP COUNT
GET_LAST_CH ENDP

;------------------------------------------------------------

CHECK_PAL PROC NEAR
  INC CHECK_CTR

    CHECKLOOP:
      MOV AL, SPACE
      CMP [DI], AL
      JE INC_DI

      MOV AL, SPACE
      CMP [SI], AL
      JE DEC_SI

      CMP SI, DI
      JLE _PALI

      MOV AL, [DI]
      MOV AH, [SI]

    CMP AL, AH
    JNE _RET

    INC DI
    DEC SI
    JMP CHECKLOOP
  INC_DI:

    INC DI
    JMP CHECKLOOP
  DEC_SI:

    DEC SI
    JMP CHECKLOOP
  _RET:
    RET

  _PALI:
    MOV BL, CHECK_CTR
    MOV CTR, BL
    INC PALI_CTR
    RET
CHECK_PAL ENDP

;------------------------------------------------------------

ACCEPT_STR PROC NEAR
  MOV AH, 3FH
  MOV BX, 00
  MOV CX, MAXLEN
  ;LEA DX, KBINPUT2
  INT 21H
  RET
ACCEPT_STR ENDP

;------------------------------------------------------------

EXIT:
  MOV AH, 4CH
  INT 21H
MAIN ENDP
END MAIN