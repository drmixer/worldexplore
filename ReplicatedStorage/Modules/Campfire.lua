local Campfire = {}
Campfire.__index = Campfire

-- Creates a new campfire state
function Campfire.new()
    return setmetatable({Fuel = 0}, Campfire)
end

-- Adds fuel from the inventory
function Campfire:AddFuel(inventory, item, quantity)
    if item ~= "Wood" then
        return false, "Invalid fuel"
    end
    if not inventory:RemoveItem(item, quantity) then
        return false, "Missing fuel"
    end
    self.Fuel = self.Fuel + quantity
    return true
end

-- Cooks raw meat into cooked meat if fuel is available
function Campfire:Cook(inventory)
    if self.Fuel <= 0 then
        return false, "No fuel"
    end
    if not inventory:RemoveItem("RawMeat", 1) then
        return false, "No raw meat"
    end
    inventory:AddItem("CookedMeat", 1)
    self.Fuel = self.Fuel - 1
    return true
end

return Campfire

