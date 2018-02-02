TITLE LAB6 (SIMPLIFIED .EXE )
.MODEL SMALL
;---------------------------------------------
.DATA

  
;---------------------------------------------
.CODE
MAIN PROC FAR
	;SET DS
  MOV AX, @data
  MOV DS, AX

  ;clear the screen  
  MOV ax,0000h
  mov cx, 0014h
  
  iterate:
	add ax,cx
  loop iterate
	
	
	mov ah, 4ch
	int 21h
	main endp
END MAIN