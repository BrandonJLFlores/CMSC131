;Processing String Data (p. 203)
;MOVS - moves/copies one byte (MOVSB) or one word (MOVSW) from one location in memory to another
;LODS - loads from memory a byte (LODSB) into the AL or a word (LODSW) into the AX (X)
;STOS - stores the contents of the AL (STOSB) or AX (STOSW) registers into memory (X)
;CMPS - compares byte (CMPSB) or word (CMPSW) memory locations
;SCAS - compares the contents of the AL (SCASB) or AX (SCASW) with the contents of a memory location (X)

TITLE STRING PALINDROME (SIMPLFIED .EXE FORMAT)
.MODEL SMALL
;---------------------------------------------
.STACK 64
;---------------------------------------------
.DATA

  EQUAL_STR DB 10, 13, "EQUAL!$"
  NOT_EQUAL_STR DB 10, 13, "NOT EQUAL!$"

  TWO_PALISTR DB 'You got 2 palindromes!$', 10, 13
  ONE_PALISTR DB "It's just $", 10, 13
  NO_PALISTR  DB 'Finals is coming!$', 10, 13

  PRINT    DB    10, 13, 'String 1> $'
  PRINT2   DB    'String 2> $'
  
  KBINPUT1  DB   32 DUP('$')
  KBINPUT2  DB    32 DUP('$')

  QUIT1 DB 'q$', '0DH', '$'
  QUIT2 DB 'Q$', '0DH', 'S'

  TESTQUIT DB 71H, '$'
  TESTQUIT_CAPS DB 51H,'$'
  TESTQUIT2 DB 0AH, '$'
  TERMINATE_STR DB 'Program terminated successfully!$'

  MAXLEN DW 30
  SPACE   DB ' $'
  PALI_CTR DB 0,'$'
  CHECK_CTR DB 0, '$'
  CTR DB 0
  TEMPVAL DW 0000
;------------------------------------------------------------


.CODE
MAIN PROC FAR


  MOV AX, @data
  MOV DS, AX
  MOV ES, AX

__LOOP: 

  LEA DX, PRINT
  CALL DISPLAY_STR         

  ;first string

  CALL ACCEPT_STR1    
  CALL CHECK_QUIT1

  LEA DI, KBINPUT1      
  CALL TO_LOWERCASE

  LEA SI, KBINPUT1      
  CALL GET_LAST_CH
  
  LEA DI, KBINPUT1
  CALL CHECK_PAL       

;----second string--------
  
  LEA DX, PRINT2     
  CALL DISPLAY_STR

  ;second string

  CALL ACCEPT_STR2
  CALL CHECK_QUIT2
  
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
      LEA DX, TWO_PALISTR
      CALL DISPLAY_STR
      JMP __RESET

      ZERO:
      LEA DX, NO_PALISTR
      CALL DISPLAY_STR
      JMP __RESET
    
    ONE:
      LEA DX, ONE_PALISTR
      CALL DISPLAY_STR
      CMP CTR, 1
      JE FIRST
      JNE SECOND

      FIRST:
        LEA DX, KBINPUT1
        CALL DISPLAY_STR
        JMP __RESET

      SECOND:
        LEA DX, KBINPUT2
        CALL DISPLAY_STR


  ;CALL EXIT
  __RESET:
  CALL RESET_VARIABLES
  JMP __LOOP

;------------------------------------------------------------

RESET_VARIABLES PROC NEAR
 
  MOV CTR, 0
  MOV CHECK_CTR, 0
  MOV PALI_CTR, 0

  MOV CX, 32
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

CHECK_QUIT1 PROC NEAR
  
;  MOV AH, QUIT1
;  CMP AH, KBINPUT1
;  JE CHECK1_TERMINATE1
;  JNE CHECK2_TERMINATE1

  CLD               ;clear direction flag (left to right)
  MOV CX, 2         ;initializes CX (counter) to 16 bytes
  LEA DI, TESTQUIT  ;initialize receiving address
  LEA SI, KBINPUT1  ;initialize sending address

  REPNE CMPSB        ;compare byte by byte (repeat if equal)
  JE DOUBLE_CHECK1_TERMINATE1     ;alternative, CMPSW


  CLD               ;clear direction flag (left to right)
  MOV CX, 2         ;initializes CX (counter) to 16 bytes
  LEA DI, TESTQUIT_CAPS  ;initialize receiving address
  LEA SI, KBINPUT1  ;initialize sending address

  REPNE CMPSB        ;compare byte by byte (repeat if equal)
  JE DOUBLE_CHECK1_TERMINATE1     ;alternative, CMPSW

  DOUBLE_CHECK1_TERMINATE1:

  INC SI
  MOV AL, TESTQUIT2
  MOV AH, [SI]
  CMP AL, AH
  JE CHECK1_TERMINATE1

  RET
  
CHECK_QUIT1 ENDP

;------------------------------------------------------------

CHECK_QUIT2 PROC NEAR

  ;MOV AH, QUIT1
  ;CMP AH, KBINPUT2
  ;JE CHECK1_TERMINATE2
  ;JNE CHECK2_TERMINATE2
  ;RET


  CLD               ;clear direction flag (left to right)
  MOV CX, 2         ;initializes CX (counter) to 16 bytes
  LEA DI, TESTQUIT  ;initialize receiving address
  LEA SI, KBINPUT2  ;initialize sending address

  REPNE CMPSB        ;compare byte by byte (repeat if equal)
  JE DOUBLE_CHECK2_TERMINATE1     ;alternative, CMPSW


  CLD               ;clear direction flag (left to right)
  MOV CX, 2         ;initializes CX (counter) to 16 bytes
  LEA DI, TESTQUIT_CAPS  ;initialize receiving address
  LEA SI, KBINPUT2  ;initialize sending address

  REPNE CMPSB        ;compare byte by byte (repeat if equal)
  JE DOUBLE_CHECK2_TERMINATE1     ;alternative, CMPSW

  DOUBLE_CHECK2_TERMINATE1:

  INC SI
  MOV AL, TESTQUIT2
  MOV AH, [SI]
  CMP AL, AH
  JE CHECK1_TERMINATE1

  RET
  
CHECK_QUIT2 ENDP
;------------------------------------------------------------

CHECK1_TERMINATE1:

  LEA DX, TERMINATE_STR
  CALL DISPLAY_STR

  JMP EXIT

;------------------------------------------------------------

CHECK1_TERMINATE2:

  LEA DX, TERMINATE_STR
  CALL DISPLAY_STR

  JMP EXIT


;------------------------------------------------------------

CHECK2_TERMINATE1 PROC NEAR

  ;MOV AH, QUIT2
  ;CMP AH, KBINPUT1
  ;JE TERMINATE

  ;RET

  
  CLD               ;clear direction flag (left to right)
  MOV CX, 32        ;initializes CX (counter) to 16 bytes
  LEA DI, QUIT2     ;initialize receiving address
  LEA SI, KBINPUT1  ;initialize sending address
  REPE CMPSB        ;compare byte by byte (repeat if equal)
  JE TERMINATE     ;alternative, CMPSW

  RET

  TERMINATE:
  LEA DX, TERMINATE_STR
  CALL DISPLAY_STR
  JMP EXIT

CHECK2_TERMINATE1 ENDP

;------------------------------------------------------------

CHECK2_TERMINATE2 PROC NEAR

  ;MOV AH, QUIT2
  ;CMP AH, KBINPUT2
  ;JE TERMINATE2

  ;RET

  ;TERMINATE2:
  ;LEA DX, TERMINATE_STR
  ;CALL DISPLAY_STR
  ;JMP EXIT

  CLD               ;clear direction flag (left to right)
  MOV CX, 32        ;initializes CX (counter) to 16 bytes
  LEA DI, QUIT2     ;initialize receiving address
  LEA SI, KBINPUT2  ;initialize sending address
  REPE CMPSB        ;compare byte by byte (repeat if equal)
  JE TERMINATE     ;alternative, CMPSW

  RET

  TERMINATE2:
  LEA DX, TERMINATE_STR
  CALL DISPLAY_STR
  JMP EXIT

CHECK2_TERMINATE2 ENDP

;------------------------------------------------------------

TO_LOWERCASE PROC NEAR
  LOOPER:
    MOV AL, [DI]
    CMP AL, '$'
    JE ULINA
    CMP AL, 'A'
    JGE LOWER
    JL CONT

    ULINA:
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
      JMP LOOPER
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

DISPLAY_STR PROC NEAR
  MOV AH, 09H
  INT 21H
  RET
DISPLAY_STR ENDP

;------------------------------------------------------------

ACCEPT_STR2 PROC NEAR
  MOV AH, 3FH
  MOV BX, 00
  MOV CX, MAXLEN
  LEA DX, KBINPUT2
  INT 21H
  RET
ACCEPT_STR2 ENDP

;------------------------------------------------------------

ACCEPT_STR1 PROC  NEAR
  MOV AH, 3FH
  MOV BX, 00
  MOV CX, MAXLEN
  LEA DX, KBINPUT1
  INT 21H
  RET
ACCEPT_STR1 ENDP

;------------------------------------------------------------


EXIT:
  MOV AH, 4CH
  INT 21H
MAIN ENDP
END MAIN