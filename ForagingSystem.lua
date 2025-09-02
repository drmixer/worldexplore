local ForagingSystem = {}

-- Defines plants available for foraging in different biomes
-- Indexed by name for easy retrieval
ForagingSystem.Plants = {
    BerryBush = {
        Biome = "Forest",
        RegrowTime = 60,
        Yield = {Item = "Berries", Quantity = 1},
    },
    Herb = {
        Biome = "Swamp",
        RegrowTime = 120,
        Yield = {Item = "HerbLeaf", Quantity = 1},
    },
}

-- Spawns a plant instance at the given location
function ForagingSystem.spawn(plantName, location)
    local def = ForagingSystem.Plants[plantName]
    if not def then
        warn("Unknown plant type: " .. tostring(plantName))
        return nil
    end

    local plant = {
        Name = plantName,
        Biome = def.Biome,
        Location = location,
        Harvested = false,
        RegrowTime = def.RegrowTime,
        Yield = def.Yield,
        LastHarvest = 0,
    }
    return plant
end

-- Harvests a plant into the given inventory, respecting regrow time
-- currentTime is seconds since some reference point (e.g., os.time())
function ForagingSystem.harvest(plant, inventory, currentTime)
    if not ForagingSystem.isReady(plant, currentTime) then
        return false, "Plant is regrowing"
    end
    inventory:AddItem(plant.Yield.Item, plant.Yield.Quantity)
    plant.Harvested = true
    plant.LastHarvest = currentTime
    return true
end

-- Updates a plant's state based on current time
function ForagingSystem.update(plant, currentTime)
    if plant.Harvested and currentTime - plant.LastHarvest >= plant.RegrowTime then
        plant.Harvested = false
    end
end

-- Returns true if the plant can currently be harvested
function ForagingSystem.isReady(plant, currentTime)
    if not plant.Harvested then
        return true
    end
    return currentTime - plant.LastHarvest >= plant.RegrowTime
end

return ForagingSystem

