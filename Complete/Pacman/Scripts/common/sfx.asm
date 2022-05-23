.label SFX_KIT_INIT = $7000
.label SFX_KIT_OFF = $7010
.label SFX_KIT_IRQ = $7028
.label SFX_KIT_CLR = $71F9

.label SOUND_ENERGIZER = 1
.label SOUND_RETREAT = 2


.macro sfx(sfx_id)
{		

		:StoreState()

		ldx #sfx_id
		jsr sfx_play

		

		:RestoreState()
}

.macro sfxFromA() {

		:StoreState()

		tax	
		jsr sfx_play

		:RestoreState()

}

* = * "-Sound"

music_on: .byte 0
channel:	.byte 0
current_waka:	.byte 0
cooldown:		.byte 0
mode:			.byte 0


PlayEnergizer: {

	lda GAME.AttractMode
	bne Finish

	//jsr SFX_KIT_INIT
	jsr SFX_KIT_CLR

	lda #SOUND_ENERGIZER
	sta 679

	Finish:

	rts


}

PlaySong: {

	lda #0





	rts
}


PlayRetreat: {

	lda GAME.AttractMode
	bne Finish

	jsr SFX_KIT_CLR

	lda #SOUND_RETREAT
	sta 679


	Finish:

	rts




}


PlayWaka: {

	:StoreState()

	ldx current_waka
	
	lda current_waka
	eor #%00000001
	sta current_waka

	lda #20
	sta cooldown

	jsr sfx_play
	:RestoreState()


}

WakaUpdate: {

	lda cooldown
	beq Ready

	dec cooldown
	rts

	Ready:

	lda #0
	sta current_waka


	rts
}

set_sfx_routine:
{


			lda music_on
			bne !on+
			
			lda #<play_no_music
			sta sfx_play.sfx_routine + 1
			
			lda #>play_no_music
			sta sfx_play.sfx_routine + 2
			rts
			
		!on:
			lda #<play_with_music
			sta sfx_play.sfx_routine + 1
			
			lda #>play_with_music
			sta sfx_play.sfx_routine + 2
			rts	
}

sfx_play:
{			
			lda GAME.AttractMode
			bne NoSound
	sfx_routine:
			jmp play_with_music

			NoSound:
				rts
}


//when sid is not playing, we can use any of the channels to play effects
play_no_music:
{			
			lda channels, x
			sta channel

			//lda channel
		//	cmp #3
		//	bne NoWrap

		//	lda #0
		//	sta channel
		//NoWrap:
			
			lda wavetable_l,x
			ldy wavetable_h,x
			ldx channel
			pha
			lda times7,x
			tax
			pla
			jmp sid.init + 6			
			

times7:
.fill 3, 7 * i			
}


play_with_music:
{
			lda wavetable_l,x
			ldy wavetable_h,x
			ldx #7 * 2
			jmp sid.init + 6
			rts
}


StopChannel0: {

	lda #0
	sta $d404

	rts


}




//effects must appear in order of priority, lowest priority first.

.label SFX_WA = 0
.label SFX_KA = 1
.label SFX_BEEP = 2
.label SFX_COIN = 3
.label SFX_FRUIT = 4
.label SFX_EAT = 5
.label SFX_DEAD = 6
.label SFX_EXTRA = 7



channels:	.byte 1, 2, 1, 2, 1, 2, 1

sfx_1: .import binary "../../Assets/sfx/pac_wa.sfx"  // 0
sfx_2: .import binary "../../Assets/sfx/pac_ka.sfx" // 1
sfx_3: .import binary "../../Assets/sfx/pac_beep.sfx"
sfx_4: .import binary "../../Assets/sfx/pac_coin2.sfx"
sfx_5: .import binary "../../Assets/sfx/pac_fruit.sfx"
sfx_6: .import binary "../../Assets/sfx/pac_eat.sfx"
sfx_7: .import binary "../../Assets/sfx/pac_dead.sfx"


//.import binary "../../Assets/sfx/high_blip.sfx"





wavetable_l:
.byte <sfx_1, <sfx_2, <sfx_3, <sfx_4, <sfx_5, <sfx_6, <sfx_7

wavetable_h:
.byte >sfx_1, >sfx_2, >sfx_3, >sfx_4, >sfx_5, >sfx_6, >sfx_7

