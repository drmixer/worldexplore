local InventoryManager = {}
InventoryManager.__index = InventoryManager

-- Creates a new inventory table
function InventoryManager.new()
    return setmetatable({Items = {}}, InventoryManager)
end

-- Adds an item to the inventory
function InventoryManager:AddItem(itemName, quantity)
    self.Items[itemName] = (self.Items[itemName] or 0) + quantity
end

-- Removes an item from the inventory
function InventoryManager:RemoveItem(itemName, quantity)
    local current = self.Items[itemName] or 0
    if current < quantity then
        return false
    end
    self.Items[itemName] = current - quantity
    if self.Items[itemName] <= 0 then
        self.Items[itemName] = nil
    end
    return true
end

-- Returns the quantity of the specified item in the inventory
function InventoryManager:GetItemCount(itemName)
    return self.Items[itemName] or 0
end

-- Checks if the inventory has the required items
function InventoryManager:HasItems(requirements)
    for item, qty in pairs(requirements) do
        if (self.Items[item] or 0) < qty then
            return false
        end
    end
    return true
end

return InventoryManager
