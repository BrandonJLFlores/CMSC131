;Processing String Data (p. 203)
;MOVS - moves/copies one byte (MOVSB) or one word (MOVSW) from one location in memory to another
;LODS - loads from memory a byte (LODSB) into the AL or a word (LODSW) into the AX (X)
;STOS - stores the contents of the AL (STOSB) or AX (STOSW) registers into memory (X)
;CMPS - compares byte (CMPSB) or word (CMPSW) memory locations
;SCAS - compares the contents of the AL (SCASB) or AX (SCASW) with the contents of a memory location (X)

TITLE STRING CMPS (SIMPLFIED .EXE FORMAT)
.MODEL SMALL
;---------------------------------------------
.STACK 32
;---------------------------------------------
.DATA
  MESSAGE1 DB "HELLO WORLD!!!!$"
  MESSAGE2 DB "HELLO WORLD!!!!$"
  MESSAGE3 DB "HI WORLD!!!!$"

  EQUAL_STR DB "EQUAL!$"
  NOT_EQUAL_STR DB "NOT EQUAL!$"
;---------------------------------------------
.CODE
MAIN PROC FAR
  MOV AX, @data
  MOV DS, AX
  MOV ES, AX ;needs to set ES register

  ;compare message 1 to message 2 byte by byte
  CLD               ;clear direction flag (left to right)
  MOV CX, 16        ;initializes CX (counter) to 16 bytes
  LEA DI, MESSAGE2  ;initialize receiving address
  LEA SI, MESSAGE1  ;initialize sending address

  ITERATE:

    MOV AL, [SI]
    MOV AH, [DI]
    CMP AL, AH
    JNE NOT_EQUAL

    INC SI
    INC DI

    LOOP ITERATE

  ;REPE CMPSB        ;compare byte by byte (repeat if equal)
  ;JNE NOT_EQUAL     ;alternative, CMPSW
                    ;alternative, manual with loop
                    ;alternative, using operands (for study)
                    ;explore direction (STD)
                    ;explore JE

  ;display equal
  LEA DX, EQUAL_STR
  MOV AH, 09H
  INT 21H

  JMP EXIT

  NOT_EQUAL:
  ;display not equal
  LEA DX, NOT_EQUAL_STR
  MOV AH, 09H
  INT 21H

EXIT:
  MOV AH, 4CH
  INT 21H
MAIN ENDP
END MAIN
