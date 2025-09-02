local Clan = {}
Clan.__index = Clan

-- Creates a new clan with the given leader
function Clan.new(name, leader)
    return setmetatable({Name = name, Leader = leader, Members = {[leader] = true}}, Clan)
end

-- Adds a member to the clan
function Clan:AddMember(player)
    self.Members[player] = true
end

-- Removes a member from the clan
function Clan:RemoveMember(player)
    self.Members[player] = nil
    if self.Leader == player then
        self.Leader = nil
    end
end

-- Returns a list of all members
function Clan:GetMembers()
    local list = {}
    for player, _ in pairs(self.Members) do
        table.insert(list, player)
    end
    return list
end

return Clan
