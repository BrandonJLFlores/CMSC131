TITLE LAB6 (SIMPLIFIED .EXE )
.MODEL SMALL
;---------------------------------------------
.DATA
input1 	DB 30
		DB ?
		DB 30 DUP (?)
sub1 	DB 30
		DB ?
		DB 30 DUP (?)
message1 db "Enter string:$"
message2 db 10,13,"Enter search:$"
message3 db 10,13,"Not found$"
message4 db 10,13,"Found at location $"
count db ?
NEW_INPUT DB ?
loc db ?
newline db 10,13,"$"
ctr1 db ?   
ctr2 db ? 
  
;---------------------------------------------
.CODE
MAIN PROC FAR
	;SET DS
	MOV AX, @data
	MOV DS, AX
	
	mov loc,0
	mov si, offset input1
	mov di, offset sub1
	mov cl,0
	
	
	
	;firstquestion:
	lea dx, message1
	call print
	mov dx, si
	call askinput
	;lea dx, newline
	;call print	    
	
	;second question
	lea dx, message2
	call print
	mov dx, di
	call askinput
	
	;search
	call search
	


  
	EXIT:
	mov ah, 4ch
	int 21h
main endp

search proc near
	call getsize
	mov si,offset input1
	mov di,offset sub1
	
	compare1:
	mov al,[si]       
	mov bl,[di]       
	cmp al,bl 
	jne compare2       
	inc di      
	dec ctr2       
	jnz compare2       
	lea dx, message4
	call print
	jmp EXIT
	
	compare2:
	inc si          
	dec ctr1          
	mov dl,ctr1          
	cmp dl,0          
	jnz compare1          
	lea dx,message3
	call print
	jmp EXIT
	
	ret
search endp

getsize proc near
	mov bl,0
	mov bh,0
	mov bl,input1+1
	ADD BL,30H
        MOV AH,02H
        MOV DL,BL
        INT 21H
	mov ctr1,bl
	
	mov bl,0
	mov bh,0
	mov bl,sub1+1
	mov ctr2,bl
	;lea dx, ctr2
	;mov ah,10
	;int 21
	ret
getsize endp

print proc near
	mov ah,9
	int 21h
	ret
print endp

askinput proc near
	mov ah, 10
	int 21h
	ret
askinput endp
	
END MAIN