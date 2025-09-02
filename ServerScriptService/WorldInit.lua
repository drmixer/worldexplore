
-- Starter server script that generates the detailed terrain and foliage
local ServerScriptService = game:GetService("ServerScriptService")
local modules = ServerScriptService:WaitForChild("Modules")
local WorldBuilder = require(modules.WorldBuilder)

-- Build the starter world with terrain, trees, plants, and wildlife

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local modules = ReplicatedStorage:WaitForChild("Modules")
local WorldBuilder = require(modules.WorldBuilder)

-- Generate a more detailed starter world with terrain, trees, plants, and wildlife 
 main
WorldBuilder.generate()
