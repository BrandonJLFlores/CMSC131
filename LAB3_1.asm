TITLE CONDITIONAL STATEMENTS AND JMP (SIGNED) (.EXE MODEL/FORMAT)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;---------------------------------------------
DATASEG SEGMENT PARA 'Data'
	TEMP_READING DW 0ffefh
	

  ALERTA DW	30
  ALERTB DW 80
 
  ;ALERTC 
  ;ALERTAA DD 50H
  ;ALERTBB DD 1EH
  ;ALERTCC DD FFFFH
  ;ALERTDD 
  
  STRING1 DB "Too hot! Give yourself a shower.$"
  STRING2 DB "You're good. Stay alert.$"
  STRING3 DB "Oh no! You're freezing.$"
  
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
  ;set DS correctly
  MOV AX, DATASEG
  MOV DS, AX

	MOV AX, TEMP_READING
  ;comparison
  CMP AX, ALERTA
  JLE PRINT3
  JG CHECK1
  
  CHECK1:
  CMP AX, ALERTB
  JGE PRINT1
  JL PRINT2
  
  
  
  PRINT1:
  MOV AH, 09
  LEA DX, STRING1
  INT 21H

	JMP EXIT
	
	
	
	PRINT2:
	MOV AH, 09
  LEA DX, STRING2
  INT 21H
  
  JMP EXIT
	
  PRINT3:
  MOV AH, 09
  LEA DX, STRING3
  INT 21H
  
  JMP EXIT
  
  EXIT:
  ;return/terminate/exit
  MOV AH, 4CH
  INT 21H
CODESEG ENDS
END START