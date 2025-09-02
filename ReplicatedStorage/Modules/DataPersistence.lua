local DataPersistence = {}

-- Wrapper around DataStoreService for loading and saving player data
-- Inventory data is stored as a dictionary of item -> quantity
-- Clan membership is stored as a string clan name or nil

local DATASTORE_NAME = "BraveNewWorld_PlayerData"

local function getStore()
    local DataStoreService = game:GetService("DataStoreService")
    return DataStoreService:GetDataStore(DATASTORE_NAME)
end

-- Loads player data, returning a table with Inventory and Clan keys
function DataPersistence.load(player)
    local store = getStore()
    local key = "player_" .. player.UserId
    local success, data = pcall(function()
        return store:GetAsync(key)
    end)
    if success and data then
        return data
    end
    return {Inventory = {}, Clan = nil}
end

-- Saves the provided data table for the player
function DataPersistence.save(player, data)
    local store = getStore()
    local key = "player_" .. player.UserId
    local success, err = pcall(function()
        store:SetAsync(key, data)
    end)
    return success, err
end

-- Serializes an inventory object created by InventoryManager
function DataPersistence.serializeInventory(inventory)
    return inventory.Items
end

-- Deserializes inventory data into an InventoryManager object
function DataPersistence.deserializeInventory(data)
    local InventoryManager = require(script.Parent.InventoryManager)
    local inv = InventoryManager.new()
    for item, qty in pairs(data or {}) do
        inv.Items[item] = qty
    end
    return inv
end

return DataPersistence
