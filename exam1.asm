TITLE LAB6 (SIMPLIFIED .EXE )
.MODEL SMALL
;---------------------------------------------
.DATA
input1 db 3 dup (' ')
message1 db "  Enter N:$"
count db ?
NEW_INPUT DB ?
  
;---------------------------------------------
.CODE
MAIN PROC FAR
	;SET DS
  MOV AX, @data
  MOV DS, AX

  men:
	mov count,0
  
	CALL GET_KEY
	CMP NEW_INPUT, 01H
	JE EXIT
	
	lea dx, message1
	mov ah,9
	int 21h
  
	lea dx, input1
	mov ah, 10
	int 21h
	
	call convert
	call newline
  
  mainloop:
  
	mov ah,2
	mov dl,36
	int 21h
  
	cmp count, 4
	je space
  
	cmp count,9
	je next
  
  
	inc count
	here:
	dec cx
  
	cmp cx, 0
	jg mainloop
  
  
	CALL GET_KEY
	CMP NEW_INPUT, 01H
	JE EXIT
  
	call newline
  
  jmp men
	

	EXIT:
	mov ah, 4ch
	int 21h
main endp

	
	
newline proc near
	mov ah,2
	mov dl,10
	int 21h
  
	mov ah,2
	mov dl,13
	int 21h
	
	ret
newline endp
	
space:
	inc count
	mov ah,2
	mov dl,' '
	int 21h
	jmp here
  
next :  
  call newline
  mov count,0  
  jmp here
	
	
GET_KEY PROC NEAR	
	MOV		AH, 01H		;check for input
	INT		16H

	JZ		__LEAVETHIS

	MOV		AH, 00H		;get input	MOV AH, 10H; INT 16H
	INT		16H

	MOV		NEW_INPUT, AH

	__LEAVETHIS:
			RET
GET_KEY 	ENDP

display proc near
	mov ah,9
	int 21h
	
	ret
	display endp
	
convert proc near
;si point to least
	mov si, offset input1 + 1
	mov cl,[si]
	mov ch,0
	add si,cx
;convert string
	mov bx,0
	mov bp, 1

	tonum:
	;convert char
		mov  al, [ si ] 
	  sub  al, 48 
	  mov  ah, 0 
	  mul  bp 
	  add  bx,ax 
	;increase 10
	  mov  ax, bp
	  mov  bp, 10
	  mul  bp
	  mov  bp, ax
	;check
	 dec  si
	loop tonum
	
	mov cx,bx
	ret
	convert endp
	
	
END MAIN