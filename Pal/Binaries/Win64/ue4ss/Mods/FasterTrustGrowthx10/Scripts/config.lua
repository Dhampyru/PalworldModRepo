-- made by caites

local palConfig = {

    serverAcknowledgedPossession = false,

    -- Change those for new mod or different version
    palModName = "FasterTrustGrowth",
    palModVersion = "1.0",
    palGameVersion = "0.6.0.75",

    -- Those are generic for every mod
    palCheckRestart = 0,
    palRedColorWrapperFront = "\27[31m",
    palRedColorWrapperBack = "\27[0m\n",

	-- default is 10
	FriendshipPoint_AutoIncrementInteravalMinutes = 1,

    -- default is 10
	FriendshipPoint_AutoIncrementOtomo = 10,
	
	-- default is 50
	FriendshipPoint_AutoIncrementActiveOtomo = 50,
	
	-- default is 1
	FriendshipPoint_AutoIncrementWorker = 1,
	
	-- default is 30
	FriendshipPoint_Petting = 300,
		
	-- default is 100
	FriendshipPoint_SleepOnSide = 1000

}
return palConfig
