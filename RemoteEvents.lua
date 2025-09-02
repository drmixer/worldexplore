local RemoteEvents = {}

-- Defines the RemoteEvents used by gameplay modules
RemoteEvents.EventNames = {
    Harvest = "HarvestRequest",
    Trade = "TradeRequest",
    Build = "BuildRequest",
    Combat = "CombatEvent",
}

-- Ensures each RemoteEvent exists under ReplicatedStorage
function RemoteEvents.init()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    for _, name in pairs(RemoteEvents.EventNames) do
        if not ReplicatedStorage:FindFirstChild(name) then
            local event = Instance.new("RemoteEvent")
            event.Name = name
            event.Parent = ReplicatedStorage
        end
    end
end

-- Helper to get a RemoteEvent by logical name
function RemoteEvents.get(name)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local eventName = RemoteEvents.EventNames[name]
    return ReplicatedStorage:FindFirstChild(eventName)
end

return RemoteEvents
