-- made by caites

local palConfig = {

    -- Change those for new mod or different version
    palModName = "Tuned Raids",
    palModVersion = "1.0",
    palGameVersion = "0.1.4.1",

    -- Those are generic for every mod
    palCheckRestart = 0,
    palRedColorWrapperFront = "\27[31m",
    palRedColorWrapperBack = "\27[0m\n",

    -- Raid probability, default is 0.8
	InvadeProbability = 0.8,
	
	-- Raids start from thos player's level, default is 5
	InvadeOccurablePlayerLevel = 2,
	
	-- Raid party spawn this far from the base min, default is 10000
	InvadeStartPoint_BaseCampRadius_Min_cm = 25000,
	
	-- Raid party spawn this far from the base max, default is 50000
	InvadeStartPoint_BaseCampRadius_Max_cm = 40000
	
	-- Minimum delay between raids, default is 30
	--InvadeCollTime_Min_Minutes = 0,
	
	-- Maximum delay between raids, default is 120
	--InvadeCollTime_Max_Minutes = 1

}
return palConfig
