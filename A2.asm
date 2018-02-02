.model  tiny
			
.data
	time 	db 1				;time per frame = time * 0.05 second --> Delay speed
	collumn db 80 DUP (0)		;Duplicate the data on screen resolution
	collumn2 db 80 DUP (65)
	seed	dw ?
	temp 	dw 0		
	timeT 	db 0
	timeLevel db 0
	score1 	db 30h			; Third digit of score default is 0
	score2  db 30h			; Second digit of score default is 0
	life 	db 57
	ctemp 	db 0			; Char temp
	stemp 	dw 0			; Start position temp
	ktemp 	dw 0			; Keyboard input temp
	ui_c 	db 0			; counter for UI collumn
	
	;Message
	_str0 db "Typing HERO!$"
	_str1 db "Choose Level to Start : $"
	_str2 db "1.Easy$"
	_str3 db "2.Medium$"
	_str4 db "3.HardCore$"
	_str5 db "Enjoy...$"
	_str6 db "Score: $"
	_str7 db "Life: $"
	_str8 db "GAMEOVER!!$"
	_str9 db "Your score: $"
	_str10 db "....Please any key to exit$"
	
	.code
	 org     0100h			;Address of VGA	
	 
main:  	  
	CALL	rand_init
	MOV     AH, 00h         ;Set size to 80x25
    MOV     AL, 03h
	INT 	10h
	MOV 	ch, 32       	;hide cursor
	MOV		ah, 1       
	INT 	10h 

@UI:	
	MOV     BH,00h
	MOV 	AH, 2
	MOV 	DL,ui_c
	MOV		DH,19
	INT 	10h
	MOV 	AH, 9
	MOV 	BL, 03h
	MOV 	BH, 00
	MOV   	CX, 1
	MOV     AL, 178
	INT		10h
	ADD		ui_c,1
	CMP		ui_c, 80
	je		menu
	JB 		@UI
	
	
;/////////////////////////////////// Print Start Menu ///////////////////////////////////:

menu:	
	LEA		BP,_str0			;print _str0 string
	MOV 	AH,13h
	MOV		BH,0h
	MOV		BL,06h
	MOV		AL,00h				;Write mode
	MOV 	CX,12				;Number of char in Str.
	MOV 	DL,35				; Column
	MOV		DH,3				; Row
	INT		10h
	
	LEA		BP,_str1			;print _str1 string
	MOV 	AH,13h
	MOV		BH,0h
	MOV		BL,02h
	MOV		AL,00h
	MOV 	CX,24
	MOV 	DL,22
	MOV		DH,5		
	INT		10h
	
	LEA		BP,_str2			;print _str2 string
	MOV 	AH,13h
	MOV		BH,0h
	MOV		BL,0Ah
	MOV		AL,0
	MOV 	CX,6
	MOV 	DL,20
	MOV		DH,7
	INT		10h
	
	LEA		BP,_str3			;print _str3 string
	MOV 	AH,13h
	MOV		BH,0h
	MOV		BL,0Eh
	MOV		AL,0
	MOV 	CX,8
	MOV 	DL,20
	MOV		DH,8
	INT		10h
	
	LEA		BP,_str4			;print _str4 string
	MOV 	AH,13h
	MOV		BH,0h
	MOV		BL,04h
	MOV		AL,0
	MOV 	CX,10
	MOV 	DL,20
	MOV		DH,9
	INT		10h
	
	LEA		BP,_str5			;print _str5 string
	MOV 	AH,13h
	MOV		BH,0h
	MOV		BL,0Dh
	MOV		AL,0
	MOV 	CX,8
	MOV 	DL,40
	MOV		DH,12
	INT		10h
	
;/////////////////////////////////// Check Selected from keyboard ///////////////////////////////////:
@select1:	MOV		AH,0			;get char to AL
	INT		16h						; choose difficulty
	CMP		AL,49					;check 1 for Easy
	JNE		@select2
	MOV 	time,15
	JMP		start
	
@select2:CMP 	AL,50				;check 2 for Medium
	JNE 	@select3
	MOV 	time,10
	JMP 	start
	
@select3:CMP 	AL,51				;check 3 for Hard
	JNE 	@select0
	MOV 	time,5
	JMP 	start
	
@select0:CMP	AL,27				;check ESC
	JNE		@select1
	JMP 	terminate

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\Random function\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\:
rand_init:						; change seed each each frame
	MOV	ah,0					;  Get system time     
	int	1ah						; CX:DX now hold number of clock ticks since midnight      
	PUSH	dx	
	POP	seed					;Move seed to dx
	RET		

rand_col:						; random algorithm by using seed from rand_init
	MOV  	ax, seed
	ADD		seed,23
	XOR  	dx, dx
	MOV  	cx, 60
	DIV  	cx       			;dx contains the remainder of the division from 0 to 59
	MOV		BX,DX
	ADD 	BX, 15				; Shift Screen Position
	RET							;result random number at AL
	
rand_type:						;Random type to display
	MOV  	AX, seed	
	XOR  	DX, DX	
	MOV  	CX, 3
	DIV  	CX      
	RET		
	
rand_char:						;Select type form rand_type function
	CALL 	rand_type
	CMP 	DL,0
	JE 		rand_num
	CMP 	DL,1
	JE 		rand_upper
	CMP 	DL,2
	JE 		rand_lower
	
rand_num:						;Random number
	MOV  	AX, seed	
	ADD		seed,1
	XOR  	DX, DX		
	MOV  	CX, 10
	DIV  	CX 
	ADD 	DL, 48 				; DL contain rand num 0 - 9
	MOV 	AL,DL
	RET
	
rand_upper:						;Random Capital Charaecters
	MOV  	AX, seed	
	ADD		seed,1
	XOR  	DX, DX		
	MOV  	CX, 26
	DIV  	CX       			; DX contains the remainder of the division from 0 to 93
	ADD 	DL, 65 				; DL contain rand char A - Z
	MOV 	AL,DL
	RET
	
rand_lower:						;Random Lower Charaecters
	MOV  	AX, seed	
	ADD		seed,1
	XOR  	DX, DX		
	MOV  	CX, 26 
	DIV  	CX       			; DX contains the remainder of the division from 0 to 93
	ADD 	DL, 97 				; DL contain rand char a - z
	MOV 	AL,DL	
	RET
; END of Random Functions
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\	Screen Setting\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\:

ClearS:							; Clear Screen
	MOV 	AH,2
	MOV 	BH,0
	MOV 	DH,ctemp
	MOV 	DL,0
	INT 	10h
	MOV     AH,9
	MOV     BH,0
	MOV 	AL," "
	MOV 	BL,00
	MOV     CX,80
	INT 	10h
	INC 	ctemp
	CMP 	ctemp,80
	JNE 	ClearS	
	mov 	ctemp,0
	RET

setpos:								;Set Position
	MOV	bx,temp
	MOV	dx,temp
	MOV	dh, collumn[bx]
	DEC	collumn[bx]
	MOV	bh,0
	MOV	ah,02h
	INT	10h							; Set cursor
	RET	
	
	
	
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\	Timer \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\:
timer:								;Get time from system
	MOV 	AH, 2Ch		   
	INT		21h						; delay a time estimate 5* time milli second			
	MOV		timeT,DL 				;set the game speed by level
	MOV		AH,time
	MOV 	timeLevel,ah
	CALL 	print_score
	CALL 	print_life
	
	
timer2:								; Modified time speed for level

	CALL 	CheckKey
	MOV 	AH,2Ch
	INT		21h
	CMP		DL,timeT
	JE		timer2
	DEC		timeLevel
	MOV		timeT,DL
	CMP		timeLevel,0
	JNE		timer2
	RET
	
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\	Print Function \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\:	
printc: 							;Print Charaecters one by one
	MOV     ah, 09h
	MOV     bh, 00h
	MOV     cx, 1
	INT 	10h
	RET

printword:
	CALL	setpos	
	MOV 	bx,temp
	MOV 	al,collumn2[bx]
	MOV     bl, 0ah					; white color
	CALL	printc
	CALL	setpos	
	MOV	al,' '						; del last char
	MOV     bl, 00h
	CALL	printc
	MOV	bx,temp
	ADD	collumn[bx],3
	CMP	collumn[bx],26
	JNE	printword2
	CALL decLife
	MOV	collumn[bx],0
	
printword2:
	RET
	
print_score:
	MOV     BH,00
	MOV 	AH, 2
	MOV 	DL,11
	MOV		DH,18
	INT 	10h
	MOV 	AH, 9
	MOV 	BL, 06h
	MOV 	BH, 00
	MOV   	CX, 1
	MOV     AL, score1
	INT 	10h
	MOV     BH,00
	MOV 	AH, 2
	MOV 	DL,10
	MOV		DH,18
	INT 	10h
	MOV 	AH, 9
	MOV 	BL, 06h
	MOV 	BH, 00
	MOV   	CX, 1
	MOV     AL, score2
	INT 	10h

	;Check 000-009
	CMP 	score1, 39h
	JNE		@out
	je		@Plus10
@out:
	RET	
	
@Plus10:
	MOV 	score1, 30h
	ADD 	score2, 1
	RET	



	
print_life:
	MOV     BH,00
	MOV 	AH, 2
	MOV 	DL,10
	MOV		DH,19
	INT 	10h
	MOV 	AH, 9
	MOV 	BL, 02h
	MOV 	BH, 00
	MOV   	CX, 1
	MOV     AL, life
	INT 	10h
	RET
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\:	
	
decLife:
	DEC 	life
	CMP 	life,48			; 48 is 0 ASCII code
	JNE 	decLife2
	JMP 	game_over
decLife2:
 	RET
	
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\:	
startcol:						;start snake at random row
	CALL	rand_col
	CMP		collumn[bx],0		; row
	JNE		startcol
	INC		collumn[bx]
	MOV 	stemp,bx
	CALL 	rand_char
	MOV 	bx,stemp
	MOV 	collumn2[bx],dl
@C:	RET

@A:	INC	bx

checkAndPrint:					;check each line to move forward
	CMP	bx,80
	JE	@B
	CMP	collumn[bx],0
	JE	@A
	MOV	temp,bx
	CALL	printword
	MOV	bx,temp
	JMP	@A
@B:	RET
	
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\Input function\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\:
CheckKey:						
	MOV		AH,1				
	INT 	16h					; Using Intrrupt 16h to get input from keyboard
	JNZ 	Key_Checker
	RET
	
Key_Checker:					; Check when have key input
	MOV 	AH,0
	INT 	16h
	CMP 	AL,27 				
	JNE 	@Ck
	JMP		terminate
@Ck:
	MOV 	ktemp,80				
@ck4:
	DEC 	ktemp
	CMP 	ktemp,-1
	JE 		outa
	MOV 	bx,ktemp
	CMP 	collumn2[bx],AL
	JNE 	@ck4
	DEC 	collumn[bx]
 	MOV 	AH,02
 	MOV 	dx,ktemp
 	mov 	dh, collumn[bx]
 	MOV 	BH,00
 	INT 10h
	MOV 	AL," "
	MOV 	BH,0
	MOV 	CX,1
	MOV 	BL,00h
	MOV 	AH,9
	INT 	10h
	MOV 	bx,ktemp
	MOV 	collumn[bx],0
	MOV 	collumn2[bx],0
	INC 	score1
outa:	RET
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\	Game Start Here!!	\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\:
start:
	CALL 	ClearS
	LEA		BP,_str6			;print your score
	MOV 	AH,13h
	MOV		BH,0h
	MOV		BL,06h
	MOV		AL,00h
	MOV 	CX,7
	MOV 	DL,2
	MOV		DH,18		
	INT		10h	

	LEA		BP,_str7			;print your life
	MOV 	AH,13h
	MOV		BH,0h
	MOV		BL,09h
	MOV		AL,00h
	MOV 	CX,6
	MOV 	DL,2
	MOV		DH,19		
	INT		10h
	
game_start:						;Loop the game
	CALL	startcol
	XOR		bx,bx
	CALL	checkAndPrint
	CALL 	timer				;delay
	JMP		game_start			;looping

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\	Game Over \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\:

game_over:

	CALL 	ClearS
	LEA		BP,_str8			; GAMEOVER!!		
	MOV 	AH,13h
	MOV		BH,0h
	MOV		BL,04h
	MOV		AL,00h				;Write mode
	MOV 	CX,10				;Number of char in Str.
	MOV 	DL,35				; Column
	MOV		DH,6				; Row
	INT		10h
	
	LEA		BP,_str9			;Your Score
	MOV 	AH,13h
	MOV		BH,0h
	MOV		BL,0Fh
	MOV		AL,00h
	MOV 	CX,11
	MOV 	DL,22
	MOV		DH,9		
	INT		10h
	
	;Print Score
	MOV     BH,00
	MOV 	AH, 2
	MOV 	DL, 35
	MOV		DH, 9
	INT 	10h
	MOV 	AH, 9
	MOV 	BL, 0Fh
	MOV 	BH, 00
	MOV   	CX, 1
	MOV     AL, score2
	INT 	10h
	MOV     BH,00
	MOV 	AH, 2
	MOV 	DL, 36
	MOV		DH, 9
	INT 	10h
	MOV 	AH, 9
	MOV 	BL, 0Fh
	MOV 	BH, 00
	MOV   	CX, 1
	MOV     AL, score1
	INT 	10h
	
	LEA		BP,_str10			
	MOV 	AH,13h
	MOV		BH,0h
	MOV		BL,06h
	MOV		AL,0
	MOV 	CX,26
	MOV 	DL,20
	MOV		DH,12
	INT		10h

	mov     ah, 00h         
    int     16h
    jmp     terminate


;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\	Exit Function \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\:
terminate:
	CALL Clears
	MOV	ah, 4Ch
	MOV	al, 00
	INT	21h
        RET
        END     main