[org 0x0100]


jmp start

		speed: dw 8
		newbrick: dw 41090
		dbrab:dw 59340
		disups:dw 57105
		dbbrick1: dw 62850
		dbbrick2:dw 51970;34 spaces between
		dbbrick3:dw 41090
		carrot: dw  53900
		carrotstore: dw 53900
		oldisr: dd 0 ; space for saving oldisr
		oldisr2: dd 0 ; space for saving oldisr
		movb3c: dw 8
		movb2c: dw 24
		movb1c: dw 8
		c1: db 0x08
		c2: db 0x0C
		c3: db 0x2A
		endkey:dw 0
		minutes: dw 0
		time: db 0
		score: db 0
		seconds: dw 0
		blue: dw 0
		random: db 0
		carrotch: dw 0
		gamestart: dw 0
		gamepause: dw 0
		string :db 'JUMPSUPS'
		string1 :db 'Press UP key to jump'
		string2:db 'Mahad Farhan-22l6589'
		string3 :db 'miss have mercy '
		string4 :db 'collect SUN for points'
		string5: db 'press enter to start'
		string6: db 'GAME OVER'
		string7: db 'SCORE:'
		string8: db  '  PAUSE '
		string9: db  'Y to resumme'
		string10: db 'N to end'
delay:      push cx
			mov cx, 0xFFFF
loopd1:		loop loopd1
			mov cx, 0xFFFF
loopd2:		loop loopd2
			pop cx
			ret


clrscr:		
		
		push bp
		push ax
		push BX
		push cx
		push es
		push di
		
		;only for third section
		mov ax,0
		MOV AL,0x35	; AL gets the color value
		MOV BX,0xA000 	;
		MOV ES,BX 		; ES set to start of VGA
		MOV CX,32000 	; CX set to number of pixels
		MOV DI,33280	; DI set to pixel offset 0
		REP STOSB 		;	 While CX <> 0 Do
				; Memory[ES:DI] := AL		; DI := DI + 1; CX := CX - 1 
		pop di
		pop es
		pop cx
		pop BX
		pop ax 
		pop bp 
		ret
clrsr:		
		
		push bp
		push ax
		push BX
		push cx
		push es
		push di
		
		
		mov ax,0
		MOV AL,0x35	; AL gets the color value
		MOV BX,0xA000 	;
		MOV ES,BX 		; ES set to start of VGA
		MOV CX,64000 	; CX set to number of pixels
		MOV DI,0	; DI set to pixel offset 0
		REP STOSB 		;	 While CX <> 0 Do
				; Memory[ES:DI] := AL		; DI := DI + 1; CX := CX - 1 
		pop di
		pop es
		pop cx
		pop BX
		pop ax 
		pop bp 
		ret
	blank:		
		
		push bp
		push ax
		push BX
		push cx
		push es
		push di
		
		
		mov ax,0
		MOV AL,0x00	; AL gets the color value
		MOV BX,0xA000 	;
		MOV ES,BX 		; ES set to start of VGA
		MOV CX,64000 	; CX set to number of pixels
		MOV DI,0	; DI set to pixel offset 0
		REP STOSB 		;	 While CX <> 0 Do
				; Memory[ES:DI] := AL		; DI := DI + 1; CX := CX - 1 
		pop di
		pop es
		pop cx
		pop BX
		pop ax 
		pop bp 
		ret
	
	
	sky:
		
		push bp
		push ax
		push cx
		push ES
		push DI
		
		mov ax,0xA000
		mov es,ax
		mov di,0
		mov cx,320*66
	loop1:
		mov word [es:di],0x34
		add di,1
		loop loop1
		
		pop di
		pop es
		pop cx
		pop ax
		pop bp
		ret 





			
 caldi:

			push bp
			push dx
            mov bp,sp
         	mov ax,320				; load al with columns per row
			mul word [bp+6]		    ; 80 x r
			add ax, [bp+8]			; word number (80xr) + c
			mov di, ax				; point di to required location
			pop dx
			pop bp
			ret 4


mountain:


		push bp
		mov bp,sp
		push ax
		push bx
		push cx
		push dx
		push si
		push di
		
		push word [bp+6];row num
		push word [bp+4];col num
		call caldi
		mov ax,0xA000
		mov es,ax
		mov cx,69
		mov si,0
		print :
		mov dx,cx
		add di,1
		line:
			mov byte [es:di],0x06
			add di,1	
			sub dx,1
			jnz line
			    mov  bx,cx
				sub di,bx
				sub di,320
				sub cx,2
			cmp cx,0
			jg print 	 
		end:

	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp 
	ret 4



crossroad:

 
 
		push bp
		mov bp,sp
		push 0
		push word [bp+4]
		call caldi
		mov cx,320
		mov ax,0
		loop6:
		mov byte [es:di],0x00
		add di,1
		mov byte [es:di],0x00
		add di,1
		mov byte [es:di],0x0E
		add di,1
		mov byte [es:di],0x0E
		add di,1
		loop loop6

		

		
		pop bp		
		ret 2


	road:
		push bp
		push dx
		mov bp,sp
		
		push 66
		call crossroad
		push 100
		call crossroad 	
		push 0
		push 85
		call caldi
		mov dx,13
		loopx:
		add di,6
		mov cx,18
		mov al,0x0F
		rep stosb
		sub dx,1
		jnz loopx
		push 0
		push 100
		call caldi

		pop dx
		pop bp
		ret  

flash:
		
		push bp
		mov bp,sp
		pusha
		mov ax,0xA000
		mov es,ax 
		mov di,[bp+4]
		mov ax,0

		;line 8
		mov al,0x28
		mov cx,7
		rep stosb
		mov byte [es:di],0x0F
		add di,1
		mov al,0x28
		mov cx,3
		rep stosb
		mov byte [es:di],0x2A
		add di,1
		mov byte [es:di],0x28
		add di,1
		mov byte[es:di],0x07
		add di,1
		mov al,0x28
		mov cx,3
		rep stosb
		mov byte [es:di],0x07
		add di,1
		sub di,18
		
		
		;line 7
		sub di,320
		mov al,0x28 ;red 
		mov cx,7  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x0F ;white
		add di,1    ;white
		mov al,0x28  ;red 
		mov cx,3     ;red
		rep stosb    ;red
		mov byte [es:di],0x2A  ;orange
		add di,1    ;orange
		mov byte [es:di],0x0E   ;yellow
		add di,1		;yelllow
		mov byte[es:di],0x28
		add di,1
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov al,0x28
		mov cx,3
		rep stosb
		sub di,18
			
		
		;line 6
		sub di,320
		mov al,0x28 ;red 
		mov cx,11  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x2A  ;orange
		add di,1    ;orange
		mov byte [es:di],0x2A  ;orange
		add di,1    ;orange
		mov byte [es:di],0x28 ;red
		add di,1    ;red
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov al,0x28 ;red 
		mov cx,3  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x0E   ;yellow
		add di,1		;yelllow
		mov al,0x28 ;red 
		mov cx,2  ;red loop
		rep stosb  ;red loop
		sub di ,21
		
		;line 5
		sub di,320
		mov al,0x28 ;red 
		mov cx,11  ;red loop
		rep stosb  ;red loop
		mov al,0x02A ;orange 
		mov cx,3  ;orange
		rep stosb  ;orange
		add di,2
		mov al,0x28 ;red 
		mov cx,2  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x0E   ;yellow
		add di,1
		mov al,0x28 ;red 
		mov cx,2  ;red loop
		rep stosb  ;red loop
		sub di,21
		
		
		;line 4
		sub di,320
		add di,1
		mov al,0x28 ;red 
		mov cx,10  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x0E   ;yellow
		add di,1
		mov al,0x02A ;orange 
		mov cx,2  ;orange
		rep stosb  ;orange
		sub di,14
		
		
		;line 3
		sub di,320
		add di,1
		mov al,0x28 ;red 
		mov cx,12  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x2A  ;orange
		add di,1    ;orange
		sub di,14
		
		;line 2
		sub di,320
		add di,2
		mov al,0x28 ;red 
		mov cx,11  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x2A  ;orange
		add di,1    ;orange
		sub di,14
		
		
		;line 1
		sub di,320
		add di,3
		mov al,0x28 ;red 
		mov cx,9  ;red loop
		rep stosb  ;red loop
		add di,1
		mov byte [es:di],0x2A  ;orange
		add di,1    ;orange
		sub di,14
		
		;line 0
		sub di,320
		add di,5
		mov al,0x28 ;red 
		mov cx,6  ;red loop
		rep stosb  ;red loop
		sub di,11
	
		;reset 
		
		mov di,[bp+4]
		
		;line 9
		add di,320
		add di,1
		mov al,0x28 ;red 
		mov cx,12  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov al,0x28 ;red 
		mov cx,2  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov al,0x28 ;red 
		mov cx,3  ;red loop
		rep stosb  ;red loop
		sub di,20
		
		;line 10
		
		add di,320
		add di,2
		mov byte[es:di],0x28 ;red
		add di,1 ;red
		mov al,0x0F ;white 
		mov cx,2  ;white
		rep stosb  ;white
		mov al,0x28 ;red 
		mov cx,4  ;red loop
		rep stosb  ;red loop
		mov al,0x59 ;skin
		mov cx,2  ;skin
		rep stosb  ;skin
		mov byte[es:di],0x28 ;red
		add di,1 ;red
		mov byte[es:di],0x28 ;red
		add di,1 ;red
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov byte[es:di],0x28 ;red
		add di,1 ;red
		mov byte[es:di],0x28 ;red
		add di,1 ;red
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov al,0x28 ;red 
		mov cx,4  ;red loop
		rep stosb  ;red loop
		sub di,21
	
		;line11
		add di,320
		add di,3
		mov al,0x28 ;red 
		mov cx,4  ;red loop
		rep stosb  ;red loop
		mov al,0x59 ;skin
		mov cx,5  ;skin
		rep stosb  ;skin
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov byte[es:di],0x28 ;red
		add di,1 ;red
		mov byte[es:di],0x28 ;red
		add di,1 ;red
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov al,0x28 ;red 
		mov cx,6  ;red loop
		rep stosb  ;red loop
		sub di,22
		
		;line 12
		add di,320
		add di,3
		mov al,0x59 ;skin
		mov cx,9  ;skin
		rep stosb  ;skin
		mov al,0x28 ;red 
		mov cx,4  ;red loop
		rep stosb  ;red loop
		mov al,0x07 ;grey
		mov cx,3  ;grey
		rep stosb  ;grey
		mov al,0x28 ;red 
		mov cx,4  ;red loop
		rep stosb  ;red loop
		sub di,23
		
		;line 13
		add di,320
		add di,3
		mov al,0x59 ;skin
		mov cx,6  ;skin
		rep stosb  ;skin
		mov al,0x28 ;red 
		mov cx,2  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov byte[es:di],0x28 ;red
		add di,1 ;red
		mov byte[es:di],0x0E ;yellow
		add di,1 ;yellow
		mov byte[es:di],0x0E ;yellow
		add di,1 ;yellow
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov al,0x28 ;red 
		mov cx,7  ;red loop
		rep stosb  ;red loop
		sub di,23
		
		
		;line 14
		add di,320
		add di,4
		mov al,0x59 ;skin
		mov cx,4  ;skin
		rep stosb  ;skin
		mov al,0x28 ;red 
		mov cx,1  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov byte[es:di],0x28 ;red
		add di,1 ;red
		mov byte[es:di],0x0E ;yellow
		add di,1 ;yellow
		mov byte[es:di],0x28 ;red
		add di,1 ;red
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov al,0x28 ;red 
		mov cx,7  ;red loop
		rep stosb  ;red loop
		sub di,22
		
		
		;line 15
		add di,320
		add di,7
		mov al,0x28 ;red 
		mov cx,3  ;red loop
		rep stosb  ;red loop
		mov byte[es:di],0x0E ;yellow
		add di,1 ;yellow
		mov al,0x28 ;red 
		mov cx,2  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov al,0x28 ;red 
		mov cx,6  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		sub di,22
	
	
		;line 17
		add di,320
		add di,7
		mov al,0x28 ;red 
		mov cx,4  ;red loop
		rep stosb  ;red loop
		mov byte[es:di],0x0E ;yellow
		add di,1 ;yellow
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov byte[es:di],0x28 ;red
		add di,1 ;red
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov al,0x28 ;red 
		mov cx,4  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov byte [es:di],0x07;grey 
		add di,1  ; grey
		mov al,0x28 ;red 
		mov cx,2  ;red loop
		rep stosb  ;red loop
		mov byte [es:di],0x2A  ;orange
		add di,1    ;orange
		sub di,24
		
		;line 17
		add di,320
		add di,8
		mov al,0x28 ;red 
		mov cx,4  ;red loop
		rep stosb  ;red loop
		add di,2
		mov al,0x28 ;red 
		mov cx,4  ;red loop
		rep stosb  ;red loop
		mov al,0x2A ;orange
		mov cx,2  ;orange
		rep stosb  ;orange
		mov al,0x28 ;red 
		mov cx,4  ;red loop
		rep stosb  ;red loop
		mov al,0x2A ;orange
		mov cx,3  ;orange
		rep stosb  ;orange
		sub di,25
		
		add di,320
		add di,15
		mov al,0x28 ;red 
		mov cx,3  ;red loop
		rep stosb  ;red loop
		mov al,0x2A ;orange
		mov cx,3  ;orange
		rep stosb  ;orange
		mov al,0x28 ;red 
		mov cx,1  ;red loop
		rep stosb  ;red loop
		mov al,0x2A ;orange
		mov cx,3  ;orange
		rep stosb  ;orange
		sub di,25
		
		add di,320
		add di,17
		mov al,0x2A ;orange
		mov cx,4  ;orange
		rep stosb  ;orange
		add di,3
		mov al,0x2A ;orange
		mov cx,1  ;orange
		rep stosb  ;orange
		sub di,25
		
		add di,320
		add di,20
		mov al,0x2A ;orange
		mov cx,1  ;orange
		rep stosb  ;orange
		
		popa
		pop bp
		ret 2



superman:
push bp
mov bp,sp
pusha
mov word di,[bp+4]
mov ax,0xA000
mov es,ax
xor ax,ax

;line1
add di,5
mov cx,6
mov al,0x10
rep stosb;black
sub di,11


;line 2
add di,320
add di,4
mov cx,3
mov al,0x10
rep stosb;black
mov cx,3
mov al,0x20
rep stosb;blue
mov cx,2
mov al,0x10
rep stosb;black
sub di,12

;line 3
add di,320
add di,3
mov cx,2
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x20
rep stosb;blue
mov cx,6
mov al,0x10
rep stosb;black
sub di,13

;line 4

add di,320
add di,3
mov cx,10
mov al,0x10
rep stosb;black
sub di,13

;line5
add di,320
add di,3
mov cx,6
mov al,0x10
rep stosb;black
mov cx,1
mov al,0x59
rep stosb;skin
mov cx,3
mov al,0x10
rep stosb;black
sub di,13

;line6
add di,320
add di,3
mov cx,2
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x59
rep stosb;skin
mov cx,1
mov al,0x10
rep stosb;black
mov cx,3
mov al,0x59
rep stosb;skin
mov cx,2
mov al,0x10
rep stosb;black
sub di,13

;line 7
add di,320
add di,4
mov cx,1
mov al,0x10
rep stosb;black
mov cx,1
mov al,0x59
rep stosb;skin
mov cx,1
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x59
rep stosb;skin
mov cx,1
mov al,0x10
rep stosb;black
mov cx,1
mov al,0x59
rep stosb;skin
mov cx,1
mov al,0x10
rep stosb;black
sub di,12

;line 8
add di,320
add di,3
mov cx,2
mov al,0x10
rep stosb;black
mov cx,1
mov al,0x59
rep stosb;skin
mov cx,1
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x59
rep stosb;skin
mov cx,1
mov al,0x10
rep stosb;black
mov cx,1
mov al,0x59
rep stosb;skin
mov cx,2
mov al,0x10
rep stosb;black
sub di,13

;line9
add di,320
add di,2
mov cx,1
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x20
rep stosb;blue
mov cx,1
mov al,0x10
rep stosb;black
mov cx,4
mov al,0x59
rep stosb;skin
mov cx,1
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x20
rep stosb;blue
mov cx,1
mov al,0x10
rep stosb;black
sub di,14

;line 10
add di,320
add di,1
mov cx,1
mov al,0x10
rep stosb;black
mov cx,4
mov al,0x20
rep stosb;blue
mov cx,4
mov al,0x10
rep stosb;black
mov cx,4
mov al,0x20
rep stosb;blue
mov cx,1
mov al,0x10
rep stosb;black
sub di,15

;line 11
add di,320
add di,1
mov cx,1
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x20
rep stosb;blue
mov cx,1
mov al,0x10
rep stosb;black
mov cx,1
mov al,0x20
rep stosb;blue
mov cx,1
mov al,0x28
rep stosb;red
mov cx,2
mov al,0x2B
rep stosb;yellow
mov cx,1
mov al,0x28
rep stosb;red
mov cx,1
mov al,0x20
rep stosb;blue
mov cx,1
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x20
rep stosb;blue
mov cx,1
mov al,0x10
rep stosb;black
sub di,15

;line12
add di,320
add di,1
mov cx,1
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x59
rep stosb;skin
mov cx,1
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x20
rep stosb;blue
mov cx,2
mov al,0x28
rep stosb;red
mov cx,2
mov al,0x20
rep stosb;blue
mov cx,1
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x59
rep stosb;skin
mov cx,1
mov al,0x10
rep stosb;black
sub di,15

;line13
add di,320
mov cx,1
mov al,0x10
rep stosb;black
mov cx,1
mov al,0x28
rep stosb;red
mov cx,3
mov al,0x10
rep stosb;black
mov cx,6
mov al,0x20
rep stosb;blue
mov cx,3
mov al,0x10
rep stosb;black
mov cx,1
mov al,0x28
rep stosb;red
mov cx,1
mov al,0x10
rep stosb;black
sub di,16

;line14
add di,320
mov cx,1
mov al,0x10
rep stosb;black
mov cx,3
mov al,0x28
rep stosb;red
mov cx,1
mov al,0x10
rep stosb;black
mov cx,6
mov al,0x2B
rep stosb;yellow
mov cx,1
mov al,0x10
rep stosb;black
mov cx,3
mov al,0x28
rep stosb;red
mov cx,1
mov al,0x10
rep stosb;black
sub di,16

;line15
add di,320
mov cx,1
mov al,0x10
rep stosb;black
mov cx,3
mov al,0x28
rep stosb;red
mov cx,1
mov al,0x10
rep stosb;black
mov cx,3
mov al,0x20
rep stosb;blue
mov cx,1
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x20
rep stosb;blue
mov cx,1
mov al,0x10
rep stosb;black
mov cx,3
mov al,0x28
rep stosb;red
mov cx,1
mov al,0x10
rep stosb;black
sub di,16

;line 16
add di,320
mov cx,1
mov al,0x10
rep stosb;black
mov cx,1
mov al,0x28
rep stosb;red
mov cx,3
mov al,0x10
rep stosb;black
mov cx,3
mov al,0x20
rep stosb;blue
mov cx,1
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x20
rep stosb;blue
mov cx,3
mov al,0x10
rep stosb;black
mov cx,1
mov al,0x28
rep stosb;red
mov cx,1
mov al,0x10
rep stosb;black
sub di,16


;line 17

add di,320
add di,1
mov cx,1
mov al,0x10
rep stosb;black
add di,2
mov cx,1
mov al,0x10
rep stosb;black
mov cx,3
mov al,0x20
rep stosb;blue
mov cx,1
mov al,0x10
rep stosb;black
mov cx,2
mov al,0x28
rep stosb;red
mov cx,1
mov al,0x10
rep stosb;black
add di,2
mov cx,1
mov al,0x10
rep stosb;black
sub di,15

;line 18
add di,320
add di,4
mov cx,1
mov al,0x10
rep stosb;black
mov cx,3
mov al,0x28
rep stosb;red
mov cx,3
mov al,0x10
rep stosb;black
sub di,11

;line 19
add di,5
mov cx,4
mov al,0x10
rep stosb;black

popa
pop bp
ret 2

screen:
		push bp
		push 0
		mov bp,sp
		
		mov cx ,6
		mov word[bp],0;col
		loop9:
		push word[bp]
		push 65;row num
		call mountain
		add word [bp],50
		loop loop9
		call road 
		 push 25650
		 call flash
		
		add sp,2
		pop bp
		ret

right:
		push bp
		mov bp,sp
		sub sp,2
		push ax
		push cx
		push dx
		push es
		push ds
		push si
		push di

		
		mov dx,66
		mov ax,0xA000
		mov es,ax
		mov ds,ax	
		mov si,318
		mov di,319
		mov ax,0
	loop10:	
		
		mov al,[es:di]
		mov [bp-2],al	
		mov cx,319
		anim:
			movsb
			sub si,2
			sub di,2
			loop anim
		mov al,[bp-2]
		mov [es:di],al
		add si,639
		add di,639
		;add si,320
		;add di,320
		sub dx,1
		jnz loop10
		;add sp,2
		pop di
		pop si
		pop ds
		pop es
		pop dx
		pop cx
		pop ax
		add sp,2
		pop bp
		ret

	
left:
		push bp
		mov bp,sp
		sub sp,2
		push dx
		push ax
		push es
		push ds

		
		
		mov ax,0xA000
		mov es,ax
		mov ds,ax	
		push 0
		push word [bp+4]
		call caldi
		mov si,di 
		add si,1
		mov ax,0
		mov dx,24
	loop11:	
		
		mov al,[es:di]
		mov [bp-2],al	
		mov cx,319
		rep movsb
		mov al,[bp-2]
		mov [es:di],al
		sub si,319
		sub di,319
		add si,320	
		add di,320
		sub dx,1
		jnz loop11
		
		
		
		pop ds
		pop es
		pop ax
		pop dx
		add sp,2
		pop bp
		ret 2

brick:

		push bp
		mov bp,sp
		push es
		push ax
		push cx
		push si
		push di 
		
		mov ax,0xA000
		mov es,ax
		mov di,[cs:dbbrick1]
		mov ax,0
		mov dx,3
		loopu2:
		mov cx,50
		mov al,[cs:c1]
		rep stosb
		sub di,50
		add di,320
		sub dx,1
		jnz loopu2
		
		mov di,[cs:dbbrick2]
		mov ax,0
		mov dx,3
		loopu3:
		mov cx,50
		mov al,[cs:c2]
		rep stosb
		sub di,50
		add di,320
		sub dx,1
		jnz loopu3
		
		
		
		mov di,[cs:dbbrick3]
		mov ax,0
		mov dx,3
		loopu4:
		mov cx,50
		mov al,[cs:c3]
		rep stosb
		sub di,50
		add di,320
		sub dx,1
		jnz loopu4
		
		
		
		
		pop di
		pop si
		pop cx
		pop ax
		pop es
		pop bp
		ret





scrolldown:	
			
			push bp
			mov bp,sp
			push ax
			push cx
			push si
			push di
			push es
			push ds
			push bx
			
			mov ax,0xA000
			mov es,ax
			mov ds,ax
		
	
	 
		std
		mov bx,34
		loop24:
		mov di,63999
		mov si, 63679
		mov dx,60
		loop23:
		mov cx,320
		rep movsb 	
		sub dx,1
		jnz loop23 
		sub bx,1
		jnz loop24
		cld
			pop bx
			pop ds
			pop es
			pop di
			pop si
			pop cx
			pop ax
			pop bp
			ret 


Rand:
			push bp
			mov bp,sp
			pusha
			
			rdtsc
			xor  dx, dx
			mov  cx, [bp+4]    
			div  cx       ; here dx contains the remainder of the division - from 0 to 9
			mov [cs:random],dl
			
			popa
			pop bp
			ret 2




movrand:
pusha
push ES
push ds
push si
push di

push 100
call Rand
mov ax,0
mov al,[cs:random]
add al,0
jp mov24
mov word [cs:movb3c],8
jmp exitmr
mov24:
mov word  [cs:movb3c],24

exitmr:

push 100
call Rand
mov ax,0
mov al,[cs:random]
add al,0
jp printc11
mov word [cs:carrotch],0
jmp exitcpl
printc11:
mov word [cs:carrotch],1
exitcpl:


pop di
pop si
pop ds
pop es
popa
ret


randgen:
pusha
push ES
push ds
push si
push di


push 12
call Rand
mov ax,0
mov al,8
mov bl,[cs:random]
MUL byte bl
mov bx,[cs:newbrick]
add ax,bx
mov word [cs:dbbrick3],ax
mov bx,[cs:carrotstore]
mov bx,0
mov bl,[cs:random]
mov ax,0
mov al,[cs:movb3c]
cmp al,8
jne skip24
mov ax,0
mov al,8
mov bl,[cs:random]
MUL byte bl
mov bx,[cs:newbrick]
add ax,bx
mov word [cs:dbbrick3],ax

mov ax,0
mov al,8
mov bl,[cs:random]
MUL byte bl
mov bx,[cs:carrotstore]
add ax,BX
mov word[cs:carrot],ax
jmp rndext
 
skip24:
mov ax,0
mov al,8
mov bl,[cs:random]
MUL byte bl
mov bx,[cs:newbrick]
sub bx,ax
 mov word [cs:dbbrick3],bx
 mov ax,0 
mov al,8
mov bl,[cs:random]
MUL byte bl
mov bx,[cs:carrotstore]
sub bx,ax
mov word[cs:carrot],bx

 rndext:
mov ax,0
push 5
call Rand
mov al,[cs:random]
cmp ax,0
jne col1
mov byte [cs:c3],0x01
mov word [cs:movb3c],50
mov word [cs:blue],0
mov ax,[cs:newbrick]
mov word [cs:dbbrick3 ],ax
col1:
cmp ax,1
jne col2
mov byte [cs:c3],0x2A
col2:
cmp ax,2
jne col3
mov byte [cs:c3],0x08
col3:
cmp ax,3
jne col4
mov byte [cs:c3],0x0C
col4:
cmp ax,4
jne col5
mov byte [cs:c3],0x01
mov word [cs:movb3c],50
mov word [cs:blue],0
mov ax,[cs:newbrick]
mov word [cs:dbbrick3],ax

col5:

pop di
pop si
pop ds
pop es
popa
ret

movup:
	
	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	push dx
	push es
	push ds
	push di
	push si
	
	mov ax,cs
	mov ds,ax
	mov dx,0
	 call checkblu
	 mov word [cs:blue],0
	 call check
	 mov cx,34
	 loopmov:
	;call playanimation
	call clrscr
	 call printscore
	 call printcarrot
	 call printtime
	 call brick
	 sub word [cs:disups],320
	 mov ax,[cs:disups]
	 push ax
	 call superman
	loop loopmov
	call scrolldown
	
	
	  
	add word [cs:dbbrick2],10880
	  mov word ax,[cs:dbbrick2]
	  mov word [cs:dbbrick1],ax
	add word [cs:dbbrick3],10880
	  mov word ax,[cs:dbbrick3]
	  mov word [cs:dbbrick2],ax
	  mov word ax,[cs:newbrick]
	  mov word [cs:dbbrick3],ax
	;mov word ax,[movb1c]						;add condition where it resets after scrolls down
	 mov word bx,[cs:movb2c]  			   		;3 will get 2 cordinates,1 will get 3 cordinates ,2 will get 1 cordinate
	 mov word cx,[cs:movb3c]
	 mov word [cs:movb1c],bx						;set grid tommmorow
	 mov word [cs:movb2c],cx
	; mov word [movb3c],8
	
	 
	  mov byte al,[cs:c1]						;add condition where it resets after scrolls down
	  mov byte bl,[cs:c2]  			   		;3 will get 2 cordinates,1 will get 3 cordinates ,2 will get 1 cordinate
	  mov byte cl,[cs:c3]
	  mov byte [cs:c1],bl						;set grid tommmorow
	  mov byte [cs:c2],cl
	  mov byte [cs:c3],al
		
		 call playanimation
		call movrand
		call randgen
		add word [cs:disups],320*34
	
	
    	call clrscr
		call printscore
		call printcarrot
		call printtime
		call brick
		mov ax,[cs:disups]
		push ax
		call superman
	pop si
	pop di
	pop ds
	pop es
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret

	kbisr: 
	
	push ax
	push es
	mov ax, 0xA000
	mov es, ax ; point es to video memory
	mov ax,0
	in al, 0x60 ; read a char from keyboard port
	
	cmp word [cs:gamestart],0
	je nomatch
	 cmp al,0x01;esc
	 jne sk98
	 mov word [cs:gamepause],1
	 call blank
	 call pause
	 sk98:
	 cmp word [cs:gamepause],0
	 je skipcheckres
	 cmp al,0x15;no
	 jne skipai2
	 mov word [cs:gamepause],0
	 skipai2:
	 cmp al,0x31;yes
	 jne skipcheckres
	 mov word [cs:gamepause],0	
	 mov word[cs:endkey],1
	 skipcheckres:
	 cmp al, 0x48 ; upkey
	 je exit ; leave interrupt routine
			
			mov al, 0x20
			out 0x20, al ;
			 pop es
			 pop ax
			 ;jmp far [cs:oldisr] 
			iret

		nomatch:
		
			 cmp al,0x1C;enter
			 jne skipga
			 mov word [cs:gamestart] ,1
			 skipga:
	
				mov al, 0x20
				out 0x20, al ; send EOI to PIC
				pop es
				pop ax
			
 ;jmp far [cs:oldisr] ; call the original ISR
			iret
		 exit:
			
			 call checkcarrot
			 call movup
			 call printcarrot
			 call printscore
			 call printtime			
			  
			  
			  mov al, 0x20
			  out 0x20, al ; send EOI to PIC
			  pop es
			  pop ax
			;  jmp far [cs:oldisr]
			
			iret ; return from interrupt

			timer:		
			push ax
			
			cmp word[cs:gamestart],1
			jne skiptii
			cmp word[cs:gamepause],0
			jne skiptii
			cmp word[cs:endkey],0
			jne skiptii
			inc word [cs:seconds];
			mov ax,[cs:seconds]
			cmp ax,18
			jne skip
			mov bl,[cs:c1]
			cmp bl,0x01
			jne skipbluinc
			inc word [cs:blue]
			 skipbluinc:
			inc byte [cs:time]
			mov word [cs:seconds],0
			
			
			skip:			
			call printtime
			skiptii:
			mov al, 0x20
			out 0x20, al ; end of interrupt
			pop ax
			iret
setkbsir:
		push ax
		push es
		

		
				xor ax, ax
				mov es, ax ; point es to IVT base
				mov ax, [es:9*4]
				mov [oldisr], ax ; save offset of old routine
				mov ax, [es:9*4+2]
				mov [oldisr+2], ax ; save segment of old routine
				cli ; disable interrupts
				mov word [es:9*4], kbisr ; store offset at n*4
				mov [es:9*4+2], cs ; store segment at n*4+2
				sti ; enable interrupts
			
				 mov ax,0
				 mov es,ax
				 cli; disable interrupts
				 
				 mov ax, [es:8*4]
				 mov [oldisr2], ax ; save offset of old routine
				 mov ax, [es:8*4+2]
				 mov [oldisr2+2], ax ; save segment of old routine
				 mov word [es:8*4], timer; store offset at n*4
				 mov [es:8*4+2], cs ; store segment at n*4+2
				 sti ; enable interrupts
			
			

		
		pop es
		pop ax
		ret
		
		
sbrick3:
	cli
	push bp
	mov bp,sp
	pusha



	mov ax,[cs:movb3c]	
	cmp ax,50
	je sk3m
	mov ax,[cs:movb3c]
	cmp ax,0
	jne rightbr3
	
	rightbr3:
	cmp ax,16
	jge leftbr3
	call rbrick3
	jmp endbr3
	cmp ax,16
	jl endbr3
	leftbr3:
	call lbrick3
	endbr3:
	
		
	sk3m:
	popa
	pop bp
	sti
	ret
rbrick3:
	push bp
	mov bp,sp
	pusha
	mov ax,[cs:dbbrick3]
		cmp ax,41160
		jL movr3
		mov word [cs:movb3c],24
		movr3:
	mov ax,[cs:speed]
	add word [cs:dbbrick3],ax
	
	call clrscr
	call printcarrot
	call printscore
	call printtime
	call brick
	mov ax,[disups]
		push ax
		call superman
	call delay
	
	popa
	pop bp
	ret
	
lbrick3:
	push bp
	mov bp,sp
	pusha
	
		mov ax,[cs:dbbrick3]
		cmp ax,41020
		jg movl3
		mov word [cs:movb3c],8
		movl3:
		mov ax,[cs:speed]
		sub word [cs:dbbrick3],ax
	call clrscr
	call printcarrot
	call printscore
	call printtime
	call brick
	mov ax,[disups]
		push ax
		call superman
	call delay
	popa
	pop bp
	ret
	
		sbrick2:
		cli
		push bp
		mov bp,sp
		pusha

		mov ax,[cs:movb2c]
		cmp ax,50
		je sk2m

		mov cx,[cs:speed]
		loopsk2:
		mov ax,[cs:movb2c]
		cmp ax,0
		jne rightbr2
		
		rightbr2:
		cmp ax,16
		jge leftbr2
		call rbrick2
		jmp endbr2
		cmp ax,16
		jl endbr2
		leftbr2:
		call lbrick2
		endbr2:
		


		sk2m:
		popa
		pop bp
		sti
		ret
	rbrick2:
		push bp
		mov bp,sp
		pusha
			
			
		mov ax,[cs:dbbrick2]
		cmp ax,52040
		jL movr2
		mov word [cs:movb2c],24
		movr2:
		mov ax,[cs:speed]
		add word [cs:dbbrick2],ax
		call clrscr
		call printscore
		call printtime
		call brick
		call printcarrot
		mov ax,[disups]
		push ax
		call superman
		call delay
		
		popa
		pop bp
		ret
		
	lbrick2:
		push bp
		mov bp,sp
		pusha
		
		mov ax,[cs:dbbrick2]
		cmp ax,51900
		jg movl2
		mov word [cs:movb2c],8
		movl2:
		mov ax,[cs:speed]
		sub word [cs:dbbrick2],ax
		call clrscr
		call printcarrot
		call printscore
		call printtime
		call brick
		mov ax,[disups]
		push ax
		call superman
		call delay
		popa
		pop bp
		ret
sbrick1:
		cli
		push bp
		mov bp,sp
		pusha
		mov ax,[cs:movb1c]
		cmp ax,50
		je sk1m

		mov ax,[cs:movb1c]
		cmp ax,0
		jne rightbr1
		
		rightbr1:
		cmp ax,16
		jge leftbr1
		call rbrick1
		jmp endbr1
		cmp ax,16
		jl endbr1
		leftbr1:
		mov dx,0
		call lbrick1
		endbr1:
		;sub word [cs:movb1c],1
		;loop loopsk1
		sk1m:
		popa
		pop bp
		sti
		ret
	rbrick1:
		push bp
		mov bp,sp
		pusha
		
		mov ax,[cs:dbbrick1]
		cmp ax,62920
		jL movr1
		mov word [cs:movb1c],24
		movr1:
		mov ax,[cs:speed]
		add word [cs:dbbrick1],ax
		add word[cs:disups],ax
		call clrscr
		call printcarrot
		call printscore
		call printtime
		call brick
		mov ax,[disups]
		push ax
		call superman
		call delay
		
		popa
		pop bp
		ret
		
	lbrick1:
		push bp
		mov bp,sp
		pusha
		
		
		mov ax,[cs:dbbrick1]
		cmp ax,62780
		jg movl1
		mov word [cs:movb1c],8
		movl1:
		mov ax,[cs:speed]
		sub word [cs:dbbrick1],ax
		sub word[cs:disups],ax
		;call clrsr
		call clrscr
		call printcarrot
		call printscore
		call printtime
		call brick
		mov ax,[cs:disups]
		push ax
		call superman
		call delay
		popa
		pop bp
		ret
check:
		push bp
		mov bp,sp
		push ax
		push bx
		push cx
		push dx
		push es
		push ds
		push di
		push si
		
		mov ax,[cs:disups]
		sub ax,5115
		mov bx,[cs:dbbrick2]
		sub bx,ax
		cmp bx,7
		jle skipch
		mov word[cs:endkey],1
		
		;jmp endgame
		skipch:
		 mov ax,[cs:disups]
		 sub ax,5115
		 mov bx,[cs:dbbrick2]
		 ;add bx,50
		 sub ax,bx
		 cmp ax,0
		 jl skipch2
		 cmp ax,50
		 jle skipch2
		 mov word[cs:endkey],1
		 skipch2:
		pop si
		pop di
		pop ds
		pop es
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret
		
		printscore:
		pusha
				mov ah,02h		;Sets Position for Second Digit
				mov bh,0
				mov dh,90
				mov dl,254
				int 10h
				
				mov al,[cs:score]	;Calculates Second Digit
				mov ah,0
				mov bl,10
				div bl
				add al,'0'
				add ah,'0'
				mov dx,ax
				
				mov ah,0x09		;Prints Second Digit
				mov al,dh
				mov bx,0xf
				mov cx,1
				int 0x10
				
				mov ah,02h		;Sets Position for First Digit
				mov bh,0
				mov dh,90
				mov dl,253
				int 10h
				
				mov al,[cs:score]	;Calculates First Digit
				mov ah,0
				mov bl,10
				div bl
				add al,'0'
				add ah,'0'
				mov dx,ax
				
				mov ah,0x09		;Prints First Digit
				mov al,dl
				mov bx,0xf
				mov cx,1
				int 0x10

				mov ah,02h		;Brings Back 
				mov bh,0
				mov dx,0
				int 10h
				popa
				ret
			
		printcarrot:
		pusha
		
		cmp word [cs:carrotch],0
		jne skipcarpri
		mov ax,0xA000
		mov di,[cs:carrot]
		mov es,ax
		mov cx,3
		loopc:
		mov byte [es:di],0x2C
		add di,1
		mov byte [es:di],0x2C
		add di,1
		mov byte [es:di],0x2C
		add di,1
		mov byte [es:di],0x2C
		add di,1
		mov byte [es:di],0x2C
		add di,1
		add di,315
		loop loopc
		skipcarpri:
		popa
		ret 		
		
		checkcarrot:
		pusha
		mov ax,0xA000
		mov es,ax
		mov di,[cs:disups]
		sub di,2880
		mov cx,16
		mov ax,0
		l87:
		mov byte al,[es:di]
		add di,1
		cmp al,0x2C
		je increment
		loop l87
		jmp skipco
		increment:
		add byte [cs:score],1
			mov ax,0
			mov al,[cs:score]
			cmp ax,0
			je skipspeedch
			
			xor  dx, dx
			mov  cx, 5
			div  cx       ; here dx contains the remainder of the division - from 0 to 9
			cmp dx,0
			jne skipspeedch
			add word [cs:speed],10
			
			 skipspeedch:
		skipco:
		popa
		ret

printtime:
				pusha
				mov ah,02h		;Sets Position for Second Digit
				mov bh,0
				mov dh,14
				mov dl,1
				int 10h
				
				mov al,[cs:time]	;Calculates Second Digit
				mov ah,0
				mov bl,10
				div bl
				add al,'0'
				add ah,'0'
				mov dx,ax
				
				mov ah,0x09		;Prints Second Digit
				mov al,dh
				mov bx,0xf
				mov cx,1
				int 0x10
				
				mov ah,02h		;Sets Position for First Digit
				mov bh,0
				mov dh,14
				mov dl,0
				int 10h
				
				mov al,[cs:time]	;Calculates First Digit
				mov ah,0
				mov bl,10
				div bl
				add al,'0'
				add ah,'0'
				mov dx,ax
				
				mov ah,0x09		;Prints First Digit
				mov al,dl
				mov bx,0xf
				mov cx,1
				int 0x10

				mov ah,02h		;Brings Back 
				mov bh,0
				mov dx,0
				int 10h
				popa
				ret

checkblu:
	
	pusha
	mov bx,[cs:blue]
	cmp bx,3
	jne skipblu
	mov word[cs:endkey],1
	skipblu:
	popa
	ret
stringprint:
			push bp
			mov bp,sp
            pusha
			push es
            mov ax,cs
            mov es,ax
            mov ah,13h;service to print string in graphic mode
            mov al,0;sub-service 0 
            mov bx,[bp+6] ;color of the text (white foreground and black background) in bl,bh=0
			mov bh,0;page number=always zero
            mov cx,[bp+8];length of string
			mov dx,[bp+4] ;dh->y coordinate dl->x coordinate
            mov bp,[bp+10];mov bp the offset of the string
            int 10h
			pop es
            popa
			pop bp
            ret 8

startscreen:
pusha
	push 12900 
	call superman
	push 12987 
	call superman
	
	push string    ;address ofstring
	push 8	;length of String
	mov bx,0x0004	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push bx			;rows-cols
	push 0x060F	;rows-cols
	call stringprint
	
	push  string1    ;address ofstring
	push 20		;length of String
	mov bx,0x002C	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push bx			;rows-cols
	push 0x0909	;rows-cols
	call stringprint
	
	push  string4    ;address ofstring
	push 22		;length of String
	mov bx,0x000E	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push bx			;rows-cols
	push 0x0B08	;rows-cols
	call stringprint
	
	push  string2    ;address ofstring
	push 20		;length of String
	mov bx,0x000F	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push bx			;rows-cols
	push 0x0D09	;rows-cols
	call stringprint
	
	push  string3   ;address ofstring
	push 16		;length of String
	mov bx,0x000F	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push bx			;rows-cols
	push 0x0F0B	;rows-cols
	call stringprint

	push  string5    ;address ofstring
	push 20		;length of String
	mov bx,0x000F	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push bx			;rows-cols
	push 0x1109	;rows-cols
	call stringprint
	popa
	ret
	
	
	game:
	
		pusha
		cmp word [cs:gamepause],0
		jne endgame
		cmp word [cs:endkey],1
		je endgame
		call blank
		call clrscr
		call sky
		call screen
		call brick
	  mov ax,[disups]
	  push ax
		call superman
	  call printscore
	  call printtime
	  call printcarrot


		l1:
		cmp word [endkey],1
		je endgame
		cmp word [cs:gamepause],0
		jne endgame
		mov dx,0

	
		
		call sbrick2
		cmp word [endkey],1
		je endgame
		cmp word [cs:gamepause],0
		jne endgame
		 call sbrick3
		 cmp word [endkey],1
		je endgame
		cmp word [cs:gamepause],0
		jne endgame; potetnial error
		 call sbrick1
		 cmp word [cs:endkey],1
		je endgame
		cmp word [cs:gamepause],0
		jne endgame
		 call checkblu
		 cmp word [cs:endkey],1
		je endgame
		cmp word [cs:gamepause],0
		jne endgame
		 call right
		 cmp word [cs:endkey],1
		je endgame
		cmp word [cs:gamepause],0
		jne endgame
		 push 70
		 call left 
		 cmp word [cs:endkey],1
		je endgame
		cmp word [cs:gamepause],0
		jne endgame
		 push 70
		 call left
		 cmp word [cs:endkey],1
		je endgame
		cmp word [cs:gamepause],0
		jne endgame
		 push 70
		 call left   
		
		jmp l1
		
	endgame:
	
popa
ret


playanimation:
pusha
		cmp word [cs:endkey],1
		je skipanimationrand
		cmp word [cs:gamepause],0
		jne skipanimationrand
		call right
		 cmp word [cs:endkey],1
		je skipanimationrand
		cmp word [cs:gamepause],0
		jne skipanimationrand
		 push 70
		 call left 
		 cmp word [cs:endkey],1
		je skipanimationrand
		cmp word [cs:gamepause],0
		jne skipanimationrand
		 push 70
		 call left
		 cmp word [cs:endkey],1
		je skipanimationrand
		cmp word [cs:gamepause],0
		jne skipanimationrand
		 push 70
		 call left   	
	skipanimationrand:

popa
ret

 pause:
			pusha
			call blank
			push 12890 
			call superman
			push 12990 
			call superman
			push 25670
			call flash
			push 25800
			call flash
			
			push  string8    ;address ofstring
			push 8	;length of String
			mov bx,0x000F	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
			push bx			;rows-cols
			push 0x060E	;rows-cols
			call stringprint
			
			push  string9   ;address ofstring
			push 12	;length of String
			mov bx,0x000F	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
			push bx			;rows-cols
			push 0x080C	;rows-cols
			call stringprint
			
			push  string10    ;address ofstring
			push 8	;length of String
			mov bx,0x000F	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
			push bx			;rows-cols
			push 0x0A0E	;rows-cols
			call stringprint
			popa	
			ret
	
	endscreen:
			
			pusha
			call blank
			push 12890 
			call superman
			push 12990 
			call superman
			push 25680
			call flash
			push 25790
			call flash
			push  string6    ;address ofstring
			push 9	;length of String
			mov bx,0x000F	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
			push bx			;rows-cols
			push 0x060E	;rows-cols
			call stringprint
			
			push  string7    ;address ofstring
			push 6	;length of String
			mov bx,0x000F	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
			push bx			;rows-cols
			push 0x0810	;rows-cols
			call stringprint
				
				
				mov ah,02h		;Sets Position for Second Digit
				mov bh,0
				mov dh,10
				mov dl,19
				int 10h
				
				mov al,[cs:score]	;Calculates Second Digit
				mov ah,0
				mov bl,10
				div bl
				add al,'0'
				add ah,'0'
				mov dx,ax
				
				mov ah,0x09		;Prints Second Digit
				mov al,dh
				mov bx,0xf
				mov cx,1
				int 0x10
				
				mov ah,02h		;Sets Position for First Digit
				mov bh,0
				mov dh,10
				mov dl,18
				int 10h
				
				mov al,[score]	;Calculates First Digit
				mov ah,0
				mov bl,10
				div bl
				add al,'0'
				add ah,'0'
				mov dx,ax
				
				mov ah,0x09		;Prints First Digit
				mov al,dl
				mov bx,0xf
				mov cx,1
				int 0x10

				mov ah,02h		;Brings Back 
				mov bh,0
				mov dx,0
				int 10h
				popa
				ret
	
start:
  
  
	mov AX,0013H
	int 10H 
	call setkbsir	
   call startscreen
	 keywit:
	 cmp word [cs:gamestart],1
	 jne keywit
 



	
	  loopin: 
	  call game
	  cmp word [cs:endkey],0
	  je loopin

 
 
 
 call endscreen

mov cx, 10

lll:
call delay
call delay
call delay
loop lll




 cli 
  mov ax,0
  mov es,ax  
  
  mov ax, [oldisr] ; read old offset in ax
  mov bx, [oldisr+2] ; read old segment in bx
   ;disable interrupts
  mov [es:9*4], ax ; restore old offset from ax
  mov [es:9*4+2], bx ; restore old segment from bx
 sti ; enable interrupts 
 
	 cli
      mov ax, [oldisr2] ; read old offset in ax
      mov bx, [oldisr2+2] ; read old segment in bx
      ; disable interrupts
      mov [es:8*4], ax ; restore old offset from ax
      mov [es:8*4+2], bx ; restore old segment from bx
      sti ; enable interrupts
	
   

	mov ah,0x00
    mov al,0x03
    int 0x10 
	; mov ah,0x08	
	; int 0x21   


mov ax,0x4c00
int 0x21