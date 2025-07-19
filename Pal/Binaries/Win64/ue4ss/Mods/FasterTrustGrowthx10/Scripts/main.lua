-- made by caites

local palConfig = require "config"

-- Prints the mod successful loading message in red
print(palConfig.palRedColorWrapperFront .. palConfig.palModName .. " version " .. palConfig.palModVersion .. " loaded for game version " .. palConfig.palGameVersion .. palConfig.palRedColorWrapperBack)

-- Register the new modifiers and print a successful change message in red
RegisterHook("/Script/Engine.PlayerController:ClientRestart", function()
    if palConfig.palCheckRestart ~= 1 then
        local items = FindAllOf("PalGameSetting")
        if items then
            for _, item in ipairs(items) do                
				item.FriendshipPoint_AutoIncrementInteravalMinutes  = palConfig.FriendshipPoint_AutoIncrementInteravalMinutes				
				item.FriendshipPoint_AutoIncrementOtomo  = palConfig.FriendshipPoint_AutoIncrementOtomo	
				item.FriendshipPoint_AutoIncrementActiveOtomo  = palConfig.FriendshipPoint_AutoIncrementActiveOtomo	
				item.FriendshipPoint_AutoIncrementWorker  = palConfig.FriendshipPoint_AutoIncrementWorker
				item.FriendshipPoint_Petting  = palConfig.FriendshipPoint_Petting	
				item.FriendshipPoint_SleepOnSide  = palConfig.FriendshipPoint_SleepOnSide					
            end
        end
        print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Trust growth for pals set to " .. palConfig.FriendshipPoint_AutoIncrementOtomo .. palConfig.palRedColorWrapperBack)
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Trust growth for active pals set to " .. palConfig.FriendshipPoint_AutoIncrementActiveOtomo	 .. palConfig.palRedColorWrapperBack)
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Trust growth for workers set to " .. palConfig.FriendshipPoint_AutoIncrementWorker .. palConfig.palRedColorWrapperBack)				
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Trust Gain from petting set to " .. palConfig.FriendshipPoint_Petting .. palConfig.palRedColorWrapperBack)	
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Trust Gain from sleeping with pal set to " .. palConfig.FriendshipPoint_SleepOnSide .. palConfig.palRedColorWrapperBack)	
				
    end
    palConfig.palCheckRestart = 1
end)


-- [DEDICATED SRV] Register the new modifiers and print a successful change message in red
RegisterHook("/Script/Engine.PlayerController:ServerAcknowledgePossession", function(Context)
    if not palConfig.serverAcknowledgedPossession then
        local items = FindAllOf("PalGameSetting")
        if items then
            for _, item in ipairs(items) do 
				item.FriendshipPoint_AutoIncrementInteravalMinutes  = palConfig.FriendshipPoint_AutoIncrementInteravalMinutes			
				item.FriendshipPoint_AutoIncrementOtomo  = palConfig.FriendshipPoint_AutoIncrementOtomo	
				item.FriendshipPoint_AutoIncrementActiveOtomo  = palConfig.FriendshipPoint_AutoIncrementActiveOtomo	
				item.FriendshipPoint_AutoIncrementWorker  = palConfig.FriendshipPoint_AutoIncrementWorker
				item.FriendshipPoint_Petting  = palConfig.FriendshipPoint_Petting	
				item.FriendshipPoint_SleepOnSide  = palConfig.FriendshipPoint_SleepOnSide			
            end
        end
        print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Trust growth for pals set to " .. palConfig.FriendshipPoint_AutoIncrementOtomo .. palConfig.palRedColorWrapperBack)
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Trust growth for active pals set to " .. palConfig.FriendshipPoint_AutoIncrementActiveOtomo	 .. palConfig.palRedColorWrapperBack)
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Trust growth for workers set to " .. palConfig.FriendshipPoint_AutoIncrementWorker .. palConfig.palRedColorWrapperBack)				
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Trust Gain from petting set to " .. palConfig.FriendshipPoint_Petting .. palConfig.palRedColorWrapperBack)	
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Trust Gain from sleeping with pal set to " .. palConfig.FriendshipPoint_SleepOnSide .. palConfig.palRedColorWrapperBack)	
    end
    palConfig.serverAcknowledgedPossession = true
end)