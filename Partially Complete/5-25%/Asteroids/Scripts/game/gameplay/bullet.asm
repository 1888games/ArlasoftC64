		CalcXThrust: 

			L77D2:  clc                     //Adding #$40 to ship/bullet direction will set MSB if facing left.
			L77D3:  adc #$40                //

		CalcThrustDir:
			L77D5:  bpl GetVelocityVal      //Is ship/saucer bullet facing right/up? If so, branch.

			L77D7:  and #$7F                //Ship/saucer bullet is facing left/down. Clear direction MSB.
			L77D9:  jsr GetVelocityVal      //($77DF)Get ship/saucer bullet velocity for this XY component.
			L77DC:  jmp TwosCompliment      //($7708)Calculate the 2's compliment of the value in A.

		GetVelocityVal:
			L77DF:  cmp #$41                //Is ship/saucer bullet facing right/up?
			L77E1:  bcc LookupThrustVal     //If so, branch.

			L77E3:  adc #$7F                //Ship/saucer bullet is facing left/down. Need to lookup-->
			L77E5:  adc #$00                //table in reverse order.

		LookupThrustVal:
			L77E7:  tax                     //
			L77E8:  lda ThrustTbl,X         //Get velocity value from lookup table.
			L77EB:  rts                     //

