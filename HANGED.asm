.model small
    .stack  100h

    .data
            filename    db 255 dup(0)
            text        db 255 dup(0)
            char        db ?
            line        db 255 dup(0)

            filehandle  dw ?

    .code
            newline macro    ;NEW LINE
                             ;
            mov dl, 10       ;
            mov ah, 02h      ;
            int 21h          ;
                             ;
            mov dl, 13       ;
            mov ah, 02h      ;                     ;
            int 21h          ;
            endm             ;NEW LINE
    main:

            mov ax, @data
            mov ds, ax

            lea si, filename
            mov ah, 01h      ;read character

    char_input:

            int 21h

            cmp al, 0dh      ;enter
            je zero_terminator

            mov [si], al
            inc si

            jmp char_input

    zero_terminator:

            mov byte ptr [si], 0

    open_file:

            lea dx, filename
            mov al, 0
            mov ah, 3Dh      ;open file
            int 21h

            mov filehandle, ax

            lea si, text

            newline

    read_line:
            mov ah, 3Fh      ;read file
            mov bx, filehandle
            lea dx, char
            mov cx, 1

            int 21h

            cmp ax, 0       ;EOF
            je EO_file

            mov al, char

            cmp al, 0ah     ; line feed
            je LF

            mov [si], al
            inc si

            jmp read_line

    EO_file:

            lea dx, text    ;DX=offset(address) of text
            mov ah, 40h     ;print
            mov cx, si      ;CX = # characters. Move pointer to last char to it
            sub cx, dx      ;Subtract the offset of text (in DX) from CX
                            ;To get the actual number of chars in the buffer
            mov bx, 1
            int 21h

            mov ah, 4ch
            int 21h

    LF:
            lea dx, text    ;DX=offset(address) of text
            mov ah, 40h     ;print
            mov cx, si      ;CX = # characters. Move pointer to last char to it
            sub cx, dx      ;Subtract the offset of text (in DX) from CX
                            ;To get the actual number of chars in the buffer
            mov bx, 1

            int 21h

            mov si, dx      ;Start from beginning of buffer 
                            ;(DX=beginning of text buffer)
            jmp read_line

     end main