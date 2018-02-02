    .model tiny
    .data
level       db      'Please Select Level ( 1-3 ): $',0
s_enter     db      "LET'S GOOOOOOOOOOO !! $",0
s_function  db      'MENU : ENTER | EXIT : ESC $',0
s_power     db      'POWER :: $',0
s_1         db      '::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::$',0
s_2         db      ':                                                                              :$',0
s_3         db      ':                                                                              :$',0
s_4         db      ':     |      |      | ||||||| ||      ||||||| ||||||| ||||   |||| |||||||      :$',0
s_5         db      ':      ||   |||   ||  ||      ||      ||      ||   || || || || || ||           :$',0
s_6         db      ':       || || || ||   |||||   ||      ||      ||   || ||  |||  || |||||        :$',0
s_7         db      ':        |||   |||    ||      ||      ||      ||   || ||   |   || ||           :$',0
s_8         db      ':         |     |     ||||||| ||||||| ||||||| ||||||| ||       || |||||||      :$',0
s_9         db      ':                                                                              :$',0
s_10        db      ':                                                                              :$',0
s_11        db      ':                                                                              :$',0
s_12        db      ':                                Typing Hero !!                                :$',0
s_13        db      ':                                ..............                                :$',0
s_14        db      ':                                                                              :$',0
s_15        db      ':                                                                              :$',0
s_17        db      ':                     MISTAKES are proof when you PRESS KEYS.                  :$',0
s_16        db      ':                     .......................................                  :$',0
s_18        db      ':                                                                              :$',0
s_19        db      ':                                                                              :$',0
s_20        db      ':                                                                              :$',0
s_21        db      ':                                                                              :$',0
s_22        db      ':                                                                              :$',0
s_23        db      ':                           Please any key to continue...                      :$',0
s_24        db      ':                                                                              :$',0
s_25        db      '::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::$',0
s_func_1    db      'This is the Typing Game.$',0
s_func_2    db      'You have full power when game start$',0
s_func_3    db      'You must press correct keyboard when screen show character$',0
s_func_4    db      'If you wrong, your power will lost too !$',0
s_func_5    db      'The game has 3 level of speed$',0
s_func_6    db      'Are You Ready !!?$',0
s_menu      db      'MENU ::$',0
s_start     db      'START GAME (Enter)$',0
s_exit      db      'EXIT (ESC)$',0
row         db      80 dup(-10)
char        db      80 dup(0)
cnt         db      0
chk         db      0
key         db      0
run         db      0
color       db      0
state       db      0
subR        db      -32
power       db      40
chk_key     db      0h

    .code
        org     0100h
main:   
        mov     ah,00h                  ;   set screen 80x25
        mov     al,03h
        int     10h

WelCome:
        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 1
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_1
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 2
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_3
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 3
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_4
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 4
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_5
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 5
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_6
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 6
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_7
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 7
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_8
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 8
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_9
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 9
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_10
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 10
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_11
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 11
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_12
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 12
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_13
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 13
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_14
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 14
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_15
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 15
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_16
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 16
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_17
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 17
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_18
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 18
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_19
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 19
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_20
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 20
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_21
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 21
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_22
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 22
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_23
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 23
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_24
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 24
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string 
        mov     dx, offset s_25
        int     21h

sound_welcome:  
        push ds
        pop  es
        mov  si, offset SomeTune_welcome
           
        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0FFh                 ;
        out  dx,al                   ;

Check_Loop_welcome: 
        mov     ah, 06h                 ;   Press any key to continue
        mov     dl, 0FFh
        int     21h
        cmp     al, 00h
        jz      loopIt_welcome    
        jmp     menu
loopIt_welcome:
        lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDone_welcome       ;
        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt_welcome                 ; pause it
        jmp  short Check_Loop_welcome

LDone_welcome:  
        jmp  sound_welcome                       ; repeat sound

PauseIt_welcome proc 
        mov  ax,0040h
        mov  es,ax

        ; wait for it to change the first time
        mov  al,es:[006Ch]
@a_welcome:     cmp  al,es:[006Ch]
        je   short @a_welcome

        ; wait for it to change again
loop_it_welcome:
        mov  al,es:[006Ch]
@b_welcome:     
        cmp  al,es:[006Ch]
        je   short @b_welcome

        sub  cx,55
        jns  short loop_it_welcome

        ret
PauseIt_welcome endp


SomeTune_welcome        dw  2559,120
dw 2152, 120
dw 2152, 120
dw 1917, 120
dw 2559, 120
dw 2873, 120
dw 2559, 360
dw 2873, 120
dw 2559, 120
dw 2152, 120
dw 1917, 120
dw 2559, 120
dw 2873, 120
dw 2559, 360
dw 2873, 120
dw 2559, 120
dw 2873, 120
dw 3224, 120
dw 3416, 120
dw 4304, 120
dw 3834, 320
dw 4304, 120
dw 3834, 120
dw 3416, 120
dw 3224, 120
dw 2873, 120
dw 2559, 120
dw 3834, 360
dw  00h,00h

menu:
        mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al 

        mov     ax, 0003h               ;   Clear screen to black
        int     10h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 5
        mov     dl, 34
        int     10h

        mov     ah, 09h                 ;   Show string menu
        mov     dx, offset s_menu
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 8
        mov     dl, 30
        int     10h

        mov     ah, 09h                 ;   Show string start
        mov     dx, offset s_start
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 10
        mov     dl, 30
        int     10h

        mov     ah, 09h                 ;   Show string exit
        mov     dx, offset s_exit
        int     21h
sound_menu:  
        push ds
        pop  es
        mov  si, offset SomeTune_menu
           
        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0FFh                 ;
        out  dx,al                   ;

Check_Loop_menu: 
        mov     ah, 06h                 ;   Press any key to continue
        mov     dl, 0FFh
        int     21h

        cmp     al, 00h
        je      loopIt_menu

        jmp     cmp_key_menu

loopIt_menu:
        lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDone_menu             ;
        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt_menu                 ; pause it
        jmp  short Check_Loop_menu

LDone_menu:  
        mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;

        jmp  menu                       ; exit to DOS

PauseIt_menu proc 
        mov  ax,0040h
        mov  es,ax

        ; wait for it to change the first time
        mov  al,es:[006Ch]
@a_menu:     cmp  al,es:[006Ch]
        je   short @a_menu

        ; wait for it to change again
loop_it_menu:
        mov  al,es:[006Ch]
@b_menu:     
        cmp  al,es:[006Ch]
        je   short @b_menu

        sub  cx,55
        jns  short loop_it_menu

        ret
PauseIt_menu endp


SomeTune_menu        dw 4831,320
dw 3619,620
dw 3043,120
dw 3224,320
dw 3619,820
dw 2415,320
dw 2711,1000
dw 3224,1000
dw 3619,620
dw 3043,120
dw 3224,320
dw 3834,720
dw 3416,320
dw 4831,1000
dw 16,0
dw 4831,320
dw 3619,620
dw 3043,120
dw 3224,320
dw 3619,820
dw 2415,320
dw 2031,820
dw 2152,320
dw 2280,820
dw 2873,320
dw 2280,620
dw 2415,120
dw 2559,320
dw 5119,620
dw 3043,420
dw 3619,1000
dw  00h,00h

cmp_key_menu:
        cmp     al,0Dh
        jne     cmp_key_menu_2

        mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al

        jmp     func
cmp_key_menu_2:
        cmp     al,01Bh
        je      toExit

        jmp     Check_Loop_menu

toExit:
        jmp     exit
                                        ;   show function
func:
        mov     state,0

        mov     ax, 0003h               ;   Clear screen to black
        int     10h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 5
        mov     dl, 28
        int     10h

        mov     ah, 09h                 ;   Show string
        mov     dx, offset s_func_1
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 7
        mov     dl, 23
        int     10h

        mov     ah, 09h                 ;   Show string
        mov     dx, offset s_func_2
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 9
        mov     dl, 11
        int     10h

        mov     ah, 09h                 ;   Show string
        mov     dx, offset s_func_3
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 11
        mov     dl, 23
        int     10h

        mov     ah, 09h                 ;   Show string
        mov     dx, offset s_func_4
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 13
        mov     dl, 25
        int     10h

        mov     ah, 09h                 ;   Show string
        mov     dx, offset s_func_5
        int     21h

sound_func:  
        push ds
        pop  es
        mov  si, offset SomeTune_func
           
        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0FFh                 ;
        out  dx,al       
                    ;
selectLevel:
        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 15
        mov     dl, 26
        int     10h

        mov     ah, 09h                 ;   Show string select level
        mov     dx, offset level
        int     21h

Check_LoopIt_func:         
        mov     ah, 06h                 ;   Press any key to continue
        mov     dl, 0FFh
        int     21h

        cmp     al, 00h
        je      loopIt_func

        cmp     state,0
        jne     cmp_select           

        jmp     state_1
        
cmp_select:
        cmp     al,0Dh
        jne     loopIt_func

        jmp     start

loopIt_func:
        lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDone_func             ;
        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt_func                 ; pause it
        jmp  short Check_LoopIt_func

LDone_func:  
        mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;

        jmp  func                      ; exit to DOS

PauseIt_func proc 
        mov  ax,0040h
        mov  es,ax

        ; wait for it to change the first time
        mov  al,es:[006Ch]
@a_func:     cmp  al,es:[006Ch]
        je   short @a_func

        ; wait for it to change again
loop_it_func:
        mov  al,es:[006Ch]
@b_func:      cmp  al,es:[006Ch]
        je   short @b_func

        sub  cx,55
        jns  short loop_it_func

        ret
PauseIt_func endp


SomeTune_func        dw 3043,320
dw 2415,620
dw 3043,320
dw 2415,620
dw 3043,320
dw 2280,620
dw 2415,320
dw 2559,620
dw 3224,320
dw 3043,520
dw 2415,120
dw 2559,320
dw 5119,620
dw 4831,320
dw 2415,1000
dw 3043,320
dw 2415,620
dw 3043,320
dw 2415,620
dw 3043,320
dw 2031,620
dw 2152,320
dw 2280,620
dw 2873,320
dw 2280,420
dw 2415,120
dw 2559,320
dw 5119,620
dw 3043,320
dw 3619,2000
dw  00h,00h

                                        ;   Set state level   
state_1:
        cmp     al,'1'
        jne     state_2

        mov     ah,02h
        mov     dl,al
        int     21h
        mov     state,1
        jmp     selectLevel

state_2:
        cmp     al,'2'
        jne     state_3

        mov     ah,02h
        mov     dl,al
        int     21h
        mov     state,2
        jmp     selectLevel

state_3:
        cmp     al,'3'
        jne     input_start

        mov     ah,02h
        mov     dl,al
        int     21h
        mov     state,3
        jmp     selectLevel

input_start:
        jmp     selectLevel

start:  
        mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al  

        mov     ax, 0003h               ;   Clear screen to black
        int     10h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 5
        mov     dl, 31
        int     10h

        mov     ah, 09h
        mov     dx, offset s_func_6      ;  Show string
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 7
        mov     dl, 32
        int     10h

        mov     ah, 09h
        mov     dx, offset s_enter      ;   Show string
        int     21h
sound_start:  
        push ds
        pop  es
        mov  si, offset SomeTune_start
           
        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0FFh                 ;
        out  dx,al                   ;

LoopIt_start: 
        mov     ah, 06h                 ;   Press any key to continue
        mov     dl, 0FFh
        int     21h

        cmp     al, 00h
        je      loopItt_start  

        cmp     al,0Dh
        jne     loopItt_start

        jmp     init
loopItt_start:
        lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDone_start             ;
        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt_start                 ; pause it
        jmp  short LoopIt_start

LDone_start:  
        mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;

        jmp  sound_start                       ; exit to DOS

PauseIt_start proc 
        mov  ax,0040h
        mov  es,ax

        ; wait for it to change the first time
        mov  al,es:[006Ch]
@a_start:     cmp  al,es:[006Ch]
        je   short @a_start

        ; wait for it to change again
loop_it_start:
        mov  al,es:[006Ch]
@b_start:     
        cmp  al,es:[006Ch]
        je   short @b_start

        sub  cx,55
        jns  short loop_it_start

        ret
PauseIt_start endp


SomeTune_start        dw 2415,50
dw 100,1
dw 2415,50
dw 100,1
dw 2415,50
dw 100,1
dw 2415,50
dw 100,1
dw 2415,50
dw 100,1
dw 2415,50
dw 100,1
dw 2559,120
dw 2415,120
dw 2280,320
dw 2415,120
dw 2559,120
dw 2415,320
dw 3043,320
dw 2711,620
dw 2873,120
dw 2711,320
dw 4560,420
dw 4831,620
dw 3619,120
dw 3043,120
dw 2559,820
dw 2415,50
dw 100,1
dw 2415,50
dw 100,1
dw 2415,50
dw 100,1
dw 2415,50
dw 100,1
dw 2415,50
dw 100,1
dw 2415,50
dw 100,1
dw 2559,120
dw 2415,120
dw 2031,320
dw 2280,120
dw 2415,120
dw 2280,320
dw 3416,320
dw 2280,320
dw 2415,120
dw 2559,120
dw 2415,320
dw 3619,320
dw 3043,820
dw 3834,420
dw  00h,00h

init:
        mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al 

        mov     si,offset char          ;   Pointer of array char
        mov     run,0
        mov     chk,0
        mov     cnt,0

generate_char:
        push    ax             
        mov     ah, 00h
        int     1Ah                     ;   Get system time
        shr     dl, 1                   ;   Delay for a while
        pop     ax
        add     al, dl              
        mov     bl, 30                  ;   Use 30 as divider
        div     bl                      ;   Divide ax with 30

        mov     dl,ah

        mov     bh,25                   ;   regenerate if more than 25
        mov     ah,dl
        cmp     ah,bh
        ja      generate_char

        mov     bh,0                    ;   regenerate if less than 0
        mov     ah,dl
        cmp     ah,bh
        jb      generate_char

initialize_char:
        mov     color,dl

        cmp     cnt,1
        je      initialize_row

        mov     byte ptr [si],dl
        add     byte ptr [si],'A'       ;   Make integer to char 'A' - 'Z'

        inc     chk
        inc     si

        cmp     chk,10                  
        jne     initialize_char

        mov     chk,0
        add     run,10

        cmp     run,80                  ;   Check if set char finish
        jne     generate_char

        mov     si,offset row           ;   Pointer of array row
        mov     run,0
        mov     chk,0    

initialize_row:
        cmp     cnt,1
        je      print

        mov     ah,run                  ;   Set start row
        mov     byte ptr [si],ah
        sub     byte ptr [si],90

        inc     chk
        inc     si

        cmp     chk,10                  ;   Set of 1 char : 10 columns
        jne     initialize_row

        mov     chk,0
        add     run,10

        cmp     run,80                  ;   Check if set row finish
        jne     initialize_row

        mov     ax, 0003h               ;   Clear screen to black
        int     10h

        mov     si,offset char          ;   Pointer of array char
        mov     di,offset row           ;   Pointer of array row
        mov     run,0
        mov     chk_key,0h
        mov     key,'?'

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 0
        mov     dl, 0
        int     10h

        mov     ah, 09h                 ;   Show string power
        mov     dx, offset s_power
        int     21h

        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, 0
        mov     dl, 55
        int     10h

        mov     ah, 09h                 ;   Show string function
        mov     dx, offset s_function
        int     21h

print:
        cmp     cnt,1
        je      Print_RainCode

        mov     color,8                 ;   set start columns for print score
        
        cmp     power,9                 ;   Check score
        ja      print_power

        jmp     menu                    ;   Go to Menu if none score

print_power:
        add     color,1                 ;   increase columns

        cmp     color,39                ;   check columns of score finish 
        ja      KeyPress_check_1

        mov     ah, 02h                 ;   Move Cursor 
        mov     bh, 00h
        mov     dh, 0
        mov     dl, color
        int     10h

        mov     ah,power

        cmp     color,ah                ;   check alive or lost
        jb      print_alive_power

print_lost_power:
        mov     ah, 09h                 ;   Print gray char of lost power
        mov     al, 16
        mov     bh, 00h
        mov     bl, 08h
        mov     cx, 0001h
        int     10h

        jmp     print_power

print_alive_power:
        mov     ah, 09h                 ;   Print red char of alive power
        mov     al, 16
        mov     bh, 00h
        mov     bl, 0Ch
        mov     cx, 0001h
        int     10h

        jmp     print_power

KeyPress_check_1:
        mov     ah,byte ptr [di]

        add     ah,8

        cmp     ah,1        ;   Not Delete char if not show on screen
        jb      Print_RainCode

        mov     ah,key
        cmp     byte ptr [si],ah        ;   Check 'A' - 'Z' of key press
        jne     KeyPress_check_2
       
        mov     byte ptr [si],' '       ;   Set to Blank word

        add     chk_key,01h
        
KeyPress_check_2:
        sub     ah,061h
        add     ah,041h

        cmp     [si],ah                 ;   Check 'a' - 'z' of key press
        jne     Print_RainCode
        
        mov     byte ptr [si],' '       ;   Set to Blank word

        add     chk_key,01h

Print_RainCode:
        cmp     cnt,1
        je      pg

        mov     color,0                 ;   Reset character counter

        cmp     byte ptr [di],0         ;   Not print row 0
        jne     pb

        inc     byte ptr [di]

pb:
        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, [di]
        mov     dl, run
        int     10h

        mov     ah, 09h                 ;   Print black Char
        mov     al, [si]
        mov     bh, 00h
        mov     bl, 00h
        mov     cx, 0001h
        int     10h

        inc     byte ptr [di]

;   Print Green Loop
    
pg:     
        cmp     cnt,1
        je      plg

        cmp     byte ptr [di],0         ;   Not print row 0
        jne     pg_inc

        inc     byte ptr [di]
        inc     color

pg_inc:
        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, [di]
        mov     dl, run
        int     10h

        mov     ah, 09h                 ;   Print Green Char
        mov     al, [si]
        mov     bh, 00h
        mov     bl, 02h
        mov     cx, 0001h
        int     10h


        inc     byte ptr [di]           ;   Inc Row By 1

        inc     color                   ;   Char Count

        cmp     color, 3                ;   Number of Green Char
        jb      pg
        
        mov     color, 0                ;   Reset character counter

;   Print Light Green Loop

plg:    
        cmp     cnt,1
        je      pgw

        cmp     byte ptr [di],0         ;   Not print row 0
        jne     plg_inc

        inc     byte ptr [di]
        inc     color

plg_inc:
        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, [di]
        mov     dl, run
        int     10h

        mov     ah, 09h                 ;   Print Light Green Char
        mov     al, [si]
        mov     bh, 00h
        mov     bl, 0Ah
        mov     cx, 0001h
        int     10h
        
        inc     byte ptr [di]           ;   Inc Row By 1

        inc     color

        cmp     color, 2                ;   Char Count
        jb      plg

        mov     color, 0                ;   Reset character counter

;   Print Grey and White
pgw:
        cmp     cnt,1
        je      cont

        cmp     byte ptr [di],0         ;   Not print row 0
        jne     pgl

        inc     byte ptr [di]

pgl:
        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, [di]
        mov     dl, run
        int     10h

        mov     ah, 09h                 ;   Print Gray Char
        mov     al, [si]
        mov     bh, 00h
        mov     bl, 07h
        mov     cx, 0001h
        int     10h

        inc     byte ptr [di]           ;   Inc Row By 1

        cmp     byte ptr [di],0         ;   Not print row 0
        jne     pl

        inc     byte ptr [di]

pl: 
        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, [di]
        mov     dl, run
        int     10h

        mov     ah, 09h                 ;   Print White Char
        mov     al, [si]
        mov     bh, 00h
        mov     bl, 0Fh
        mov     cx, 0001h
        int     10h
       
        inc     byte ptr [di]           ;   Inc Row By 1

        cmp     byte ptr [di],0         ;   Not print row 0
        jne     ll

        inc     byte ptr [di]

ll:       
        mov     ah, 02h                 ;   Move Cursor
        mov     bh, 00h
        mov     dh, [di]
        mov     dl, run
        int     10h

        mov     al, ' '
        mov     ah, 09h                 ;   Print Black Char
        mov     bh, 00h
        mov     bl, 00h
        mov     cx, 0001h
        int     10h

        sub     byte ptr [di],7

        cmp     byte ptr [di], 0        ;   Check if row negative
        jl      cont

        cmp     byte ptr [di], 30       ;   End of screen check
        jb      cont

        jmp     screen

cont:
        cmp     cnt,1
        je      reset

        inc     run                     ;   increase columns
        inc     di                      ;   next row pointer
        inc     si                      ;   next char pointer

        cmp     run,80                  ;   end of columns check
        je      reset

        jmp     print    

reset:  
        cmp     cnt,1
        je      reset_cont  

        mov     run,0
        mov     key,'?'

        cmp     chk_key,01h             ;   check if no input
        jb      reset_cont

        cmp     chk_key,01h             ;   check correct key press
        ja      reset_cont

        dec     power                   ;   lost 1 power if incorrect key press 

sound_press:  
        push ds
        pop  es
        mov  si, offset SomeTune_press
           
        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0FFh                 ;
        out  dx,al                   ;

LoopIt_press: 
        lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDone_press             ;
        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt_press                 ; pause it
        jmp  short LoopIt_press

LDone_press:  
        mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;

        jmp  reset_cont                        ; exit to DOS

PauseIt_press proc 
        mov  ax,0040h
        mov  es,ax

        ; wait for it to change the first time
        mov  al,es:[006Ch]
@a_press:     cmp  al,es:[006Ch]
        je   short @a_press

        ; wait for it to change again
loop_it_press:
        mov  al,es:[006Ch]
@b_press:     
        cmp  al,es:[006Ch]
        je   short @b_press

        sub  cx,55
        jns  short loop_it_press

        ret
PauseIt_press endp


SomeTune_press        dw 1568, 16
dw  00h,00h

reset_cont:
        cmp     cnt,1
        jne     reset_cont_1

        jmp     delay
reset_cont_1:
        mov     chk_key,0h              ;   reset key check to no input

        mov     ah,06h                  ;   direct console input
        mov     dl,0FFh
        int     21h

        cmp     al,00h                  ;   check character available
        jne     set_key

        jmp     no_input
        
set_key:
        mov     key,al                  ;   set input to key

        mov     chk_key,01h             ;   set key check to input
        
        cmp     key,01Bh                ;   press esc for exit
        jne     cmp_enter     

        jmp     exit
cmp_enter:
        cmp     key,0Dh                 ;   press enter for go to menu
        je      key_enter

sound_wrong:  
        push ds
        pop  es
        mov  si, offset SomeTune_wrong
           
        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0FFh                 ;
        out  dx,al                   ;

LoopIt_wrong: 
        lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDone_wrong             ;
        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt_wrong                 ; pause it
        jmp  short LoopIt_wrong

LDone_wrong:  
        mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;

        jmp  delay                        ; exit to DOS

PauseIt_wrong proc 
        mov  ax,0040h
        mov  es,ax

        ; wait for it to change the first time
        mov  al,es:[006Ch]
@a_wrong:     cmp  al,es:[006Ch]
        je   short @a_wrong

        ; wait for it to change again
loop_it_wrong:
        mov  al,es:[006Ch]
@b_wrong:     
        cmp  al,es:[006Ch]
        je   short @b_wrong

        sub  cx,55
        jns  short loop_it_wrong

        ret
PauseIt_wrong endp


SomeTune_wrong        dw 1175, 4
dw  00h,00h

key_enter:
sound_gotomenu:  
        push ds
        pop  es
        mov  si, offset SomeTune_gotomenu
           
        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0FFh                 ;
        out  dx,al                   ;

LoopIt_gotomenu: 
        lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDone_gotomenu             ;
        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt_gotomenu                 ; pause it
        jmp  short LoopIt_gotomenu

LDone_gotomenu:  
        mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;

        jmp  menu                        ; exit to DOS

PauseIt_gotomenu proc 
        mov  ax,0040h
        mov  es,ax

        ; wait for it to change the first time
        mov  al,es:[006Ch]
@a_gotomenu:     cmp  al,es:[006Ch]
        je   short @a_gotomenu

        ; wait for it to change again
loop_it_gotomenu:
        mov  al,es:[006Ch]
@b_gotomenu:     
        cmp  al,es:[006Ch]
        je   short @b_gotomenu

        sub  cx,55
        jns  short loop_it_gotomenu

        ret
PauseIt_gotomenu endp


SomeTune_gotomenu        dw  1715,120
dw  1917,120
dw  1715,120   
dw  1292,480 
dw  1715,120      
dw  1917,360
dw  1715,640
dw  1917,640
dw  1715,120
dw  1917,120
dw  1715,120   
dw  1292,520 
dw  1715,120      
dw  1917,360
dw  1715,640
dw  00h,00h

screen:
        mov     cnt,1                   ;   mark for jump back
        jmp     generate_char

initialize_char_new:
        mov     cnt,0                   ;   reset mark jump

        mov     dl,color
        mov     byte ptr [si],dl
        add     byte ptr [si],'A'       ;   Make integer to char 'A' - 'Z'

        mov     dl,subR
        mov     byte ptr [di], dl       ;   Set row screen

        sub     subR,23
        cmp     subR,-200
        ja      end_screen

        mov     subR,-32

end_screen:
        jmp     print

no_input:
        mov     chk_key,0h              ;   reset mark to no input

delay:                                  ;   Check state and delay
        cmp     cnt,1
        je      initialize_char_new

state_delay_1:                          
        cmp     state,1
        jne     state_delay_2

        mov     di, 30000
        jmp     loop_delay

state_delay_2:
        cmp     state,2
        jne     state_delay_3

        mov     di, 20000
        jmp     loop_delay

state_delay_3:
        mov     di, 10000

loop_delay:  
        cmp     di, 0
        je      end_loop_delay
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        dec     di
        jmp     loop_delay
        
end_loop_delay:
        mov     di, offset row              ;   Pointer of array row
        mov     si, offset char             ;   Pointer of array char

        jmp     print

exit:   
sound_exit:
        push ds
        pop  es
        mov  si, offset SomeTune_exit
           
        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0B6h                 ;
        out  dx,al                   ;

LoopIt_exit: lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDone_exit             ;
        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt_exit                 ; pause it
        jmp  short LoopIt_exit

LDone_exit:  mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;

        jmp  exit_r                       ; exit to DOS

PauseIt_exit proc ;near uses ax cx es
        mov  ax,0040h
        mov  es,ax

        ; wait for it to change the first time
        mov  al,es:[006Ch]
@a_exit:     cmp  al,es:[006Ch]
        je   short @a_exit

        ; wait for it to change again
loop_it_exit:mov  al,es:[006Ch]
@b_exit:     cmp  al,es:[006Ch]
        je   short @b_exit

        sub  cx,55
        jns  short loop_it_exit

        ret
PauseIt_exit endp


SomeTune_exit        dw  2711,120
dw 3224, 120
dw 3043, 120
dw 2711, 120
dw 3619, 360
dw 4063, 640
dw  00h,00h

exit_r:
        mov     ax, 0003h                   ;   Clear screen to black
        int     10h

        ret                                 ;   exite game
        end     main
