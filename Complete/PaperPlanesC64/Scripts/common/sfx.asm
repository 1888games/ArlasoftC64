
.macro sfx(sfx_id)
{		
		:StoreState()

		ldx #sfx_id
		jsr sfx_play

		:RestoreState()
}

.macro sfxFromA() {

		sta ZP.SoundID

		:StoreState()

		ldx ZP.SoundID
		jsr sfx_play

		:RestoreState()

}

* = * "-Sound"

music_on: .byte 0
channel:	.byte 0
allow_channel_1: .byte 1

drone_delay:	.byte 255
drone_max:		.byte 255
dive_time:		.byte 255
diving_enemy:	.byte 255
dive_mode:		.byte 255

.label startDelay = 65




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

			bne NoOneCheck

			lda allow_channel_1
			bne NoOneCheck

			inc channel

			NoOneCheck:
			
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


StopChannel1: {

	lda #0
	sta $d40B
	rts
}







//effects must appear in order of priority, lowest priority first.


.label SFX_COLLECT = 0

.label SFX_POWER = 1

.label SFX_DEAD = 2

.label SFX_WARN = 3

.label SFX_HIGH = 4

channels:	.byte 0, 1, 1, 2, 1, 1, 2, 1, 0, 2, 2, 1, 1, 1

sfx_collect: .import binary "../../Assets/goattracker/high_blip.sfx"
sfx_power: .import binary "../../Assets/goattracker/double_high_tink.sfx"
sfx_dead: .import binary "../../Assets/goattracker/hit_hiss.sfx"
sfx_warn: .import binary "../../Assets/goattracker/noise_medium.sfx"
sfx_high: .import binary "../../Assets/goattracker/spring.sfx"
//.import binary "../../Assets/sfx/high_blip.sfx








wavetable_l:
.byte <sfx_collect, <sfx_power, <sfx_dead, <sfx_warn, <sfx_high

wavetable_h:
.byte >sfx_collect, >sfx_power, >sfx_dead, >sfx_warn, >sfx_high
