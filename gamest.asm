TITLE LAB6 (SIMPLIFIED .EXE )
.MODEL SMALL
;---------------------------------------------
.DATA
  MESSAGE DB "HELLO WORLD!!!$"
  MESSAGE2 DB "HI UNIVERSE!!!$"
  GAME_START DB 0ah,0dh
  DB "                                                                          ",0ah,0dh
  DB "                           *                                              ",0ah,0dh
  DB "              __ _                 _   _       *        __ _        *     ",0ah,0dh
  DB "     *      / _| |__   ___   ___ | |_(_)_ __   __ _  / _| |_ ___ _ __     ",0ah,0dh
  DB "            \ \| '_ \ / _ \ / _ \| __| | '_ \ / _` | \ \| __/ _` | '__|   ",0ah,0dh                                        
  DB "          *  \ | | | | (_) | (_) | |_| | | | | (_| | _\ | || (_| | |      ",0ah,0dh
  DB "            \__|_| |_|\___/ \___/ \__|_|_| |_|\__, | \__/\__\__,_|_|      ",0ah,0dh
  DB "                                              |___/                       ",0ah,0dh
  DB "                                                                          ",0ah,0dh
  DB "                             >     - - -            *                     ",0ah,0dh
  DB "                                                                          ",0ah,0dh      
  DB "                               BEST SCORE:                                ",0ah,0dh
  DB "    *                          PRESS ENTER                                ",0ah,0dh
  DB "                           *                                              ",0ah,0dh
  DB "                                                                          ",0ah,0dh
  DB "                                                    *                     ",0ah,0dh,"$"
  TEMP        DB    ?
  NEW_INPUT   DB    ?
  ROW DB ?
  COL DB ?
  FLAG DB "F$"
  
  ROWSTAR DB ?
  COLSTAR DB ?
  
  SHOOTER_DEFPOS DB ?
  BULLET_DEFPOS DB ?
  STAR_DEFPOS DB ?
  LIVES DB 3
  
  BULLET_ROW DB ?
  
  INPUT_SHOOTER DB ?
  INPUT_BULLET DB ?

  SCORE DB "SCORE: 5$"
  
  DISP_HTP DB 0ah,0dh
  DB "  ===== P R E S S   U P  A N D  D O W N  K E Y S  T O MOVE THE SHOOTER =====",0AH,0DH
  DB "      ===== P R E S S   S P A C E  B A R  T O S H O O  T =====" ,0f8h, "$"


  MAIN_SCREEN_BORDER DB 0AH,0DH
  DB "  ._________________________________________________________________________.",0AH,0DH
  ;DB "  ", 0B3H,0B0H,0B0H,0B0H,0B0H,0B0H,0B0H,0B0H,0B0H,"                                                              ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  ", 0B3H,"                                                                         ", 0B3H,0AH,0DH
  DB "  .-------------------------------------------------------------------------.",0AH,0DH,"$"


  SHOOTER DB ">$"
  STAR DB "O$"
  BULLET DB "-$"

;---------------------------------------------
.CODE
MAIN PROC FAR
  MOV AX, @data
  MOV DS, AX

  MOV ROW, 03H
  Mov COL, 01H

  MOV COLSTAR, 03H
  MOV BULLET_DEFPOS, 04H

  _RUN:

  ;clear the screen
  CALL CLEAR_SCREEN


  ;set the cursor
  MOV DL, ROW
  MOV DH, COL
  CALL SET_CURSOR

;-------display game title-----------
        LEA   DX, GAME_START
        MOV AH, 09H
        INT 21H
;------------------------------------


  CALL DELAY
  CALL DELAY
  CALL GET_INPUT
  
  CMP NEW_INPUT,01H
  JE EXIT
  CMP NEW_INPUT,1CH
  JE ENTER_GAME
  JMP _RUN
  
  ENTER_GAME:
	CALL HTP_SCREEN

  EXIT:
	  MOV AH, 4CH
	  INT 21H


MAIN ENDP


CLEAR_SCREEN PROC NEAR
  MOV AX, 0600H   ;full screen
  MOV BH, 0EH     ;white background (7), blue foreground (1)
  MOV CX, 0000H   ;upper left row:column (0:0)
  MOV DX, 184FH   ;lower right row:column (24:79)
  INT 10H

  RET
CLEAR_SCREEN ENDP

DELAY PROC NEAR

      MOV BP, 1 
      MOV SI, 3
      
      DELAY2:
        DEC BP
        NOP
        JNZ DELAY2
        DEC SI
        CMP SI, 0
        JNZ DELAY2
        RET

DELAY ENDP


HTP_SCREEN PROC NEAR
		MOV AX, 0600H   ;full screen
        MOV BH, 0CH     ;white background (7), blue foreground (1)
        MOV CX, 0000H   ;upper left row:column (0:0)
        MOV DX, 184FH   ;lower right row:column (24:79)
        INT 10H

        MOV DL, 50
        MOV DH, 10
        CALL SET_CURSOR
		

        LEA DX, DISP_HTP
        MOV AH, 09H
        INT 21H
		
	HTP_LOOP:
		CALL GET_INPUT
		CMP NEW_INPUT, 01H
		JE INIT_GL
		JMP HTP_LOOP
		
	INIT_GL:
		CALL INITIALIZE
		
HTP_SCREEN ENDP

INITIALIZE PROC
	mov ah, 2ch  ; Set function code
	int 21h      ; get time from MS-DOS
	mov al, dl   ; DH=seconds, DL=hundredths of second
	and al, 0fh  ; keep only the 4 last bits of the hundredth of seconds
		
		
    MOV SHOOTER_DEFPOS, 09H
    MOV STAR_DEFPOS, al
    CALL GAME_LOOP
INITIALIZE ENDP

MAIN_SCREEN PROC
	MOV AX, 0600H   ;full screen
    MOV BH, 0CH     ;white background (7), blue foreground (1)
    MOV CX, 0000H   ;upper left row:column (0:0)
    MOV DX, 184FH   ;lower right row:column (24:79)
    INT 10H

	
	MOV DL, 04H
        MOV DH, COL
        CALL SET_CURSOR
		

        LEA DX, SCORE
        MOV AH, 09H
        INT 21H


        MOV DL, 48h
        MOV DH, COL
        CALL SET_CURSOR

        MOV CX, 3

        LIFE_COUNTER:
			MOV AH,6
			MOV DL, 3     ;3 for heart
			INT 21H

			LOOP LIFE_COUNTER

        LEA DX, MAIN_SCREEN_BORDER
        MOV AH, 09H
        INT 21H
		
		RET
MAIN_SCREEN ENDP

RENDER_STAR PROC NEAR
;SET CURSOR FOR STARS
		MOV DL, STAR_DEFPOS
		MOV DH, COLSTAR
		CALL SET_CURSOR
		
		LEA DX, STAR
		MOV AH, 09H
		INT 21H
		RET
RENDER_STAR ENDP

RENDER_SHOOTER PROC NEAR
;SET CURSOR FOR SHOOTER?
        MOV DL, ROW
        MOV DH, SHOOTER_DEFPOS
        CALL SET_CURSOR

        ;PRINT SHOOTER
        LEA DX, SHOOTER
        MOV AH, 09H
        INT 21H
        CALL DELAY
		RET
RENDER_SHOOTER ENDP

RENDER_BULLET PROC NEAR
;SET CURSOR FOR BULLET
        MOV DL, BULLET_DEFPOS
        MOV DH, BULLET_ROW
        CALL SET_CURSOR

        ;PRINT SHOOTER
        LEA DX, BULLET
        MOV AH, 09H
        INT 21H
        CALL DELAY
		RET
RENDER_BULLET ENDP

GAME_LOOP PROC NEAR
        
	CALL MAIN_SCREEN
    CALL RENDER_STAR
	CALL RENDER_SHOOTER
	CALL RENDER_BULLET
		
	CALL MOV_STARS
	CALL GET_INPUT
	CALL CHECK_INPUT
	INC BULLET_DEFPOS
	CALL CHECK_COLLISION
		
    ;CALL CHANGE_DIRECTION
	CALL GAME_LOOP

GAME_LOOP ENDP

CHANGE_DIRECTION PROC NEAR
    CMP NEW_INPUT, 01H
    JNE RIGHT
    JMP ESCAPE
    RIGHT:
        INC ROW
        CMP ROW, 78
        JE  WRAPRIGHT
        JMP GAME_LOOP
    WRAPRIGHT:
        MOV ROW, 1 
        JMP GAME_LOOP
	ESCAPE:
		MOV AH, 4CH
		INT 21H
	
CHANGE_DIRECTION ENDP

CHECK_INPUT PROC NEAR
	JZ  COMP
	CMP NEW_INPUT, 48h
	JE S_UP				;SHOOTER UP
	CMP NEW_INPUT, 50H
	JE S_DOWN			;SHOOTER DOWN
	CMP NEW_INPUT, 39H
	JE SET_FLAG
COMP:	
	MOV BL, "T"
	CMP FLAG, BL
	JE SHOOT			;SHOOT
	
	RET
	
	S_UP:
		DEC SHOOTER_DEFPOS
		CMP SHOOTER_DEFPOS, 5
		JE WS_UP
		RET
	S_DOWN:
		INC SHOOTER_DEFPOS
		CMP SHOOTER_DEFPOS, 23
		JE WS_DOWN
		RET
	WS_DOWN:					;WRAP SHOOTER DOWN
		MOV SHOOTER_DEFPOS, 23
		RET
	WS_UP:					;WRAP SHOOTER DOWN
		MOV SHOOTER_DEFPOS, 5
		RET
	SET_FLAG:
		MOV BL, "T"
		MOV FLAG,BL
	
	INIT_SHOOT:
		MOV BULLET_DEFPOS, 3
		MOV DL, SHOOTER_DEFPOS
		MOV BULLET_ROW, DL
	SHOOT:
		INC BULLET_DEFPOS
		;ITERATE:
		;	CMP BULLET_DEFPOS, 65
		;	JE BACKTOGAME
			
		;	CALL RENDER_BULLET
		;	JMP ITERATE
		RET
		
CHECK_INPUT ENDP

CHECK_COLLISION PROC NEAR
	MOV DL, COLSTAR
	CMP DL, BULLET_ROW
	JE COLLIDED
	RET
COLLIDED:
	MOV DL, STAR_DEFPOS
	CMP DL, BULLET_DEFPOS
	JE COLL
	RET
COLL:
	MOV DL, BULLET_DEFPOS
    MOV DH, BULLET_ROW
    CALL SET_CURSOR
	 
	MOV AL, 'X'
	MOV AH, 02H
	MOV DL, AL
	INT 21H
	
    CALL DELAY
	RET
CHECK_COLLISION ENDP

MOV_STARS PROC NEAR
	
    DOWN:
        INC COLSTAR
        CMP COLSTAR, 23
		JE WDOWN
        RET
	WDOWN:
		mov ah, 2ch  ; Set function code
		int 21h      ; get time from MS-DOS
		mov al, dl   ; DH=seconds, DL=hundredths of second
		and al, 0fh  ; keep only the 4 last bits of the hundredth of seconds
        MOV STAR_DEFPOS, al
		MOV COLSTAR, 03H
		RET
MOV_STARS ENDP

GET_INPUT PROC NEAR 
	  MOV   AH, 01H   ;check for input
      INT   16H

      JZ    BACKTOGAME
	  
      MOV   AH, 00H   
      INT   16H
	  
	  MOV NEW_INPUT, AH
	  
    RETURN:
       RET
	BACKTOGAME:
		RET
GET_INPUT  ENDP 

SET_CURSOR PROC NEAR
	MOV AH, 01H
	MOV CX, 2607H
	INT 10H
	
      MOV AH, 02H
      MOV BH, 00
      INT 10H
      RET

  RET
SET_CURSOR ENDP

END MAIN