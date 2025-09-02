local WildlifeSpawner = {}

-- Defines the wildlife types available in the primitive world
-- Indexed by name for efficient lookup
WildlifeSpawner.Types = {
    Deer = {
        Model = "DeerModel",
        Biome = "Forest",
        Health = 30,
        Loot = {
            {Item = "RawMeat", Quantity = 1},
            {Item = "Hide", Quantity = 1},
        },
        Aggressive = false,
    },
    Boar = {
        Model = "BoarModel",
        Biome = "Plains",
        Health = 40,
        Loot = {
            {Item = "RawMeat", Quantity = 1},
        },
        Aggressive = false,
    },
    Wolf = {
        Model = "WolfModel",
        Biome = "Forest",
        Health = 50,
        Loot = {
            {Item = "RawMeat", Quantity = 1},
            {Item = "Pelt", Quantity = 1},
        },
        Aggressive = true,
    },
}

-- Spawns a given wildlife type at the provided location
-- In a real game this would clone the corresponding model and set up AI
function WildlifeSpawner.spawn(wildlifeType, location)
    local info = WildlifeSpawner.Types[wildlifeType]
    if not info then
        warn("Unknown wildlife type: " .. tostring(wildlifeType))
        return nil
    end

    -- Placeholder spawn logic
    local creature = {
        Name = wildlifeType,
        Model = info.Model,
        Biome = info.Biome,
        Location = location,
        Health = info.Health,
        Loot = info.Loot,
        Aggressive = info.Aggressive,
    }
    return creature
end

return WildlifeSpawner
