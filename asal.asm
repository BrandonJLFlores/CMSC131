TITLE LAB5 (EXE. MODEL)
.MODEL
;----------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
.STACK 100H
STACKSEG ENDS
;----------------------------------------------
DATASEG SEGMENT PARA 'Data'
   	PROMPT1  DB  '> Enter initial of first name: $'
   	PROMPT2  DB   0AH, 0DH, '> Enter initial of middle name: $'
   	PROMPT3  DB  0AH, 0DH, '> Enter initial of last name: $'
   	
  	MESSAGE1 DB 0AH, 0DH, 'Initial of your first name is '
	STRING1 DB	?
	MESSAGE2 DB ', middle name is '
	STRING2 DB  ?
	MESSAGE3 DB ', and last name is '
	STRING3 DB  ?
	MESSAGE4 DB '!$'
DATASEG ENDS
;-----------------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG

   	MAIN PROC
     	MOV AX, DATASEG              
     	MOV DS, AX
     	MOV ES, AX

     	LEA DX, PROMPT1             
     	MOV AH, 9
     	INT 21H

     	LEA DI, STRING1               

     	CALL INPUT

     	LEA DX, PROMPT2             
     	MOV AH, 9
     	INT 21H

     	LEA DI, STRING2               

     	CALL INPUT   

     	LEA DX, PROMPT3             
     	MOV AH, 9
     	INT 21H

     	LEA DI, STRING3               

     	CALL INPUT   

     	CALL DISPLAY

     	MOV AH, 4CH                 
     	INT 21H
   	MAIN ENDP

;------------------------------------------------

   	INPUT PROC
    	PUSH AX                      
    	PUSH DI                    

    	CLD                          
    	XOR BX, BX              
     
    	MOV AH, 1               
    	INT 21H                      

    	CMP AL, 08H                 
    	JNE @NOT_BACKSPACE                  

    	MOV AH, 2                   
    	MOV DL, 20H                 
    	INT 21H                     

    	MOV DL, 08H                 
    	INT 21H                             
                
    	@NOT_BACKSPACE:             
    	STOSB                   
    	INC BX                             

    	POP DI                        
    	POP AX                       
 
    	RET
  	INPUT ENDP

  ;------------------------------------------------

  	DISPLAY PROC
    	PUSH AX                       
    	PUSH BX                       
    	PUSH CX                       
    	PUSH DX                       
    	PUSH SI                       

    	CLD                          
    	MOV CX, BX                   
    	MOV AH, 2                     

        LEA DX, MESSAGE1       
     	MOV AH, 9
     	INT 21H
           
		POP SI                        
    	POP DX                       
    	POP CX                        
    	POP BX                       
    	POP AX               
 
    	RET
  	DISPLAY ENDP

END MAIN
