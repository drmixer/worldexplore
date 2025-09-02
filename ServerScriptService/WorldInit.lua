local ReplicatedStorage = game:GetService("ReplicatedStorage")
local modules = ReplicatedStorage:WaitForChild("Modules")
local WorldBuilder = require(modules.WorldBuilder)

-- Generate a more detailed starter world with terrain, trees, plants, and wildlife
WorldBuilder.generate()
