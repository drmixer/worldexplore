local ServerScriptService = game:GetService("ServerScriptService")
local modules = ServerScriptService:WaitForChild("Modules")
local WorldBuilder = require(modules.WorldBuilder)

-- Generate a more detailed starter world with terrain, trees, plants, and wildlife
WorldBuilder.generate()
