DATA SEGMENT
    STR1 DB "Enter string: $"
    STR2 DB "Enter search: $"
    NEWLINE DB 10,13,"$"

    input1 DB 20 
            DB ?
            DB 10 DUP("$")

    sub1 DB 20
            DB ?
            DB 10 DUP("$")
    
    MSGFOUND DB 10,13,"Found at location $"
    MSGNOTFOUND DB 10,13,"Not found$"
	
	csource db ?
	csub db ?
	temp db ?
	temps db ?
	loc db ?
	origs db ?
	
	deci db 10 dup ('$')

DATA ENDS

CODE SEGMENT
        ASSUME DS:DATA,CS:CODE
START:
    MOV AX,DATA
    MOV DS,AX

;GET STRING
        MOV AH,09
        lea DX,str1
        INT 21H

        lea si, input1
        MOV AH,10
        MOV DX,SI
        INT 21H

        MOV AH,09
        LEA DX,NEWLINE
        INT 21H
        
        lea si, input1+1
        mov cl, [si]

		mov csource, cl
		mov origs,cl
		
		 MOV AH,09
        lea DX,str2
        INT 21H

        lea si, sub1
        MOV AH,10
        MOV DX,SI
        INT 21H

        MOV AH,09
        LEA DX,NEWLINE
        INT 21H
		
		lea si, sub1+1
        mov cl, [si]

		mov csub, cl
		mov temp,cl
		
		call search

		notfound:
		lea dx,MSGNOTFOUND
		mov ah,9
		int 21h
		
EXIT:
    MOV AH, 4CH
    INT 21H
	
search proc near
	mov si,offset input1 + 2
	mov di,offset sub1 + 2
	mov sp,di
	
	mainloop:
	
	subloop:
	mov al,[si]
	mov bl,[di]
	cmp al,bl
	je next
	
	cmp csource,0
	je next
	
	inc si
	dec csource
	jmp subloop
	
	next:
	mov bp,si
	mov cl,csource
	mov loc,cl
	mov temps,cl
	
	subloop2:
	mov al,[si]
	mov bl,[di]
	cmp al,bl
	jne next2
	
	cmp csource,0
	je next2
	
	cmp csub,0
	je next2
	inc si
	inc di
	dec csource
	dec csub
	jmp subloop2
	
	next2:
	cmp csub,0
	je found
	cmp csource,0
	je notfound
	
	mov si,bp
	inc si
	mov di,sp
	
	mov cl,temps
	mov csource,cl
	
	mov cl,temp
	mov csub,cl
	
	cmp csource,0
	jne mainloop
	
	ret
search endp

found:
		lea dx, MSGFOUND
		mov ah,9
		int 21h
		
		mov al,loc
		sub origs,al
		add origs,31h
		mov al,origs
		mov dl,al
		mov ah,2
		int 21h
		
		jmp EXIT
	
CODE ENDS



END START