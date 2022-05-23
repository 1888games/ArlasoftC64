CHOOSE: {


   Update: {

   		lda ZP.Timer
   		beq Ready

   		dec ZP.Timer
   		jmp MAIN.GameLoop

   		Ready:

   		lda #32
   		sta ZP.Timer

   		ldx #7

   		Loop:	

   			lda ZP.Counter
   			and #%00000001
   			sta COLOR_RAM, x
   			sta COLOR_RAM + 32, x

   			dex
   			bpl Loop


   		jmp MAIN.GameLoop
   }



	Control: {

   		cpx #0
   		beq TurnsDown

   		cpx #1
   		beq TurnsUp

   		cpx #2
   		beq TimeUp

	   	TimeDown:

	   		ldx #7
	   		ldy #3
	   		jmp MAIN.DecreaseScreenValue

	   	TimeUp:

	   		ldx #7
	   		ldy #3
	   		jmp MAIN.IncreaseScreenValue

	   	TurnsDown:

	   		ldx #39
	   		ldy #2
	   		jmp MAIN.DecreaseScreenValue

	   	TurnsUp:

	   		ldx #39
	   		ldy #2
	   		jmp MAIN.IncreaseScreenValue

	   	Finish:


   		rts 
   }




}