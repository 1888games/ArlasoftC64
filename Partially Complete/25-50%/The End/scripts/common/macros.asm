* = * "-Macros"

ShowDebug: .byte 1

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


.macro BASICStub65(Entry,Message)
{

		
			.pc = $2001 "BASIC Stub"	
			

			
			.byte 0									// Start of BASIC program
			.word nextline							// Pointer to next BASIC line (Lo/Hi)
			.word 0									// Line number
			.byte $9e								// 'SYS'
			.fill 4, toIntString(begin,4).charAt(i)	// Address of 'begin' as numeric string
			.word $8f3a								// Colon and 'REM'
			.fill 13,$14							// {DEL} control characters to hide start of BASIC line
			.text Message						// Message for LIST
			.byte 0									// End of BASIC line
nextline:	.word 0									// End of BASIC program
begin:		.pc = * "Entry"						// Start of 6502 code
}