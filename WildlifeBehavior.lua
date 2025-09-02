local WildlifeBehavior = {}

-- Creates a creature with default combat and loot data
function WildlifeBehavior.new(info)
    local creature = {
        Name = info.Name,
        Biome = info.Biome,
        Location = info.Location,
        Health = info.Health or 0,
        Aggressive = info.Aggressive,
        Loot = info.Loot or {},
        State = "Idle",
        Dead = false,
    }
    return creature
end

local function distance(a, b)
    local dx = (a.x or 0) - (b.x or 0)
    local dy = (a.y or 0) - (b.y or 0)
    local dz = (a.z or 0) - (b.z or 0)
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

-- Very simple behavior state update based on player proximity
function WildlifeBehavior.update(creature, playerPosition)
    if creature.Dead then
        return
    end
    local dist = distance(creature.Location, playerPosition)
    if creature.Aggressive and dist <= 10 then
        WildlifeBehavior.attack(creature)
    elseif not creature.Aggressive and dist <= 10 then
        WildlifeBehavior.flee(creature, playerPosition)
    else
        WildlifeBehavior.wander(creature)
    end
end

function WildlifeBehavior.wander(creature)
    creature.State = "Wandering"
    -- Placeholder: move randomly around the area
end

function WildlifeBehavior.flee(creature, fromPosition)
    creature.State = "Fleeing"
    -- Placeholder: move away from fromPosition
end

function WildlifeBehavior.attack(creature)
    creature.State = "Attacking"
    -- Placeholder: would damage the player here
end

-- Applies damage and drops loot if the creature dies
function WildlifeBehavior.dealDamage(creature, amount, inventory)
    if creature.Dead then
        return false
    end
    creature.Health = creature.Health - amount
    if creature.Health <= 0 then
        creature.Dead = true
        creature.State = "Dead"
        WildlifeBehavior.dropLoot(creature, inventory)
    end
    return true
end

function WildlifeBehavior.dropLoot(creature, inventory)
    for _, drop in ipairs(creature.Loot) do
        inventory:AddItem(drop.Item, drop.Quantity)
    end
end

return WildlifeBehavior
