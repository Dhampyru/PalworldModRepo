-- made by caites

local palConfig = {

    -- Change those for new mod or different version
    palModName = "Better Shields",
    palModVersion = "1.10",
    palGameVersion = "0.1.4.0",

    -- Those are generic for every mod
    palCheckRestart = 0,
    palRedColorWrapperFront = "\27[31m",
    palRedColorWrapperBack = "\27[0m\n",

    -- Delay before shield recovery, default is 25
	PlayerShield_RecoverStartTime = 10.0,
	
	-- Speed of shield recovery, default is 20
	PlayerShield_RecoverPercentPerSecond = 8.0

}
return palConfig
