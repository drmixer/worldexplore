package.path = './ReplicatedStorage/Modules/?.lua;./ServerScriptService/Modules/?.lua;' .. package.path

local InventoryManager = require('InventoryManager')
local ForagingSystem = require('ForagingSystem')
local CraftingRecipes = require('CraftingRecipes')
local BuildingSystem = require('BuildingSystem')
local WildlifeSpawner = require('WildlifeSpawner')
local WildlifeBehavior = require('WildlifeBehavior')
local ClanSystem = require('ClanSystem')
local TradeService = require('TradeService')
local WorldTime = require('WorldTime')

-- Set up player inventories
local playerA = InventoryManager.new()
local playerB = InventoryManager.new()

-- Foraging example
local bush = ForagingSystem.spawn('BerryBush', {x=0,y=0,z=0})
ForagingSystem.harvest(bush, playerA, 0)
print('PlayerA berries:', playerA:GetItemCount('Berries'))

-- Crafting example: StoneKnife
playerA:AddItem('Stone',1)
playerA:AddItem('Stick',1)
local recipe = CraftingRecipes.Recipes.StoneKnife
if playerA:HasItems(recipe.Materials) then
    for item,qty in pairs(recipe.Materials) do
        playerA:RemoveItem(item,qty)
    end
    playerA:AddItem(recipe.Output.Item, recipe.Output.Quantity)
end
print('PlayerA StoneKnives:', playerA:GetItemCount('StoneKnife'))

-- Building example: Campfire
playerA:AddItem('Wood',3)
playerA:AddItem('Stone',3)
local placed = BuildingSystem.place('Campfire', {x=0,y=0,z=0}, playerA, {})
print('Campfire placed:', placed ~= nil)

-- Wildlife combat example
local deerInfo = WildlifeSpawner.spawn('Deer', {x=10,y=0,z=0})
local deer = WildlifeBehavior.new(deerInfo)
WildlifeBehavior.dealDamage(deer, 40, playerA)
print('Deer dead:', deer.Dead, 'PlayerA meat:', playerA:GetItemCount('RawMeat'))

-- Trading example
playerB:AddItem('Stick',1)
local ok, err = TradeService.Trade(playerA, {RawMeat=1}, playerB, {Stick=1})
print('Trade success:', ok)
print('PlayerA inventory:', playerA:GetItemCount('RawMeat'), 'meat,', playerA:GetItemCount('Stick'), 'stick')

-- Clan example
local clan = ClanSystem.new('Settlers', 'PlayerA')
clan:AddMember('PlayerB')
print('Clan members:', table.concat(clan:GetMembers(), ', '))

-- World time example
local worldTime = WorldTime.new()
worldTime:Update(30)
worldTime:RandomizeWeather()
print('Time:', worldTime.Time, 'Weather:', worldTime.Weather)
