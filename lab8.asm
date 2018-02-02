;Reading from a File (p. 311)

TITLE FILE READ (SIMPLFIED .EXE FORMAT)
.MODEL SMALL
;---------------------------------------------
.STACK 32
;---------------------------------------------
.DATA
  PATHFILENAME  DB 'file.txt', 00H
  PATHFILENAME2  DB 'new.txt', 00H
  FILEHANDLE    DW ?	
  FILEHANDLE2    DW ?

  RECORD_STR    DB 1001 DUP('$')  ;length = original length of record + 1 (for $)
  RECORD_STR2    DB 1001 DUP(' ')  ;length = original length of record + 1 (for $)

  ERROR1_STR    DB 'Error in opening file.$'
  ERROR2_STR    DB 'Error reading from file.$'
  ERROR3_STR    DB 'No record read from file.$'
  ERROR4_STR    DB 'Error writing in file.$'
  ERROR5_STR    DB 'Record not written properly.$'
  CHAR_REF1 DB "A", "$"
  CHAR_REF2 DB "Z", "$"
  CHAR_REF3 DB "a", "$"
  CHAR_REF4 DB "z", "$"
  CHAR_REF5 DB "0", "$"
  CHAR_REF6 DB "9", "$"
  
  count dw ?
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
  MOV CX, 1000            ;record length
  LEA DX, RECORD_STR    ;address of input area
  INT 21H
  JC DISPLAY_ERROR2
  CMP AX, 00            ;zero bytes read?
  JE DISPLAY_ERROR3
  
  call convert
  
  write:
  
  MOV AH, 3CH           ;request create file
  MOV CX, 00            ;normal attribute
  LEA DX, PATHFILENAME2  ;load path and file name
  INT 21H
  JC DISPLAY_ERROR1     ;if there's error in creating file, carry flag = 1, otherwise 0
  MOV FILEHANDLE2, AX

  ;write file
  MOV AH, 40H           ;request write record
  MOV BX, FILEHANDLE2    ;file handle
  MOV CX, count            ;record length
  LEA DX, RECORD_STR2    ;address of output area
  INT 21H
  JC DISPLAY_ERROR4     ;if carry flag = 1, there's error in writing (nothing is written)
  CMP AX, count            ;after writing, set AX to size of chars nga na write
  JNE DISPLAY_ERROR5  
  
  ;close file handle
  MOV AH, 3EH           ;request close file
  MOV BX, FILEHANDLE2    ;file handle
  INT 21H
  
  ;close file handle
  MOV AH, 3EH           ;request close file
  MOV BX, FILEHANDLE    ;file handle
  INT 21H
  
  call print

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

DISPLAY_ERROR4:
  LEA DX, ERROR4_STR
  MOV AH, 09
  INT 21H
  
DISPLAY_ERROR5:
  LEA DX, ERROR5_STR
  MOV AH, 09
  INT 21H
  
EXIT:
  MOV AH, 4CH
  INT 21H
MAIN ENDP

convert proc near
	;cld
	mov cx,ax
	mov count,cx

	lea si,RECORD_STR
	lea di, RECORD_STR2
	
	iterate:
		mov al,[si]
		jmp compare
		decrease:
		mov [di],ax
		inc si
		inc di
	
	dec cx
	cmp cx,0
	jne iterate
	je return
	
	compare:
	CMP AL, CHAR_REF5
	JAE CHECK_NUM
	JB special
	  
	CHECK_NUM:
	CMP AL, CHAR_REF6
	JA CHECK_SMALL
	JBE digit
	  
	CHECK_SMALL:
	CMP AL, CHAR_REF3
	JAE CHECK_SMALL2
	JB CHECK_CAPS
	  
	CHECK_CAPS:
	CMP AL, CHAR_REF1
	JAE CHECK_CAPS2
	JB special
	  
	CHECK_SMALL2:
	CMP AL, CHAR_REF4
	JA special
	JBE psmall
	  
	CHECK_CAPS2:
	CMP AL, CHAR_REF2
	JA special
	JBE pcaps
	
	special: 
	mov al,' '
	jmp decrease
	
	digit:
	jmp decrease
	
	psmall:
	sub al,20h
	jmp decrease
	
	pcaps:
	add al,20h
	jmp decrease
	
return:
jmp write
;return:
;mov al,'$'
;mov [di],ax
ret
convert endp

print proc near
	mov al,'$'
	mov [di],ax
	
	lea dx, RECORD_STR2
	mov ah,9
	int 21h
ret
print endp
	
END MAIN
