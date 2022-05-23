
.macro sfx(sfx_id)
{		
		:StoreState()

		ldx #sfx_id
		//jsr sfx_play

		

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
	sfx_routine:
			jmp play_with_music
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


.label SFX_COLLECT = 0
.label SFX_FIRE = 1
.label SFX_GRUNT = 2

.label SFX_COMPLETE = 3
.label SFX_ALARM = 4
.label SFX_ENEMY = 5



channels:	.byte 0, 1, 2


sfx_1: .import binary "../../Assets/collect.sfx"
sfx_2: .import binary "../../Assets/fire.sfx"
sfx_3: .import binary "../../Assets/hitgrunt.sfx"


sfx_4: .import binary "../../Assets/complete.sfx"
sfx_5: .import binary "../../Assets/alarm.sfx"
sfx_6: .import binary "../../Assets/enemy.sfx"


//.import binary "../../Assets/sfx/high_blip.sfx"





wavetable_l:
.byte <sfx_1, <sfx_2, <sfx_3, <sfx_4, <sfx_5, <sfx_6

wavetable_h:
.byte >sfx_1, >sfx_2, >sfx_3, >sfx_4, >sfx_5, >sfx_6

