SAVE: {

	.if (d64 == true) {


 	//.segment SaveFile
		.segment SaveFile [outPrg="funfair save 7"]

		// .disk [filename="MyDisk.d64", name="THE DISK", id="2021!" ]
		// {

		// [name="----------------", type="rel"                            ],
		// [name="FUNFAIR         ", type="prg",  segments="Default" ],
		// [name="DATA            ", type="seq<", segments="SaveFile"   ],


		//}
	}

 * = $4000 "SAVED GAME"
 * = $4000 "---Park Map"

   Map: { 
 	.import binary "../assets/theme9 - MapArea (8bpc, 124x64).bin"
	}

 * = * "---Game Data"

 	Bus: {

 		XTile:			.byte 120
 		Capacity:		.byte 4
 		Passengers:		.byte 0
 		AtStop:			.byte 0

 	}


 	Cash: {
 					// M  HT TT T  H  T  U
 		Balance: 			.byte 0, 5, 0, 0, 0, 0, 0
 		Inflation:			.byte 0
 		Loan:	 			.byte 0, 5
 		MaxLoanLevel:		.byte 2
 		LoanLevel:			.byte 1
 		InterestRate:		.byte 10
 		WageInflation:		.byte 0
 		StockInflation:		.byte 0


 	}

 	Research: {

 		// in tens
	 	Budget:				.byte 1, 1, 1, 1
	 	AmountPerSegment:	.byte 5, 6, 7, 10
	 	SegmentProgress:	.byte 0, 0, 0, 0		
	 	ProgressBar:		.byte 1, 7, 3, 2
	 	//ProgressBar:		.byte 99, 99, 99, 99
 		TotalBudget:		.byte 4
 		NextFacilityType:	.byte 0

 	}

 	Calendar: {

 		Day:		.byte 1
		Month:		.byte 0
		Speed:		.byte 1
		Year:		.byte 0
 	}

 	Choose: {

 		CategoryStart: 		.byte 0, 32, 52, 68, 72
 		CategoryEnd:		.byte 28, 34, 55, 69
 		//CategoryEnd:		.byte 31, 51, 67, 72
 	}


 	Park: {

 		Open:			.byte 0
 		Name:			.text "the funfair         "
 		Guests:			.byte 0
 		TicketPrice:	.byte 30
 		Value:			.byte 0, 0, 0, 2, 5, 0, 0
 		Size:			.byte 0, 0
 		Pleasantness:	.byte 100

 	}


 	 * = * "----Warehouse"

 	Warehouse: {

 		Delivery:		.byte 60
 		Capacity:		.byte 50
 		OnOrder:		.fill 13, 0
 		Remaining:		.fill 13, 35


 	 	* = * "----DaysLeft"

 		DaysLeft:		.byte 255


 	}

 	Game: {

 		Level:			.byte 0
 		Fussiness:		.byte 0

 	}



 	TileMap: {


 		Row_00:		.fill 31, 255
 		Row_01:		.fill 31, 255
 		Row_02:		.fill 31, 255
 		Row_03:		.fill 31, 255
 		Row_04:		.fill 31, 255
 		Row_05:		.fill 31, 255
 		Row_06:		.fill 31, 255
 		Row_07:		.fill 31, 255
 		Row_08:		.fill 31, 255
 		Row_09:		.fill 31, 255
 		Row_10:		.fill 31, 255
 		Row_11:		.fill 31, 255
 		Row_12:		.fill 31, 255
 	
 	}

 	Objects: {

 		// space in these for other flags?

 		PosX:			.fill 128, 0
 		PosY:			.fill 128, 0
 		Data_1:			.fill 128, 0
 		Data_2:			.fill 128, 0
 		Data_3:			.fill 128, 0  // for rides = current load
 		Customers:		.fill 128, 0
 		IDs:			.fill 128, 0
 		NextID:			.byte 0


 		.label RideStatus = Data_3
 		.label SpeedTime = Data_1
 		.label Condition = Data_2
 		.label Feeding = Data_1
 		.label Price = Data_1
 		.label PrizeValue = Data_2
 		.label ShopSetting = Data_2


 	}

 	People: {

 		// upper bytes available for being sick, dropping rubbish etc.?

 		 * = * "----People"
 		 * = * "-----PosX"
 		PosX:				.fill PEOPLE.MaxPeeps, 0
 		PosY:				.fill PEOPLE.MaxPeeps, 0
		OldPosX:			.fill PEOPLE.MaxPeeps, 0
		OldPosY:			.fill PEOPLE.MaxPeeps, 0
		PersonType:			.fill PEOPLE.MaxPeeps, %11110010

		 * = * "-----Status"

		Status:				.fill PEOPLE.MaxPeeps, PERSON_STATUS_WALK + PERSON_STATUS_WALK_UP
		Mental:				.fill PEOPLE.MaxPeeps, %01000100
		MoneyLeft_LSB:		.fill PEOPLE.MaxPeeps, 255
		MoneyLeft_MSB:		.fill PEOPLE.MaxPeeps, 255
		NextPersonID:		.byte 0
		LastObjectID:		.byte PEOPLE.MaxPeeps, 255
		TargetX:			.fill PEOPLE.MaxPeeps, 0
		TargetY:			.fill PEOPLE.MaxPeeps, 0

		.label RideID = OldPosX
		.label RideTimeLeft = OldPosY
		.label StaffType = Mental
		.label Actions = MoneyLeft_MSB
		

		// UseOldPosX for the ride you are on?
		// UseOldPosY for the time left on ride?

		//Mental:	// 			Angry Toilet Tiredness Thirst


		// Person Type

		// x x COLOUR TYPE   x x 0-7 


	
 	}


 	Fire: {

 		ObjectIDs: 			.fill 9, 255
 		NumberOfObjects:	.byte 0
 	}


 	.segment Default
 



}