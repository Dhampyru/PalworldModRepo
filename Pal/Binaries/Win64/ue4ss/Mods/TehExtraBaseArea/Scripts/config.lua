local _TehEBRConfig = {
    -- Default: 3500.0 | Changes the area of your base
    AreaRange = 5000.0,
    -- ========================
    -- Default: false | If true, the mod will automatically update the game settings as set below
    -- Can cause conflicts with other mods that modify the same settings
    EditGameSettings = true,
    -- Default: 5000.0 | Changes the distance from the base where wild pal/enemy spawning is disabled
    SpawnerDisableDistanceCM_FromBaseCamp = 6000.0,
    -- Default: 7000.0 | How far away from the base pals can work
    BaseCampExtraWorkAreaRange = 7000.0,
    -- Default: 2000.0 | How far away from the base the pal combat range is increased by. Shouldn't need to increase this
    BaseCampPalCombatRange_AddCampRange = 2000.0,
    -- Default: 1500.0 | The minimum distance between bases. Can be set to 0 to allow bases to overlap, but this is not recommended
    BaseCampNeighborMinimumDistance = 500.0,
}

return _TehEBRConfig