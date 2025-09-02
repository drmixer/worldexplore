local BuildingSystem = {}

-- Size of the placement grid, in studs
BuildingSystem.GridSize = 4

-- Define structures available to build
-- Costs are given as item -> quantity tables
BuildingSystem.Structures = {
    Hut = {
        Cost = {Wood = 10, Fiber = 5},
        Size = {2, 2},
    },
    Fence = {
        Cost = {Wood = 2},
        Size = {1, 1},
    },
    Campfire = {
        Cost = {Wood = 3, Stone = 2},
        Size = {1, 1},
        Workstation = "Campfire",
    },
}

-- Rounds a position table to the nearest grid point
local function snapToGrid(position)
    local g = BuildingSystem.GridSize
    return {
        x = math.floor(position.x / g + 0.5) * g,
        y = position.y,
        z = math.floor(position.z / g + 0.5) * g,
    }
end

-- Checks if the given structure can be placed at the position
-- existing is a list of already placed structures
function BuildingSystem.canPlace(structureName, position, existing)
    local def = BuildingSystem.Structures[structureName]
    if not def then
        return false, "Unknown structure"
    end
    local snapped = snapToGrid(position)
    for _, other in ipairs(existing) do
        if other.Position.x == snapped.x and other.Position.z == snapped.z then
            return false, "Space occupied"
        end
    end
    return true
end

-- Places a structure, deducting cost from the inventory
-- inventory should implement :HasItems and :RemoveItem
function BuildingSystem.place(structureName, position, inventory, existing)
    local def = BuildingSystem.Structures[structureName]
    if not def then
        return nil, "Unknown structure"
    end
    if not inventory:HasItems(def.Cost) then
        return nil, "Missing materials"
    end
    local can, reason = BuildingSystem.canPlace(structureName, position, existing)
    if not can then
        return nil, reason
    end
    for item, qty in pairs(def.Cost) do
        inventory:RemoveItem(item, qty)
    end
    local snapped = snapToGrid(position)
    local structure = {
        Name = structureName,
        Position = snapped,
        Size = def.Size,
        Workstation = def.Workstation,
    }
    table.insert(existing, structure)
    return structure
end

return BuildingSystem

