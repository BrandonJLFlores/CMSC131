;Processing String Data (p. 203)
;MOVS - moves/copies one byte (MOVSB) or one word (MOVSW) from one location in memory to another
;LODS - loads from memory a byte (LODSB) into the AL or a word (LODSW) into the AX (X)
;STOS - stores the contents of the AL (STOSB) or AX (STOSW) registers into memory (X)
;CMPS - compares byte (CMPSB) or word (CMPSW) memory locations
;SCAS - compares the contents of the AL (SCASB) or AX (SCASW) with the contents of a memory location (X)

TITLE STRING MOVSW (SIMPLFIED .EXE FORMAT)
.MODEL SMALL
;---------------------------------------------
.STACK 32
;---------------------------------------------
.DATA
  MESSAGE1 DB "HELLO WORLD!!!!$"
  MESSAGE2 DB 16 DUP(' ')
;---------------------------------------------
.CODE
MAIN PROC FAR
  MOV AX, @data
  MOV DS, AX
  MOV ES, AX ;needs to set ES register

  ;copy message 1 to message 2 byte by byte
  CLD               ;clear direction flag (left to right)
  MOV CX, 16        ;initializes CX (counter) to 16 bytes
  LEA DI, MESSAGE2  ;initialize receiving/destination address
  LEA SI, MESSAGE1  ;initialize sending/soure address

  ITERATE:
    MOV AX, [SI]
    MOV [DI], AX
    ADD SI, 1
    ADD DI, 1

    LOOP ITERATE

  ;REP MOVSW         ;copy MESSAGE1 to MESSAGE2 word by word (repeatedly for 16 times)
                    ;alternative, MOVSW
                    ;alternative, manual with loop
                    ;alternative, using operands (for study)
                    ;explore direction (STD)

  ;display message 2
  LEA DX, MESSAGE2
  MOV AH, 09H
  INT 21H

  MOV AH, 4CH
  INT 21H
MAIN ENDP
END MAIN
