# Deployment Guide

This guide explains how to bring the **Brave New World** primitive module set into a fresh Roblox Studio experience.

## 1. Get the source
1. Clone or download this repository locally.
2. Inside the repo, all gameplay modules live under `ReplicatedStorage/Modules`.

## 2. Prepare the Roblox place
1. Open **Roblox Studio** and create a new place.
2. In the **Explorer** window:
   - Ensure `ReplicatedStorage` exists (it does in all new places).
   - Create a folder under `ReplicatedStorage` named `Modules`.
   - For each Lua file in this repo's `ReplicatedStorage/Modules` directory, create a **ModuleScript** inside that `Modules` folder using the same file name and copy the file's contents into it:
     - `BuildingSystem`
     - `Campfire`
     - `ClanSystem`
     - `CraftingRecipes`
     - `DataPersistence`
     - `ForagingSystem`
     - `InventoryManager`
     - `RemoteEvents`
     - `TradeService`
     - `WildlifeBehavior`
     - `WildlifeSpawner`
     - `WorldTime`

## 3. Add supporting services
1. Under **ServerStorage**, create folders/models for any wildlife or building assets that the modules will clone (e.g., `WildlifeModels/Deer`, `WildlifeModels/Boar`).
2. If you plan to use **DataStoreService**, enable Studio API access for your experience (Home → Game Settings → Security → Enable Studio Access to API Services).

## 4. Server scaffolding
Create a Script named `ServerInit` inside **ServerScriptService** with the following starter code:
```lua
local Modules = game.ReplicatedStorage.Modules
local RemoteEvents = require(Modules.RemoteEvents)
local DataPersistence = require(Modules.DataPersistence)
local WildlifeSpawner = require(Modules.WildlifeSpawner)
local WildlifeBehavior = require(Modules.WildlifeBehavior)
local WorldTime = require(Modules.WorldTime)

-- Register RemoteEvents and kick off the world timers
RemoteEvents.init()
WorldTime.start()

-- Load player data
game.Players.PlayerAdded:Connect(function(player)
    DataPersistence.loadPlayer(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
    DataPersistence.savePlayer(player)
end)

-- Spawn an example deer
local deerModel = WildlifeSpawner.spawn("Deer", Vector3.new(0, 3, 0))
WildlifeBehavior.new(deerModel)
```
This script wires up data persistence, time of day, remote events, and spawns a single deer for testing.

## 5. Client scaffolding (optional)
If you need client scripts, place them under **StarterPlayerScripts**. Example: create `ClientInit` that connects to the RemoteEvents defined in `RemoteEvents.init()`.

## 6. Test in Studio
1. Press **Play** to run the experience locally.
2. Watch the **Output** window for any errors from the modules.
3. Verify that the deer spawns and the world time cycles.

## 7. Publish
When satisfied:
1. Click **File → Publish to Roblox As…** and choose or create an experience.
2. Configure permissions and access through the **Creator Dashboard**.

You now have a playable prototype using the modules from this repository.
