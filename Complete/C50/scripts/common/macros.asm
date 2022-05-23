* = * "-Macros"

.macro StoreState() {

	pha // A
	txa
	pha // X
	tya
	pha // Y

}

.macro RestoreState() {

	pla // Y
	tay
	pla // X
	tax
	pla // A

}

.macro SetDebugBorder(value) {

	.if(debug == true) {
	
		lda #value
		sta $d020

		Finish:
	}

}