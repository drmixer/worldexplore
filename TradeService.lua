local TradeService = {}

-- Validates a trade between two inventories and exchanges the items
function TradeService.Trade(inventoryA, offeredA, inventoryB, offeredB)
    if not inventoryA:HasItems(offeredA) then
        return false, "Player A lacks required items"
    end
    if not inventoryB:HasItems(offeredB) then
        return false, "Player B lacks required items"
    end

    -- Remove items from inventories
    for item, qty in pairs(offeredA) do
        inventoryA:RemoveItem(item, qty)
        inventoryB:AddItem(item, qty)
    end
    for item, qty in pairs(offeredB) do
        inventoryB:RemoveItem(item, qty)
        inventoryA:AddItem(item, qty)
    end

    return true
end

return TradeService
