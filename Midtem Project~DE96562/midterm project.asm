		#include<p18f4550.inc>

lp_cnt1 set 0x10
lp_cnt2 set 0x11
		
		org	0x00
		goto	start
		org	0x08
		retfie
		org	0x18
		retfie
;===================================================================
; HOW TO CREATE A DELAY OF  10li sec
; with a crystal of 20MHz
; subroutine for delay 10mili sec
;*************************************************
dup_nop 	macro kk ;macro function will execute duplication 
				 	 ;dup_nop it means duplicate no operation
			variable i ;kk times   
i=0
			while i < kk
			nop
i+=1
			endw
			endm

delay10msec 	movlw D'20' 
				movwf lp_cnt1,A
again1 			movlw D'250'
				movwf lp_cnt2,A
again2 			dup_nop D'17' ;29 instruction cycle
				decfsz lp_cnt2, F,A ;1 instruction cycle
				bra again2 ;2 instruction cyle
				decfsz lp_cnt1, F, A ;total 31 instruction cycle
				bra again1
				return

; (20 x 250 x (17+1+2) = 100 000 i.c
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;SUBROUTINE FOR ALL PORT
configurePB bsf TRISC,1,A ;CONFIGURE PORT FOR PUSH BUTTON
			bsf TRISC,2,A ;CONFIGURE PORT FOR PUSH BUTTON
			clrf PORTC,A
			return
;__________________________________________________________________
;*******************MAIN DATA FOR LCD******************************
;-----------------------------------------------------------------
;CONFIGURE TRIS
PORTsend_data	clrf TRISC,A ;CONFIGURE INPUT PORTC
				clrf TRISD,A ;CONFIGURE INPUT PORTD	
				call setupLCD			 
				return

;*******************CONFIGURE LCD********************************
setupLCD	bcf PORTC,4,A ;RS=0
			bcf PORTC,5,A ;RW=0		;BEFORE I SENT DATA
			bsf PORTC,6,A ;E=1
			call delay10msec
			bcf PORTC,6,A ;E=0
			return
	

;____________________________________________________________________
;CONFIGURE LCD

matrix		movlw 0x38
			movwf PORTD,A	;2 lines and 5x7 matrix
			return

turn_on		movlw 0x0F
			movwf PORTD,A	;DISPLAY ON,CURSOR BLINKING		
			return

second_line	movlw 0xC0
			movwf PORTD,A
			return

clear_display	movlw 0x01	;CLEAR THE SCREEN
				movwf PORTD,A
				return

;_____________________________________________________________________
;SEND DATA

setupLCD1	bsf PORTC,4,A	;RS=1	;DATA MODE
			bcf PORTC,5,A	;RW=0
			bsf PORTC,6,A	;E=1
			call delay10msec
			bcf PORTC,6,A	;EN=0
			return	
;____________________________________________________________________
;NAME AND STUDENT ID

my_name		movlw D'77'	;CAPITAL M
			movwf PORTD,A
			call setupLCD1
			movlw D'85'	;CAPITAL U
			movwf PORTD,A
			call setupLCD1
			movlw D'72'	;CAPITAL H
			movwf PORTD,A
			call setupLCD1
			movlw D'65'	;CAPITAL A
			movwf PORTD,A
			call setupLCD1
			movlw D'77'	;CAPITAL M
			movwf PORTD,A
			call setupLCD1
			movlw D'77' ;CAPITAL M
			movwf PORTD,A
			call setupLCD1
			movlw D'65' ;CAPITAL A
			movwf PORTD,A
			call setupLCD1
			movlw D'68' ;CAPITAL D
			movwf PORTD,A
			call setupLCD1
			movlw D'32'	;SPACING
			movwf PORTD,A
			call setupLCD1
			movlw D'39'	;COMA
			movwf PORTD,A
			call setupLCD1
			movlw D'65' ;CAPITAL A
			movwf PORTD,A
			call setupLCD1
			movlw D'84' ;CAPITAL T
			movwf PORTD,A
			call setupLCD1
			movlw D'73'	;CAPITAL I
			movwf PORTD,A
			call setupLCD1
			movlw D'81'	;CAPITAL Q
			movwf PORTD,A
			call setupLCD1			
			return 
;==============================================================
my_id		movlw D'68' ;CAPITAL D
			movwf PORTD,A
			call setupLCD1
			movlw D'69'	;CAPITAL E
			movwf PORTD,A
			call setupLCD1	
			movlw D'57'	;CAPITAL 9
			movwf PORTD,A
			call setupLCD1	
			movlw D'54'	;CAPITAL 6
			movwf PORTD,A
			call setupLCD1	
			movlw D'53'	;CAPITAL 5
			movwf PORTD,A
			call setupLCD1
			movlw D'50'	;CAPITAL 2
			movwf PORTD,A
			call setupLCD1
			return		
;_________________________________________________________________________________
;KEYPAD NUMBER SUBROUTINE

bcd0		movlw 0xC0		;NUMBER 0
			movwf PORTD,A
			call setupLCD
			movlw D'48'
			movwf PORTD,A
			call setupLCD1	
			return
	
bcd1		movlw 0xC0		;NUMBER 1
			movwf PORTD,A
			call setupLCD
			movlw D'49'
			movwf PORTD,A
			call setupLCD1	
			return
	

bcd2		movlw 0xC0		;NUMBER 2
			movwf PORTD,A
			call setupLCD
			movlw D'50'
			movwf PORTD,A
			call setupLCD1	
			return

bcd3		movlw 0xC0		;NUMBER 3
			movwf PORTD,A
			call setupLCD
			movlw D'51'
			movwf PORTD,A
			call setupLCD1
			return

bcd4		movlw 0xC0		;NUMBER 4
			movwf PORTD,A
			call setupLCD
			movlw D'52'
			movwf PORTD,A
			call setupLCD1	
			return

bcd5		movlw 0xC0		;NUMBER 5
			movwf PORTD,A
			call setupLCD
			movlw D'53'
			movwf PORTD,A
			call setupLCD1	
			return

bcd6		movlw 0xC0		;NUMBER 6
			movwf PORTD,A
			call setupLCD
			movlw D'54'
			movwf PORTD,A
			call setupLCD1	
			return

bcd7		movlw 0xC0		;NUMBER 7
			movwf PORTD,A
			call setupLCD
			movlw D'55'
			movwf PORTD,A
			call setupLCD1	
			return

bcd8		movlw 0xC0		;NUMBER 8
			movwf PORTD,A
			call setupLCD
			movlw D'56'
			movwf PORTD,A
			call setupLCD1	
			return

bcd9		movlw 0xC0		;NUMBER 9
			movwf PORTD,A
			call setupLCD
			movlw D'57'
			movwf PORTD,A
			call setupLCD1	
			return

bcd_star	movlw 0xC0		;NUMBER *
			movwf PORTD,A
			call setupLCD
			movlw D'42'
			movwf PORTD,A
			call setupLCD1	
			return

bcd#		movlw 0xC0		;NUMBER #
			movwf PORTD,A
			call setupLCD
			movlw D'35'
			movwf PORTD,A
			call setupLCD1	
			return
;_____________________________________________________________________________
;SETUP CONTROLLER

off			movlw 0x01
			movwf PORTD,A
			call setupLCD
			return

off_LCD		call off
			bra check_PB2
			return

off_LCD1	call off
			bra configure
			return

progress	call matrix
			call setupLCD
			call turn_on
			call setupLCD
			call clear_display
			return

progress1	call matrix			
			call setupLCD
			call turn_on
			call setupLCD
			call clear_display
			call second_line	;THIS FUNCTION WILL SHOW THE NUMBER IN SECOND LINE
			call setupLCD
			return		

show_name	call progress
			call my_name
			return

show_id		call progress
			call my_id
			return

;__________________________________________________________________
;SETTING KEYPAD
;_________________________________________________________________
configure_keypad	movlw B'00001110' ;SETTING UP PORTB OF KEYPAD
					movwf TRISB,A
					return
					
configure	clrf TRISC,A
			clrf TRISD,A
			setf TRISB,A
			call configure_keypad
			movlw 0x38
			movwf PORTD,A
			call setupLCD
			movlw 0x0E
			movwf PORTD,A
			call setupLCD
			movlw 0x80
			movwf PORTD,A
			return

;****************************************************************
;MAIN PROGRAM
;****************************************************************

start		clrf TRISC,A
			clrf TRISD,A
			setf TRISB,A
			call configure_keypad
			movlw 0x38
			movwf PORTD,A
			call setupLCD
			movlw 0x0E
			movwf PORTD,A
			call setupLCD
			movlw 0x80
			movwf PORTD,A


show_bcd1	clrf PORTB,A
			bsf PORTB,4,A
			btfsc PORTB,1,A
			bra bcd1
			clrf PORTD,A

show_bcd2	clrf PORTB,A
			bsf PORTB,4,A
			btfsc PORTB,2,A
			bra bcd2
			clrf PORTD,A
		
show_bcd3	clrf PORTB,A
			bsf PORTB,4,A
			btfsc PORTB,3,A
			bra bcd3
			clrf PORTD,A

show_bcd4   clrf PORTB,A
		   	bsf PORTB,5,A
			btfsc PORTB,1,A
			bra bcd4
			clrf PORTD,A

show_bcd5   clrf PORTB,A
			bsf PORTB,5,A
			btfsc PORTB,2,A
			bra bcd5
			clrf PORTD,A

show_bcd6   clrf PORTB,A
			bsf PORTB,5,A
			btfsc PORTB,3,A
			bra bcd6
			clrf PORTD,A

show_bcd7	clrf PORTB,A
			bsf PORTB,6,A
			btfsc PORTB,1,A
			bra bcd7
			clrf PORTD,A

show_bcd8	clrf PORTB,A
			bsf PORTB,6,A
			btfsc PORTB,2,A
			bra bcd8
			clrf PORTD,A
		
show_bcd9	clrf PORTB,A
			bsf PORTB,6,A
			btfsc PORTB,3,A
			bra bcd9
			clrf PORTD,A

show_star	clrf PORTB,A
			bsf PORTB,7,A
			btfsc PORTB,1,A
			bra bcd_star
			clrf PORTD,A

show_0		clrf PORTB,A
			bsf PORTB,7,A
			btfsc PORTB,2,A
			bra bcd0
			clrf PORTD,A
		
show_#		clrf PORTB,A
			bsf PORTB,7,A
			btfsc PORTB,3,A
			bra bcd#
			clrf PORTD,A

setup_PB	call configurePB
			call PORTsend_data

check_PB1 	btfss PORTC,1,A	;PUSH BUTTTON 1
			bra off_LCD
			bra show_name
			bra check_PB2

check_PB2	btfss PORTC,2,A	;PUSH BUTTON 2
			bra off_LCD1
			bra show_id
			bra check_PB1
			end
			












































