
MAIN:{

#import "lookups/zeropage.asm"
BasicUpstart2(Entry)

#import "lookups/registers.asm"
#import "common/macros.asm"

.label IRQControlRegister1 = $dc0d
.label IRQControlRegister2 = $dd0d
.label COLOR_ADDRESS = VECTOR1


ThreeTimes:	.fill 25, round(i/4) * 3
// my variables

AddPerCharIndex:	.byte 0, 64, 128, 192
CharIndex:			.byte 0
RowUse:				.byte 0
RowOffset:			.byte 0
Colour:			.byte %11110001
Colour2:				.byte %01110010

StringLength:	.byte 16
CharLength:		.byte 0
CharEnd:	.byte 0

.encoding "petscii_mixed"
INTROMESSAGE:	.text "l@salako@j@@@@@@"
INTROMESSAGE2:	.text "@ma@l@@@"

ScreenRowLSB:
	.fill 25, <[i * $28]
ScreenRowMSB:
	.fill 25, >[i * $28]


// 8-bit-guy variables

ACC:	.byte	$00
AUX:	.byte	$00
AUX2:	.byte	$00
ACC2:	.byte	$00
EXT:	.byte	$00
EXT2:	.byte	$00			
CRS_X:	.byte $10	//location of cursor X (0-52)
CRS_XR:	.byte $00	//actual screen cursor X (0-39)
CRS_Y:	.byte $10	//location of cursor y
SCRM_L:	.byte $00	//screen RAM location of X,y
SCRM_H:	.byte $00
CHRM_L:	.byte $00	//Character RAM location
CHRM_H:	.byte $00
CHR:	.byte $00	//character to be plotted



//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
Entry: 
	
	
	lda #$7f
	sta IRQControlRegister1
	sta IRQControlRegister2

	lda #0
	sta $d020

	jsr REGISTERS.BankOutKernalandBasic

	SETUP:		jsr GFX_ON
				jsr	CLRSCN
				jmp	WELCOME


Loop:
	
	jmp Loop


CalculateAddresses:{

	//get row for this position
	ldy CRS_Y
	lda ScreenRowLSB, y

	// Get CharAddress
	
	clc
	adc CRS_XR

	sta COLOR_ADDRESS

	lda ScreenRowMSB, y	
	adc #0  // get carry bit from above
	sta RowOffset

	lda #>$0400
	clc
	adc RowOffset
	sta COLOR_ADDRESS + 1

	rts

}

WELCOME:lda	#$08
		sta	CRS_X
		tax
		lda COLCHART, x
		sta CRS_XR
		lda CRS_X
		and #%00000011
		sta CharIndex
		lda	RowUse
		sta	CRS_Y
		lda	#$00
		sta	STRINGPL

		ldx StringLength
		lda ThreeTimes, x
		sta CharLength

		clc
		adc CRS_XR
		sta CharEnd


WEL01:	ldx	STRINGPL

		lda	INTROMESSAGE,x
		sec
		sbc #48
		sta CHR

		ldx CharIndex
		lda AddPerCharIndex, x
		clc
		adc CHR
		sta CHR

		jsr	CA004

		ldx CRS_X
		lda COLCHART, x
		sta CRS_XR

		cmp CharEnd
		bcc ColourIt

		jmp NoColour

		ColourIt:

		jsr CalculateAddresses

		ldy #0
		lda Colour
		sta (COLOR_ADDRESS), y

	//	inc Colour

		NoColour:

		//jsr CRS_ADVANCE
		inc	STRINGPL
		lda	STRINGPL
		cmp	StringLength
		bne	WEL01
		jsr	CRS_RETURN

		inc RowUse
		lda RowUse
		cmp #1
		bcc WELCOME
		
		jmp Loop

STRINGPL:	.byte 	$00

CA004:
		jsr	PLOTA
		jsr CRS_ADVANCE
		rts


CRS_ADVANCE:
		inc CharIndex
		lda CharIndex
		and #%00000011
		sta CharIndex

		inc CRS_X
		//lda	CRS_X
		//cmp	#$35
		//beq	CRS_RETURN
		rts
CRS_RETURN:	lda	#$00
		sta CharIndex
		sta	CRS_X
		inc	CRS_Y
		lda	CRS_Y
		rts
	

PLOTA:	ldx	CRS_X		//calculate location of screen-ram
		lda	COLCHART,x
		sta	AUX
		sta CRS_XR
		lda	#$00
		sta	AUX2
		lda	#$08
		sta	ACC
		lda	#$00
		sta	ACC2
		jsr	MULT
		lda	ACC
		sta	$FD		//$FD+$FE = screen location
		lda	ACC2
		sta	$FE
		ldx	CRS_Y
		lda	ROWCHART_L,x
		clc
		adc	$FD
		sta	$FD
		lda	ROWCHART_H,x
		adc	$FE
		sta	$FE

		lda	#$08		//calculate location of char-ram
		sta	ACC
		lda	#$00
		sta	ACC2
		sta	AUX2
		lda	CHR
		sta	AUX
		jsr	MULT
		clc
		lda	ACC
		adc	#<CHARSET_A
		sta	$FB
		lda	ACC2
		adc	#>CHARSET_A
		sta	$FC
		
		ldx	CRS_X
		lda	PLCHART,x
		ldy #$00
		cmp	#$00
		bne	PL01
		jmp	pla01
PL01:	cmp	#$01
		bne	PL02
		jmp	PLB01
PL02:	cmp	#$02
		bne	PL03
		jmp	PLC01
PL03:	jmp	PLD01




		

pla01:		lda	($FD),y		//Get existing pixels
			and	#%00000011
			sta	PLTEMP
			lda	($FB),y
			ora	PLTEMP
			sta	($FD),y
			iny
			cpy	#$08
			bne	pla01	
			rts


PLB01:		lda	($FD),y		//Get existing pixels
			and	#%11111100
			sta	PLTEMP
			lda	($FB),y
			//ror
			//ror
			////ror
			//ror
			//ror
			//ror
			and	#%00000011
			ora	PLTEMP
			sta	($FD),y
			iny
			cpy	#$08
			bne	PLB01	
			ldy	#$00
			lda	$FD
			clc
			adc	#$08
			sta	$FD
			lda	$FE
			adc	#$00
			sta	$FE
PLB02:		lda	($FD),y		//Get existing pixels
			and	#%00001111
			sta	PLTEMP
			lda	($FB),y
			//asl
			//asl
			and	#%11110000
			ora	PLTEMP
			sta	($FD),y
			iny
			cpy	#$08
			bne	PLB02	
			rts


PLC01:		lda	($FD),y		//Get existing pixels
			and	#%11110000
			sta	PLTEMP
			lda	($FB),y
			//ror
			//ror
			//ror
			//ror
			and	#%00001111
			ora	PLTEMP
			sta	($FD),y
			iny
			cpy	#$08
			bne	PLC01	
			ldy	#$00
			lda	$FD
			clc
			adc	#$08
			sta	$FD
			lda	$FE
			adc	#$00
			sta	$FE

PLC02:		lda	($FD),y		//Get existing pixels
			and	#%00111111
			sta	PLTEMP
			lda	($FB),y
			//asl
			//asl
			////asl
			//asl
			and	#%11000000
			ora	PLTEMP
			sta	($FD),y
			iny
			cpy	#$08
			bne	PLC02	
			rts

PLD01:		lda	($FD),y		//Get existing pixels
			and	#%11000000
			sta	PLTEMP
			lda	($FB),y
			//ror
			//ror
			and	#%00111111
			ora	PLTEMP
			sta	($FD),y
			iny
			cpy	#$08
			bne	PLD01	
			rts


PLTEMP:		.byte	$00

GFX_ON:		
		lda	$D018
		ora	#$08
		sta	$D018	//SET BITMAP LOCATION TO $2000
		lda	$D011
		ora	#$20
		sta	$D011
		rts

GFX_OFF:	lda	$D011
		and	#$DF
		sta	$D011
		lda	#$15
		sta	$D018
		rts

CLRSCN:
		ldy	#$00
		lda	#%00000011

CLR01:		
		sta	$0400,y		//clear colors to white on black
		sta	$0500,y
		sta	$0600,y
		sta	$0700,y
		iny
		cpy	#$00
		bne	CLR01
		lda	#%10101010
		ldy	#$0
CLR02:	sta	$2000,y
		sta	$2100,y
		sta	$2200,y
		sta	$2300,y
		sta	$2400,y
		sta	$2500,y
		sta	$2600,y
		sta	$2700,y
		sta	$2800,y
		sta	$2900,y
		sta	$2A00,y
		sta	$2B00,y
		sta	$2C00,y
		sta	$2D00,y
		sta	$2E00,y
		sta	$2F00,y
		sta	$3000,y
		sta	$3100,y
		sta	$3200,y
		sta	$3300,y
		sta	$3400,y
		sta	$3500,y
		sta	$3600,y
		sta	$3700,y
		sta	$3800,y
		sta	$3900,y
		sta	$3A00,y
		sta	$3B00,y
		sta	$3C00,y
		sta	$3D00,y
		sta	$3E00,y
		sta	$3F00,y

		asl
		adc #0

		//adc #01
		iny
		cpy	#00
		bne	CLR02		
		rts

	//Multiply routine - ACC*AUX -> [ACC,EXT] (low,hi) 32 bit result 

MULT:	lda #0
	sta EXT2
	ldy #$11
	clc
MLOOP:	ror EXT2
	ror
	ror ACC2
	ror ACC
	bcc MUL2
	clc
	adc AUX
	pha
	lda AUX2
	adc EXT2
	sta EXT2
	pla
MUL2:	dey
	bne MLOOP
	sta EXT
	rts			

CHARSET_A:
	
	.import binary "../assets/champmanshift - Chars.bin"   //roll 12!

	// .byte %01110000 //CHAR=000 '@'
	// .byte %10001000
	// .byte %10111000
	// .byte %10110000
	// .byte %10000000
	// .byte %10000000
	// .byte %01110000
	// .byte %00000000

	// .byte %01110000 //CHAR=001 'a'
	// .byte %11011000
	// .byte %11011000
	// .byte %11111000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %00000000

	// .byte %11110000 //CHAR=002 'b'
	// .byte %11011000
	// .byte %11011000
	// .byte %11110000
	// .byte %11011000
	// .byte %11011000
	// .byte %11110000
	// .byte %00000000

	// .byte %01110000 //CHAR=003 'c'
	// .byte %11011000
	// .byte %11000000
	// .byte %11000000
	// .byte %11000000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %11110000 //CHAR=004 'd'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11110000
	// .byte %00000000

	// .byte %11111000 //CHAR=005 'e'
	// .byte %11000000
	// .byte %11000000
	// .byte %11110000
	// .byte %11000000
	// .byte %11000000
	// .byte %11111000
	// .byte %00000000

	// .byte %11111000 //CHAR=006 'f'
	// .byte %11000000
	// .byte %11000000
	// .byte %11110000
	// .byte %11000000
	// .byte %11000000
	// .byte %11000000
	// .byte %00000000

	// .byte %01110000 //CHAR=007 'g'
	// .byte %11011000
	// .byte %11000000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %11011000 //CHAR=008 'h'
	// .byte %11011000
	// .byte %11011000
	// .byte %11111000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %00000000

	// .byte %01111000 //CHAR=009 'i'
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %01111000
	// .byte %00000000

	// .byte %01111000 //CHAR=010 'j'
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %11100000
	// .byte %00000000

	// .byte %11011000 //CHAR=011 'k'
	// .byte %11011000
	// .byte %11110000
	// .byte %11100000
	// .byte %11110000
	// .byte %11011000
	// .byte %11011000
	// .byte %00000000

	// .byte %11000000 //CHAR=012 'l'
	// .byte %11000000
	// .byte %11000000
	// .byte %11000000
	// .byte %11000000
	// .byte %11000000
	// .byte %11111000
	// .byte %00000000

	// .byte %10001000 //CHAR=013 'm'
	// .byte %11011000
	// .byte %11111000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %00000000

	// .byte %10011000 //CHAR=014 'n'
	// .byte %11011000
	// .byte %11111000
	// .byte %11111000
	// .byte %11111000
	// .byte %11011000
	// .byte %11001000
	// .byte %00000000

	// .byte %01110000 //CHAR=015 'o'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %11110000 //CHAR=016 'p'
	// .byte %11011000
	// .byte %11011000
	// .byte %11110000
	// .byte %11000000
	// .byte %11000000
	// .byte %11000000
	// .byte %00000000

	// .byte %01110000 //CHAR=017 'q'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %01111100
	// .byte %00000000

	// .byte %11110000 //CHAR=018 'r'
	// .byte %11011000
	// .byte %11011000
	// .byte %11110000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %00000000

	// .byte %01110000 //CHAR=019 's'
	// .byte %11011000
	// .byte %11000000
	// .byte %01110000
	// .byte %00011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %01111000 //CHAR=020 't'
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00000000

	// .byte %11011000 //CHAR=021 'u'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %11011000 //CHAR=022 'v'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00100000
	// .byte %00000000

	// .byte %11011000 //CHAR=023 'w'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11111000
	// .byte %11011000
	// .byte %10001000
	// .byte %00000000

	// .byte %11011000 //CHAR=024 'x'
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %00000000

	// .byte %11011000 //CHAR=025 'y'
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %01100000
	// .byte %01100000
	// .byte %01100000
	// .byte %00000000

	// .byte %11111000 //CHAR=026 'z'
	// .byte %00011000
	// .byte %00110000
	// .byte %01100000
	// .byte %01100000
	// .byte %11000000
	// .byte %11111000
	// .byte %00000000

	// .byte %01111000 //CHAR=027 '['
	// .byte %01100000
	// .byte %01100000
	// .byte %01100000
	// .byte %01100000
	// .byte %01100000
	// .byte %01111000
	// .byte %00000000

	// .byte %00000000 //CHAR=028 ' '
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000

	// .byte %01111000 //CHAR=029 ']'
	// .byte %00011000
	// .byte %00011000
	// .byte %00011000
	// .byte %00011000
	// .byte %00011000
	// .byte %01111000
	// .byte %00000000

	// .byte %00000000 //CHAR=030 ' '
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000

	// .byte %00000000 //CHAR=031 ' '
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000

	// .byte %00000000 //CHAR=032 ' '
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000

	// .byte %00110000 //CHAR=033 '!'
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00000000
	// .byte %00110000
	// .byte %00000000

	// .byte %01101100 //CHAR=034 '"'
	// .byte %01101100
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000

	// .byte %01001000 //CHAR=035 '#'
	// .byte %11111100
	// .byte %01001000
	// .byte %01001000
	// .byte %01001000
	// .byte %11111100
	// .byte %01001000
	// .byte %00000000

	// .byte %00100000 //CHAR=036 '$'
	// .byte %01110000
	// .byte %11000000
	// .byte %01110000
	// .byte %00001000
	// .byte %01110000
	// .byte %00100000
	// .byte %00000000

	// .byte %11001000 //CHAR=037 '%'
	// .byte %00001000
	// .byte %00010000
	// .byte %00100000
	// .byte %01000000
	// .byte %10000000
	// .byte %10011000
	// .byte %00000000

	// .byte %00000000 //CHAR=038 '&'
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000

	// .byte %00110000 //CHAR=039 '''
	// .byte %01100000
	// .byte %10000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000

	// .byte %00011000 //CHAR=040 '('
	// .byte %00110000
	// .byte %01100000
	// .byte %01100000
	// .byte %01100000
	// .byte %00110000
	// .byte %00011000
	// .byte %00000000

	// .byte %01100000 //CHAR=041 ')'
	// .byte %00110000
	// .byte %00011000
	// .byte %00011000
	// .byte %00011000
	// .byte %00110000
	// .byte %01100000
	// .byte %00000000

	// .byte %00000000 //CHAR=042 '*'
	// .byte %10101000
	// .byte %01110000
	// .byte %00100000
	// .byte %01110000
	// .byte %10101000
	// .byte %00000000
	// .byte %00000000

	// .byte %00000000 //CHAR=043 '+'
	// .byte %00110000
	// .byte %00110000
	// .byte %01111000
	// .byte %00110000
	// .byte %00110000
	// .byte %00000000
	// .byte %00000000

	// .byte %00000000 //CHAR=044 ','
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00110000
	// .byte %00110000
	// .byte %01100000

	// .byte %00000000 //CHAR=045 '-'
	// .byte %00000000
	// .byte %00000000
	// .byte %11111000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000

	// .byte %00000000 //CHAR=046 '.'
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %01100000
	// .byte %01100000
	// .byte %00000000

	// .byte %00011000 //CHAR=047 '/'
	// .byte %00011000
	// .byte %00110000
	// .byte %01100000
	// .byte %01100000
	// .byte %11000000
	// .byte %11000000
	// .byte %00000000

	// .byte %01110000 //CHAR=048 '0'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %00110000 //CHAR=049 '1'
	// .byte %01110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %01111000
	// .byte %00000000

	// .byte %01110000 //CHAR=050 '2'
	// .byte %11011000
	// .byte %00011000
	// .byte %00110000
	// .byte %01100000
	// .byte %11011000
	// .byte %11111000
	// .byte %00000000

	// .byte %11110000 //CHAR=051 '3'
	// .byte %00011000
	// .byte %00011000
	// .byte %01110000
	// .byte %00011000
	// .byte %00011000
	// .byte %11110000
	// .byte %00000000

	// .byte %11011000 //CHAR=052 '4'
	// .byte %11011000
	// .byte %11011000
	// .byte %11111000
	// .byte %00011000
	// .byte %00011000
	// .byte %00011000
	// .byte %00000000

	// .byte %11111000 //CHAR=053 '5'
	// .byte %11000000
	// .byte %11000000
	// .byte %11110000
	// .byte %00011000
	// .byte %00011000
	// .byte %11110000
	// .byte %00000000

	// .byte %01110000 //CHAR=054 '6'
	// .byte %11011000
	// .byte %11000000
	// .byte %11110000
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %11111000 //CHAR=055 '7'
	// .byte %00011000
	// .byte %00110000
	// .byte %00110000
	// .byte %01100000
	// .byte %01100000
	// .byte %11000000
	// .byte %00000000

	// .byte %01110000 //CHAR=056 '8'
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %01110000 //CHAR=057 '9'
	// .byte %11011000
	// .byte %11011000
	// .byte %01111000
	// .byte %00011000
	// .byte %00110000
	// .byte %11100000
	// .byte %00000000

	// .byte %00000000 //CHAR=058 ':'
	// .byte %00000000
	// .byte %00110000
	// .byte %00000000
	// .byte %00000000
	// .byte %00110000
	// .byte %00000000
	// .byte %00000000

	// .byte %00000000 //CHAR=059 '//'
	// .byte %00000000
	// .byte %00110000
	// .byte %00000000
	// .byte %00000000
	// .byte %00110000
	// .byte %00110000
	// .byte %01100000

	// .byte %00011000 //CHAR=060 '<'
	// .byte %00110000
	// .byte %01100000
	// .byte %11000000
	// .byte %01100000
	// .byte %00110000
	// .byte %00011000
	// .byte %00000000

	// .byte %00000000 //CHAR=061 '='
	// .byte %00000000
	// .byte %01111000
	// .byte %00000000
	// .byte %01111000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000

	// .byte %11000000 //CHAR=062 '>'
	// .byte %01100000
	// .byte %00110000
	// .byte %00011000
	// .byte %00110000
	// .byte %01100000
	// .byte %11000000
	// .byte %00000000

	// .byte %01110000 //CHAR=063 '?'
	// .byte %11011000
	// .byte %00011000
	// .byte %00110000
	// .byte %00110000
	// .byte %00000000
	// .byte %00110000
	// .byte %00000000

	// .byte %00000000 //CHAR=064 ' '
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000
	// .byte %00000000

	// .byte %01110000 //CHAR=065 'A'
	// .byte %11011000
	// .byte %11011000
	// .byte %11111000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %00000000

	// .byte %11110000 //CHAR=066 'B'
	// .byte %11011000
	// .byte %11011000
	// .byte %11110000
	// .byte %11011000
	// .byte %11011000
	// .byte %11110000
	// .byte %00000000

	// .byte %01110000 //CHAR=067 'C
	// .byte %11011000
	// .byte %11000000
	// .byte %11000000
	// .byte %11000000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %11110000 //CHAR=068 'D'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11110000
	// .byte %00000000

	// .byte %11111000 //CHAR=069 'E'
	// .byte %11000000
	// .byte %11000000
	// .byte %11110000
	// .byte %11000000
	// .byte %11000000
	// .byte %11111000
	// .byte %00000000

	// .byte %11111000 //CHAR=070 'F'
	// .byte %11000000
	// .byte %11000000
	// .byte %11110000
	// .byte %11000000
	// .byte %11000000
	// .byte %11000000
	// .byte %00000000

	// .byte %01110000 //CHAR=071 'G'
	// .byte %11011000
	// .byte %11000000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %11011000 //CHAR=072 'H'
	// .byte %11011000
	// .byte %11011000
	// .byte %11111000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %00000000

	// .byte %01111000 //CHAR=073 'I'
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %01111000
	// .byte %00000000

	// .byte %01111000 //CHAR=074 'J'
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %11100000
	// .byte %00000000

	// .byte %11011000 //CHAR=075 'K'
	// .byte %11011000
	// .byte %11110000
	// .byte %11100000
	// .byte %11110000
	// .byte %11011000
	// .byte %11011000
	// .byte %00000000

	// .byte %11000000 //CHAR=076 'L'
	// .byte %11000000
	// .byte %11000000
	// .byte %11000000
	// .byte %11000000
	// .byte %11000000
	// .byte %11111000
	// .byte %00000000

	// .byte %10001000 //CHAR=077 'M'
	// .byte %11011000
	// .byte %11111000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %00000000

	// .byte %10011000 //CHAR=078 'N'
	// .byte %11011000
	// .byte %11111000
	// .byte %11111000
	// .byte %11111000
	// .byte %11011000
	// .byte %11001000
	// .byte %00000000

	// .byte %01110000 //CHAR=079 'O'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %11110000 //CHAR=080 'P'
	// .byte %11011000
	// .byte %11011000
	// .byte %11110000
	// .byte %11000000
	// .byte %11000000
	// .byte %11000000
	// .byte %00000000

	// .byte %01110000 //CHAR=081 'Q'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %01111100
	// .byte %00000000

	// .byte %11110000 //CHAR=082 'R'
	// .byte %11011000
	// .byte %11011000
	// .byte %11110000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %00000000

	// .byte %01110000 //CHAR=083 'S'
	// .byte %11011000
	// .byte %11000000
	// .byte %01110000
	// .byte %00011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %01111000 //CHAR=084 'T'
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00110000
	// .byte %00000000

	// .byte %11011000 //CHAR=085 'U'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00000000

	// .byte %11011000 //CHAR=086 'V'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %00100000
	// .byte %00000000

	// .byte %11011000 //CHAR=087 'W'
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %11111000
	// .byte %11011000
	// .byte %10001000
	// .byte %00000000

	// .byte %11011000 //CHAR=088 'X'
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %11011000
	// .byte %11011000
	// .byte %11011000
	// .byte %00000000

	// .byte %11011000 //CHAR=089 'Y'
	// .byte %11011000
	// .byte %11011000
	// .byte %01110000
	// .byte %01100000
	// .byte %01100000
	// .byte %01100000
	// .byte %00000000

	// .byte %11111000 //CHAR=090 'Z'
	// .byte %00011000
	// .byte %00110000
	// .byte %01100000
	// .byte %01100000
	// .byte %11000000
	// .byte %11111000
	// .byte %00000000


PLCHART:
	.byte $00,$01,$02,$03
	.byte $00,$01,$02,$03
	.byte $00,$01,$02,$03
	.byte $00,$01,$02,$03
	.byte $00,$01,$02,$03
	.byte $00,$01,$02,$03
	.byte $00,$01,$02,$03
	.byte $00,$01,$02,$03
	.byte $00,$01,$02,$03
	.byte $00,$01,$02,$03
	.byte $00,$01,$02,$03
	.byte $00,$01,$02,$03
	.byte $00,$01,$02,$03

COLCHART:
	.byte 00,00,01,02
	.byte 03,03,04,05
	.byte 06,06,07,08
	.byte 09,09,10,11
	.byte 12,12,13,14
	.byte 15,15,16,17
	.byte 18,18,19,20
	.byte 21,21,22,23
	.byte 24,24,25,26
	.byte 27,27,28,29
	.byte 30,30,31,32
	.byte 33,33,34,35
	.byte 36,36,37,38
	.byte 39,39

ROWCHART_L:
	.byte $00	// Row 00
	.byte $40	// Row 01
	.byte $80	// Row 02
	.byte $C0	// Row 03
	.byte $00	// Row 04
	.byte $40	// Row 05
	.byte $80	// Row 06
	.byte $C0	// Row 07
	.byte $00	// Row 08
	.byte $40	// Row 09
	.byte $80	// Row 10
	.byte $C0	// Row 11
	.byte $00	// Row 12
	.byte $40	// Row 13
	.byte $80	// Row 14
	.byte $C0	// Row 15
	.byte $00	// Row 16
	.byte $40	// Row 17
	.byte $80	// Row 18
	.byte $C0	// Row 19
	.byte $00	// Row 20
	.byte $40	// Row 21
	.byte $80	// Row 22
	.byte $C0	// Row 23
	.byte $00	// Row 24

ROWCHART_H:
	.byte $20	// Row 00
	.byte $21	// Row 01
	.byte $22	// Row 02
	.byte $23	// Row 03
	.byte $25	// Row 04
	.byte $26	// Row 05
	.byte $27	// Row 06
	.byte $28	// Row 07
	.byte $2A	// Row 08
	.byte $2B	// Row 09
	.byte $2C	// Row 10
	.byte $2D	// Row 11
	.byte $2F	// Row 12
	.byte $30	// Row 13
	.byte $31	// Row 14
	.byte $32	// Row 15
	.byte $34	// Row 16
	.byte $35	// Row 17
	.byte $36	// Row 18
	.byte $37	// Row 19
	.byte $39	// Row 20
	.byte $3A	// Row 21
	.byte $3B	// Row 22
	.byte $3C	// Row 23
	.byte $3E	// Row 24



}