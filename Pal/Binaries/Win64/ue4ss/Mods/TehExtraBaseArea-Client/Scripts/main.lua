local defaultRange = 3500
local defaultScale = {X = 70.01, Y = 70.01, Z = 100.01}

-- modifyPalBox code courtesy of slinky.dev on Discord!
local function modifyPalBox()
    local areaRange = StaticFindObject("/Game/Pal/Blueprint/MapObject/BuildObject/BP_BuildObject_PalBoxV2.BP_BuildObject_PalBoxV2_C:AreaRange_GEN_VARIABLE")
    local areaRange1 = StaticFindObject("/Game/Pal/Blueprint/MapObject/BuildObject/BP_BuildObject_PalBoxV2.BP_BuildObject_PalBoxV2_C:AreaRange1_GEN_VARIABLE")
    if not areaRange:IsValid() and not areaRange1:IsValid() then
        print("[TEBA-C] Circle Extender: Could Not Get Area Ranges\n")
        return
    end

    local base_model = FindFirstOf("PalBaseCampModel")
    local area = tonumber(base_model:GetPropertyValue("AreaRange"))
    if area == nil then
        print("[TEBA-C] Area Range not loaded, couldn't move blue line")
        return
    end
    local scaledRange = area / defaultRange
    local scaled3D = { X = defaultScale.X * scaledRange, Y = defaultScale.Y * scaledRange, Z = defaultScale.Z * scaledRange}
    areaRange.RelativeScale3D = scaled3D
    areaRange1.RelativeScale3D = scaled3D
    print("[TEBA-C] Moved deadly blue line...")
end

NotifyOnNewObject("/Script/Pal.PalBuildObjectBaseCampPoint", modifyPalBox)