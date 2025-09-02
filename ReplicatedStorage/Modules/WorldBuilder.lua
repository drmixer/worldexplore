local WorldBuilder = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local Terrain = workspace.Terrain

local modules = ReplicatedStorage:WaitForChild("Modules")
local WildlifeSpawner = require(modules.WildlifeSpawner)
local ForagingSystem = require(modules.ForagingSystem)

-- Define rectangular regions for each biome
WorldBuilder.Biomes = {
    Forest = {minX = -256, maxX = 0, minZ = -256, maxZ = 0},
    Plains = {minX = 0, maxX = 200, minZ = -256, maxZ = 0},
    Swamp = {minX = -256, maxX = 0, minZ = 0, maxZ = 256},
    Mountain = {minX = 0, maxX = 200, minZ = 0, maxZ = 256},
    Coast = {minX = 200, maxX = 256, minZ = -256, maxZ = 256},
}

local function randomInArea(area)
    local x = math.random(area.minX, area.maxX)
    local z = math.random(area.minZ, area.maxZ)
    return Vector3.new(x, 0, z)
end

-- Ensures a baseplate exists under the world
function WorldBuilder.createBaseplate(size)
    local baseplate = workspace:FindFirstChild("Baseplate")
    if not baseplate then
        baseplate = Instance.new("Part")
        baseplate.Name = "Baseplate"
        baseplate.Size = Vector3.new(size, 1, size)
        baseplate.Position = Vector3.new(0, -0.5, 0)
        baseplate.Anchored = true
        baseplate.Parent = workspace
    end
    return baseplate
end

-- Build simple terrain: ground plane, a couple hills, and a river
function WorldBuilder.createTerrain()
    Terrain:Clear()
    -- base ground
    Terrain:FillBlock(CFrame.new(0, -10, 0), Vector3.new(512, 20, 512), Enum.Material.Grass)
    -- river running north-south through center
    Terrain:FillBlock(CFrame.new(0, -5, 0), Vector3.new(20, 20, 512), Enum.Material.Water)
    -- mountain hill in northeast
    Terrain:FillBall(Vector3.new(150, 0, 150), 60, Enum.Material.Rock)
    -- swampy water patch in southwest
    Terrain:FillBlock(CFrame.new(-150, -6, 150), Vector3.new(80, 20, 80), Enum.Material.Water)
    -- coastal water along eastern edge
    Terrain:FillBlock(CFrame.new(228, -8, 0), Vector3.new(56, 16, 512), Enum.Material.Water)
end

-- Scatter placeholder trees throughout the map
function WorldBuilder.scatterTrees(count, area)
    local treeFolder = workspace:FindFirstChild("Trees")
    if not treeFolder then
        treeFolder = Instance.new("Folder")
        treeFolder.Name = "Trees"
        treeFolder.Parent = workspace
    end

    for i = 1, count do
        local pos = randomInArea(area)
        local trunk = Instance.new("Part")
        trunk.Size = Vector3.new(2, 8, 2)
        trunk.CFrame = CFrame.new(pos.X, 4, pos.Z)
        trunk.Anchored = true
        trunk.BrickColor = BrickColor.new("Reddish brown")
        trunk.Parent = treeFolder

        local canopy = Instance.new("Part")
        canopy.Shape = Enum.PartType.Ball
        canopy.Size = Vector3.new(8, 8, 8)
        canopy.CFrame = CFrame.new(pos.X, 10, pos.Z)
        canopy.Anchored = true
        canopy.BrickColor = BrickColor.new("Forest green")
        canopy.Parent = treeFolder
    end
end

-- Spawn random plants of the biome within the given area
function WorldBuilder.spawnPlantsForBiome(biome, area, count)
    local options = {}
    for name, def in pairs(ForagingSystem.Plants) do
        if def.Biome == biome then
            table.insert(options, name)
        end
    end
    if #options == 0 then return end

    local plantColors = {
        BerryBush = BrickColor.new("Forest green"),
        Mushroom = BrickColor.new("Bright red"),
        RootPlant = BrickColor.new("Reddish brown"),
        Herb = BrickColor.new("Bright green"),
    }

    for i = 1, count do
        local plantName = options[math.random(#options)]
        local pos = randomInArea(area) + Vector3.new(0, 1.5, 0)
        local part = Instance.new("Part")
        part.Name = plantName
        part.Size = Vector3.new(2, 3, 2)
        part.Position = pos
        part.Anchored = true
        part.BrickColor = plantColors[plantName] or BrickColor.new("Forest green")
        part.Parent = workspace
        ForagingSystem.spawn(plantName, pos)
    end
end

-- Spawn wildlife suited for the biome within the area
function WorldBuilder.spawnWildlifeForBiome(biome, area, count)
    local options = {}
    for name, def in pairs(WildlifeSpawner.Types) do
        if def.Biome == biome then
            table.insert(options, name)
        end
    end
    if #options == 0 then return end

    for i = 1, count do
        local kind = options[math.random(#options)]
        local pos = randomInArea(area) + Vector3.new(0, 2, 0)
        local creatureData = WildlifeSpawner.spawn(kind, pos)
        if creatureData then
            local part = Instance.new("Part")
            part.Name = creatureData.Name
            part.Size = Vector3.new(4, 4, 4)
            part.CFrame = CFrame.new(pos)
            part.Anchored = true
            part.Parent = workspace
        end
    end
end

function WorldBuilder.generate()
    math.randomseed(tick())
    WorldBuilder.createBaseplate(512)
    WorldBuilder.createTerrain()
    WorldBuilder.scatterTrees(40, WorldBuilder.Biomes.Forest)
    WorldBuilder.scatterTrees(10, WorldBuilder.Biomes.Plains)
    WorldBuilder.spawnPlantsForBiome("Forest", WorldBuilder.Biomes.Forest, 8)
    WorldBuilder.spawnPlantsForBiome("Plains", WorldBuilder.Biomes.Plains, 6)
    WorldBuilder.spawnPlantsForBiome("Swamp", WorldBuilder.Biomes.Swamp, 5)
    WorldBuilder.spawnWildlifeForBiome("Forest", WorldBuilder.Biomes.Forest, 4)
    WorldBuilder.spawnWildlifeForBiome("Plains", WorldBuilder.Biomes.Plains, 3)
    WorldBuilder.spawnWildlifeForBiome("Mountain", WorldBuilder.Biomes.Mountain, 2)
end

return WorldBuilder

