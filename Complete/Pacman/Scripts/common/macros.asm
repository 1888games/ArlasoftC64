ShowDebug: .byte 0

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

	lda ShowDebug
	beq Finish

	lda #value
	sta $d020

	Finish:
}


.macro ReverseSign() {

	eor #$ff
	clc
	adc #1


}

.macro MovePointer(address, value) {

	lda address
	clc
	adc #value
	sta address
	bcc NoWrap

	inc address + 1

NoWrap:




}