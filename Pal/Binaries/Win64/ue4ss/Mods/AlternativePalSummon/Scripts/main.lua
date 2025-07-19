local config = require("./config")

---@class UPalUtility
local PalUtility = nil

---@class UKismetMathLibrary
local KismetMathLibrary = nil

---@class UKismetSystemLibrary
local KismetSystemLibrary = nil

local NAME_BPPalPlayerController = FName("BP_PalPlayerController_C")

local function Initialize()
    PalUtility = StaticFindObject("/Script/Pal.Default__PalUtility")
    KismetMathLibrary = StaticFindObject("/Script/Engine.Default__KismetMathLibrary")
    KismetSystemLibrary = StaticFindObject("/Script/Engine.Default__KismetSystemLibrary")
end

---@param PlayerController APalPlayerController
---@return table
local function GetLineTraceResult(PlayerController)
    local PlayerPawn = PlayerController.Pawn
    local CameraManager = PlayerController.PlayerCameraManager
    local StartVector = CameraManager:GetCameraLocation()
    local AddValue = KismetMathLibrary:Multiply_VectorInt(KismetMathLibrary:GetForwardVector(CameraManager:GetCameraRotation()), config.MaxSummonDistance)
    local EndVector = KismetMathLibrary:Add_VectorVector(StartVector, AddValue)
    local ActorsToIgnore = {
    }
    local HitResult = {}
    KismetSystemLibrary:LineTraceSingle(
        PlayerPawn,
        StartVector,
        EndVector,
        0,
        false,
        ActorsToIgnore,
        0,
        HitResult,
        true,
        {},
        {},
        0.0
    )
    return {
        Result = HitResult,
        Endpoint = EndVector
    }
end

ExecuteInGameThread(function ()
    -- We have to load the asset here because it's a blueprint and they're typically loaded on demand.
    -- Basically means we won't be able to hook the function 'ActivateCurrentOtomo' since the entire blueprint isn't loaded in memory yet.
    LoadAsset("/Game/Pal/Blueprint/Component/OtomoHolder/BP_OtomoPalHolderComponent.BP_OtomoPalHolderComponent_C")

    Initialize()

    ---@param Context UBP_OtomoPalHolderComponent_C
    ---@param Transform FTransform
    RegisterHook("/Game/Pal/Blueprint/Component/OtomoHolder/BP_OtomoPalHolderComponent.BP_OtomoPalHolderComponent_C:ActivateCurrentOtomo", function (Context, Transform)
        ---@class APalController
        local Controller = Context:get():GetOuter()

        if Controller:GetClass():GetFName() == NAME_BPPalPlayerController then
            local Trace = GetLineTraceResult(Controller)

            local FinalLocation = { X = 0.0, Y = 0.0 , Z = 0.0 }
            if Trace.Result.Location.X == 0.0 and Trace.Result.Location.Y == 0.0 and Trace.Result.Location.Z == 0.0 then
                FinalLocation = { X = Trace.Endpoint.X, Y = Trace.Endpoint.Y, Z = Trace.Endpoint.Z + 150.0 }
            else
                FinalLocation = { X = Trace.Result.Location.X, Y = Trace.Result.Location.Y, Z = Trace.Result.Location.Z + 150.0 }
            end

            ---@class UPalIndividualCharacterHandle
            local Handle = Context:get():GetOtomoIndividualHandle(Context:get().SelectedOtomoSlotID)

            local Actor = Handle:TryGetIndividualActor()
            Actor:K2_SetActorLocation(FinalLocation, false, {}, false)
        end

        --- For some reason a manual return is needed here because UE4SS overrides the return by default for blueprints which might be a bug...?
        --- If the return value is false, then summoned pals will refuse to do any work.
        --- Here's hoping this doesn't cause any side effects...
        return true
    end)
end)