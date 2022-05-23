MOUSE:{


	*=* "---Mouse"


	.label MinX = 32
	.label MaxX = 73
	.label MinY = 55
	.label MaxY = 244
	.label MaxMoveSpeed = 5
	.label SpriteFrame = 17
	.label MinMoveSpeed = 1
	.label MouseStartX = 60
	.label MouseStartY = 100
	.label DoubleClickTime = 12


	SpriteColours:	.byte ORANGE, GRAY, LIGHT_RED, LIGHT_RED
	SpritePointers:	.byte 17, 18, 18, 20


	Initialise: {

		lda #SpriteFrame
		sta SPRITE_POINTERS

		lda #ORANGE
		sta VIC.SPRITE_COLOR_0

		lda VIC.SPRITE_ENABLE
		ora #%00000001
		sta VIC.SPRITE_ENABLE

		lda #0
		sta Mouse.Mode
		sta Mouse.PosX_MSB
		sta Mouse.DoubleClickTimer
		sta Mouse.DoubleClicked
		sta Mouse.CharX
		sta Mouse.CharY
		sta Mouse.AnyMove
		sta Mouse.IsReal

		lda #4
		sta Mouse.MoveSpeed

		lda #MouseStartX
		sta Mouse.PosX_LSB

		lda #MouseStartY
		sta Mouse.PosY

		jsr SetPosition

		rts

	}



	

	SetPosition: {

		lda Mouse.PosX_LSB
		sta VIC.SPRITE_0_X

		lda Mouse.PosY
		sta VIC.SPRITE_0_Y


		lda Mouse.PosX_MSB
		bne MSB_On

		MSB_Off:

			lda VIC.SPRITE_MSB
			and #%11111110
			jmp Finish


		MSB_On:

			lda VIC.SPRITE_MSB
			ora #%00000001

		

		Finish:

		sta VIC.SPRITE_MSB

		rts


	}

	SetSprite: {

		ldx Mouse.Mode
		cpx #MOUSE_INVISIBLE
		bne PointerVisible

		lda #0
		sta VIC.SPRITE_0_Y

		PointerVisible:

		lda SpriteColours, x
		sta VIC.SPRITE_COLOR_0

		lda MAIN.GameMode
		cmp #GAME_MODE_TITLE
		bne Bank3

		Bank1:

		lda #160
		sta TITLE_POINTERS
		rts

		Bank3:

		lda SpritePointers, x
		sta SPRITE_POINTERS


		rts
	}



	Update: {

		jsr SetSprite


		lda Mouse.Mode
		cmp #MOUSE_INVISIBLE
		bne NotInvisible

		jmp Finish

		NotInvisible:

		lda Mouse.IsReal
		beq UseJoystick

		UseMouse:

		//	jsr Update1351
			jmp NoReset


	
		UseJoystick:

			SetDebugBorder(15)

			lda Mouse.DoubleClickTimer
			beq NoReduce

			dec Mouse.DoubleClickTimer

		NoReduce:

		lda #0
		sta Mouse.AnyMove
		sta Mouse.DoubleClicked

		lda Mouse.MoveSpeed
		cmp #MaxMoveSpeed
		bcc Okay

		lda #MaxMoveSpeed
		sta Mouse.MoveSpeed


		Okay:


		lda #ZERO
		sta Mouse.CharX
		sta Mouse.CharY

		ldy #1

		CheckLeft:
	
			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			sty Mouse.AnyMove

			lda Mouse.PosX_LSB
			sec
			sbc Mouse.MoveSpeed
			sta Mouse.PosX_LSB

			lda Mouse.PosX_MSB
			sbc #00
			sta Mouse.PosX_MSB

			bpl MSBValid

			lda #0
			sta Mouse.PosX_MSB

			MSBValid:

			inc Mouse.MoveSpeed

			lda Mouse.PosX_MSB
			bne CheckDown

			CheckLeftEdge:

				lda Mouse.PosX_LSB
				cmp #MinX
				bcs CheckDown

				lda #MinX
				sta Mouse.PosX_LSB

				MoveMap:

				jsr MAP.MoveLeft
				jmp CheckFire


		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

			sty Mouse.AnyMove


			lda Mouse.PosX_LSB
			clc
			adc Mouse.MoveSpeed
			sta Mouse.PosX_LSB

			lda Mouse.PosX_MSB
			adc #00
			sta Mouse.PosX_MSB

			inc Mouse.MoveSpeed

			lda Mouse.PosX_MSB
			beq CheckDown

			CheckRightEdge:

				lda Mouse.PosX_LSB
				cmp #MaxX
				bcc CheckDown

				lda #MaxX
				sta Mouse.PosX_LSB

				// lda MouseY
				// cmp #226
				// bcc MoveMap2

				// jmp CheckDown

				MoveMap2:

				jsr MAP.MoveRight
				jmp CheckFire
			

		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckUp

			sty Mouse.AnyMove

			lda Mouse.PosY
			clc
			adc Mouse.MoveSpeed
			sta Mouse.PosY
			
			inc Mouse.MoveSpeed

			cmp #MaxY

			bcc CheckFire

			lda #MaxY
			sta Mouse.PosY

			jsr MAP.MoveDown

			jmp CheckFire

		CheckUp:

			lda INPUT.JOY_UP_NOW, y
			beq CheckFire

			sty Mouse.AnyMove

		
			lda Mouse.PosY
			sec
			sbc Mouse.MoveSpeed
			sta Mouse.PosY

			inc Mouse.MoveSpeed

			cmp #MinY

			bcs CheckFire

			lda #MinY
			sta Mouse.PosY

			jsr MAP.MoveUp

		CheckFire:

			ldy #1
			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq NoFire

			lda Mouse.DoubleClickTimer
			beq NoDoubleClick

			cmp #80
			bcc NotPlacingSomething

			lda #0
			sta Mouse.DoubleClickTimer
			jmp DoubleClickHandled

			NotPlacingSomething:

			inc Mouse.DoubleClicked
			jmp DoubleClickHandled

			NoDoubleClick:


				lda #DoubleClickTime
				sta Mouse.DoubleClickTimer

			DoubleClickHandled:

			lda #0
			sta PATH.FireStillDown

			jsr CheckFirePosition


		NoFire:

			ldy #1
			lda INPUT.JOY_FIRE_NOW, y
			beq FireNotHeld

			lda #1
			sta Mouse.MoveSpeed

			FireNotHeld:

			lda Mouse.AnyMove
			bne NoReset

			lda #1
			sta Mouse.MoveSpeed

		NoReset:
		
		jsr SetPosition

		Finish:

		rts




	}


	ConvertMousePosToChars: {

		.label Adjust = CharOffset
		.label AddColumns = Amount

		lda #253
		sta Adjust

		lda #29
		sta AddColumns

		lda Mouse.PosX_MSB
		bne NoAdjust

		lda #24
		sta Adjust

		lda #0
		sta AddColumns

		NoAdjust:

		lda Mouse.PosX_LSB
		sec
		sbc Adjust

		lsr
		lsr
		lsr

		clc
		adc AddColumns


		sta Mouse.CharX
		
		lda Mouse.PosY
		sec
		sbc #50
		lsr
		lsr
		lsr

		sta Mouse.CharY
		
		rts
	}

	ConvertMousePosToTiles: {

		jsr ConvertMousePosToChars

		lda Object.Type
		cmp #3
		beq Finish

		lda Queue.Mode
		cmp #QUEUE_MODE_EXTEND
		beq Finish

		jsr ConvertMouseCharToTile

		Finish:

		rts

	}

	ConvertMouseCharToTile: {

	
		lda Mouse.CharX
		clc
		adc Map.OffsetX
		and #%11111100

		tax

		lda MAP.CharColumnToTileColumn, x
		sta Map.TileX

		txa
		sec
		sbc Map.OffsetX
		sta Mouse.CharX
		inc Mouse.CharX

		lda Mouse.CharY
		clc
		adc Map.OffsetY
		and #%11111100

		tax
		lda MAP.CharRowToTileRow, x
		sta Map.TileY

		txa
		sec
		sbc Map.OffsetY
		sta Mouse.CharY
		inc Mouse.CharY
		inc Mouse.CharY
		
		rts
	}

	CheckFirePosition: {

		jsr ConvertMousePosToChars

		lda MAIN.GameLoaded
		beq NotInHud

		lda Mouse.CharY
		cmp #22
		bcc NotInHud

		jsr HUD.HandleClick
		jmp Finish

		NotInHud:

		jsr UI.HandleClick

		Finish:

		rts
	}



	CalculateMouseCharPosition:  {

		lda Mouse.CharX
		clc
		adc Map.OffsetX
		adc #1
		sta MouseMapX

		lda Mouse.CharY
		clc
		adc Map.OffsetY
		sta MouseMapY

		rts

	}




oldx: .byte $00 
oldy: .byte $00 

.label leftbutton = $7a // 1 byte 
.label rightbutton = $7b // 1 byte 
.label deltax = $7c // 1 byte 
.label deltay = $7d // 1 byte 
.label buttonmask = $7e // 1 byte 
.label olddelta = $7e // 1 byte 
.label newdelta = $7f // 1 byte 
.label leftbuttonup = $8a
.label rightbuttonup = $8b
.label leftbuttonlast = $8c
.label rightbuttonlast = $8c

GetMouseState:

        //https://codebase64.org/doku.php?id=base:c_1351_standard_mouse_routine 

        lda leftbutton
        sta leftbuttonlast

        lda rightbutton
        sta rightbuttonlast	

        lda #0
        sta leftbuttonup
        sta rightbuttonup

        CheckLeftButton:

	        lda #%00010000 
	        jsr buttoncheck 
	        sta leftbutton 

	        bne CheckRightButton

        LeftButtonNotHeld:

	        lda leftbuttonlast
	        beq CheckRightButton

        LeftButtonUpThisFrame:

	        lda #1
	        sta leftbuttonup

        CheckRightButton:

	        lda #%00000001 
	        jsr buttoncheck
	        sta rightbutton

            bne CheckPosition

        RightButtonNotHeld:

	        lda rightbuttonlast
	        beq CheckPosition

        RightButtonUpThisFrame:

	        lda #1
	        sta rightbuttonup

	    CheckPosition:

	        lda $d419 
	        //lsr  //CCS64 fix (remove for other emus/real HW) 
	        ldy oldx 
	        jsr movecheck 
	        sty oldx 
	        sta deltax

	        lda $d41a 
	        //lsr  //CCS64 fix (remove for other emus/real HW) 
	        ldy oldy 
	        jsr movecheck 
	        sty oldy 
	        sec  // modify y position ( decrease y for increase in pot ) 
	        eor #$ff 
	        adc #$00 
	        sta deltay



        rts 


buttoncheck:
        sta buttonmask 

        lda $dc01 // port 1 
        and buttonmask 
        cmp buttonmask 

        bne SetBtn 
        lda #$00 
        rts 

SetBtn:
        lda #$01 
        rts 


movecheck:
        sty olddelta 
        sta newdelta 
        ldx #0 

        sec 
        sbc olddelta 
        and #%01111111 
        cmp #%01000000 
        bcs movchk1 
        lsr 
        beq movchk2 
        ldy newdelta 
        rts 

movchk1:
        ora #%11000000 
        cmp #$ff 
        beq movchk2 
        sec 
        ror 
        ldx #$ff 
        ldy newdelta 
        rts 
movchk2:
        lda #0 
        rts
	



}