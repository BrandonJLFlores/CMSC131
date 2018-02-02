TITLE	exam2 (SIMPLFIED .EXE FORMAT)
    		.MODEL SMALL
;---------------------------------------------
.STACK 32
;---------------------------------------------
.DATA

	MESSAGE1		DB		'Enter string: $'
	MESSAGE2		DB		'Enter search: $'
	;MESSAGE3		DB		'Program terminated successfully!$'
	message3 db 10,13,"Not found$"
	message4 db 10,13,"Found at location $"

	STR_INPUT1	DB	31	DUP('$')
	STR_INPUT2	DB	31	DUP('$')

	TEMP1		DB	31	DUP('$')
	TEMP2		DB	31	DUP('$')

	TWO_PALI		DB		'You got 2 palindromes!$'
	ONE_PALI		DB		"It's just $"
	NO_PALI		DB		'Finals is coming!$'

	SPACE		DB	' $'
	FLAG			DB	0

	PALINDROME	DB	0,	'$'
	CNT			DB	0
	
	MAX_LENGTH	DW	30
	count1 dw ?
	count2 dw ?
	tempsi db ?
	tempdi db ?
	tempcount dw ?
	ctr dw 0h
;---------------------------------------------
.CODE
MAIN PROC FAR
	MOV	AX,	@data
	MOV	DS,	AX
	MOV	ES,	AX ;needs to set ES register

					;get first input
	LEA	DX,	MESSAGE1
	CALL	DISPLAY_STR

	MOV	AH,	3FH
	MOV	BX,	00
	MOV	CX,	MAX_LENGTH
	LEA	DX,	STR_INPUT1
	INT	21H
	
	mov cx, ax
	mov count1,cx
					;get second input
	LEA	DX,	MESSAGE2
	CALL	DISPLAY_STR

	MOV	AH,	3FH
	MOV	BX,	00
	MOV	CX,	MAX_LENGTH
	LEA	DX,	STR_INPUT2
	INT	21H 
	
	mov cx,0
	mov cx, ax
	mov count2,cx
	
	call search
	
;---------------------------------------------
	
	START:
	LEA	DX,	STR_INPUT1
	CALL DISPLAY_STR
	
	LEA	DX,	STR_INPUT2
	CALL	DISPLAY_STR
		
;---------------------------------------------

	EXIT:
		MOV	AH,	4CH
		INT	21H
		
 ;---------------------------------------------
   
	DISPLAY_STR	PROC	NEAR
		MOV	AH,	09H
		INT	21H
		RET
	DISPLAY_STR	ENDP
	
;---------------------------------------------	

MAIN ENDP

search proc near
	mov si,offset STR_INPUT1
	mov di,offset STR_INPUT2
	mov sp,di
	
	mov cx, count2
	
	findstart:
	inc ctr
	mov al,[si]       
	mov bl,[di]       
	cmp al,bl
	jne findstart2
	je compare
	
	compare:
	mov ax,count1
	mov tempcount, ax
	mov bp,si
	mov bx,ctr
	cld
	mov di, offset STR_INPUT2
	mov si, offset STR_INPUT1 + bx
	repe cmpsb
	jne reset
	lea dx, message4
	mov ah,9
	int 21
	jmp EXIT
	
	findstart2:
	cmp count1,0
	je notfound
	inc si
	dec count1
	jmp findstart
	
	reset:
	mov di,sp
	mov si,bp
	inc si
	mov count2,cx
	jmp findstart
	mov ax,tempcount
	mov count1,ax
	
	notfound:
	lea dx, message3
	mov ax,9
	int 21
	jmp EXIT
	
	
	
	;checksub:
	
	
	;increase:
	;inc si
	
	ret
search endp

print proc near
	mov ah,9
	int 21h
	ret
print endp

END MAIN