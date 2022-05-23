

.var ShowDebug = 0

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

	.if (ShowDebug == 1) {

	lda #value
	sta $d020

	}

}