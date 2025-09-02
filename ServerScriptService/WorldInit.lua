-- Starter server script that generates the detailed terrain and foliage
local ServerScriptService = game:GetService("ServerScriptService")
local modules = ServerScriptService:WaitForChild("Modules")
local WorldBuilder = require(modules.WorldBuilder)

-- Build the starter world with terrain, trees, plants, and wildlife
WorldBuilder.generate()
