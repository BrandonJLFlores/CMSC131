;Reading from a File (p. 311)

TITLE FILE READ (SIMPLFIED .EXE FORMAT)
.MODEL SMALL
;---------------------------------------------
.STACK 32
;---------------------------------------------
.DATA
  PATHFILENAME  DB 'howto.txt', 00H
  FILEHANDLE    DW ?

  RECORD_STR    DB 1000 DUP('$')  ;length = original length of record + 1 (for $)

  ERROR1_STR    DB 'Error in opening file.$'
  ERROR2_STR    DB 'Error reading from file.$'
  ERROR3_STR    DB 'No record read from file.$'
;---------------------------------------------
.CODE
MAIN PROC FAR
  MOV AX, @data
  MOV DS, AX

  ;open file
  MOV AH, 3DH           ;requst open file
  MOV AL, 00            ;read only; 01 (write only); 10 (read/write)
  LEA DX, PATHFILENAME
  INT 21H
  JC DISPLAY_ERROR1
  MOV FILEHANDLE, AX

  ;read file
  MOV AH, 3FH           ;request read record
  MOV BX, FILEHANDLE    ;file handle
  MOV CX, 1000           ;record length
  LEA DX, RECORD_STR    ;address of input area
  INT 21H
  JC DISPLAY_ERROR2
  CMP AX, 00            ;zero bytes read?
  JE DISPLAY_ERROR3

  ;display record
  LEA DX, RECORD_STR
  MOV AH, 09
  INT 21H

  ;close file handle
  MOV AH, 3EH           ;request close file
  MOV BX, FILEHANDLE    ;file handle
  INT 21H

  JMP EXIT

DISPLAY_ERROR1:
  LEA DX, ERROR1_STR
  MOV AH, 09
  INT 21H

  JMP EXIT

DISPLAY_ERROR2:
  LEA DX, ERROR2_STR
  MOV AH, 09
  INT 21H

  JMP EXIT

DISPLAY_ERROR3:
  LEA DX, ERROR3_STR
  MOV AH, 09
  INT 21H

EXIT:
  MOV AH, 4CH
  INT 21H
MAIN ENDP
END MAIN
