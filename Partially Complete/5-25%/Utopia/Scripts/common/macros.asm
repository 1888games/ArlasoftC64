	*=* "---Macros"

ShowDebug: .byte 0

.macro Storestate() {

	pha // A
	txa
	pha // X
	tya
	pha // Y

}

.macro Restorestate() {

	pla // Y
	tay
	pla // X
	tax
	pla // A

}

.macro SetDebugBorder(value) {

	lda ShowDebug
	beq Finish

	lda #value
	sta $d020

	Finish:
}