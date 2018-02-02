;Creating and Writing to a File (p. 306)

TITLE FILE CREATE & WRITE (SIMPLFIED .EXE FORMAT)
.MODEL SMALL
;---------------------------------------------
.STACK 32
;---------------------------------------------
.DATA
  PATHFILENAME  DB 'record.txt', 00H
  FILEHANDLE    DW ?

  RECORD_STR    DB 'This is a sample record to write...'  ;length = 35 characters

  ERROR1_STR    DB 'Error in creating file.$'
  ERROR2_STR    DB 'Error writing in file.$'
  ERROR3_STR    DB 'Record not written properly.$'
;---------------------------------------------
.CODE
MAIN PROC FAR
  MOV AX, @data
  MOV DS, AX

  ;create file
  MOV AH, 3CH           ;request create file
  MOV CX, 00            ;normal attribute
  LEA DX, PATHFILENAME  ;load path and file name
  INT 21H
  JC DISPLAY_ERROR1     ;if there's error in creating file, carry flag = 1, otherwise 0
  MOV FILEHANDLE, AX

  ;write file
  MOV AH, 40H           ;request write record
  MOV BX, FILEHANDLE    ;file handle
  MOV CX, 35            ;record length
  LEA DX, RECORD_STR    ;address of output area
  INT 21H
  JC DISPLAY_ERROR2     ;if carry flag = 1, there's error in writing (nothing is written)
  CMP AX, 35            ;after writing, set AX to size of chars nga na write
  JNE DISPLAY_ERROR3

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
