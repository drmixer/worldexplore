# Deployment Guide

This exhaustive guide walks through installing the **Brave New World** modules into a blank Roblox experience. Follow every step exactly to spin up the prototype.

## 1. Prerequisites
- Roblox account with permission to publish experiences.
- Roblox Studio installed and updated.
- Optional: published place for persistent DataStore testing.

## 2. Get the source
1. Clone or download this repository to your computer.
2. Inside the repo, gameplay modules live under `ReplicatedStorage/Modules` and server scripts under `ServerScriptService`.

## 3. Copy modules into Studio
1. Open **Roblox Studio** and create a new place.
2. In the **Explorer** panel:
   1. Expand `ReplicatedStorage`.
   2. Right-click `ReplicatedStorage` → **Insert Object** → **Folder** and rename the new folder to `Modules`.
3. For each `.lua` file in this repo's `ReplicatedStorage/Modules` directory:
   1. Right-click the `Modules` folder → **Insert Object** → **ModuleScript**.
   2. Rename the ModuleScript to match the file name exactly (e.g., `WildlifeSpawner`).
   3. Open the script, delete the default code, and paste in the contents from the repository file.

Create ModuleScripts for the following files:

- `BuildingSystem`
- `Campfire`
- `ClanSystem`
- `CraftingRecipes`
- `DataPersistence`
- `ForagingSystem`
- `InventoryManager`
- `RemoteEvents`
- `WorldBuilder`
- `TradeService`
- `WildlifeBehavior`
- `WildlifeSpawner`
- `WorldTime`

## 4. Provide asset models
1. In **ServerStorage**, create a folder named `WildlifeModels`.
2. Insert animal models inside this folder with names that match entries in `WildlifeSpawner.Types` (`Deer`, `Boar`, etc.).
3. Add building prefabs (e.g., `Hut`, `Fence`) in similar folders if you plan to spawn them with `BuildingSystem`.

## 5. Configure DataStore access (optional)
1. Studio menu: **Home → Game Settings → Security**.
2. Check **Enable Studio Access to API Services** so `DataPersistence` can access `DataStoreService` while testing.
3. DataStores only save when the experience is published and run online; in Studio sessions they act as temporary storage.

## 6. Server scripts
Create two Scripts under **ServerScriptService**.

### 6.1 `WorldInit`
1. Right-click `ServerScriptService` → **Insert Object** → **Script**.
2. Rename to `WorldInit` and replace its contents with `ServerScriptService/WorldInit.lua` from this repo.
3. The script invokes `WorldBuilder.generate()` to carve basic terrain, scatter trees, spawn plants, and place a couple wildlife models so you can explore a richer starter map.

### 6.2 `ServerInit`
1. Insert another Script named `ServerInit`.
2. Paste in the template below to wire modules together:

```lua
local Modules = game.ReplicatedStorage.Modules
local RemoteEvents = require(Modules.RemoteEvents)
local DataPersistence = require(Modules.DataPersistence)
local WildlifeSpawner = require(Modules.WildlifeSpawner)
local WildlifeBehavior = require(Modules.WildlifeBehavior)
local WorldTime = require(Modules.WorldTime)

-- create RemoteEvents and start world clock
RemoteEvents.init()
WorldTime.start()

-- load/save player data
game.Players.PlayerAdded:Connect(function(player)
    DataPersistence.loadPlayer(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
    DataPersistence.savePlayer(player)
end)

-- spawn a test deer so you can see wildlife AI running
local deerModel = WildlifeSpawner.spawn("Deer", Vector3.new(0, 3, 0))
WildlifeBehavior.new(deerModel)
```

## 7. Optional client script
If you require client-side logic, create **StarterPlayerScripts/ClientInit** (LocalScript). Require `ReplicatedStorage.Modules.RemoteEvents` and connect to events fired by the server (e.g., harvesting or trade confirmations).

## 8. Run the prototype
1. Press **Play** in Studio.
2. Open **View → Output** to watch for errors or status messages.
3. You should see the baseplate, sample parts, a fast day/night cycle, and a deer wandering around.

## 9. Publish and test with friends
1. **File → Publish to Roblox As...** and create or select an experience.
2. After publishing, open the **Creator Dashboard** to configure permissions and (if needed) API access.
3. Share the game link; DataStore persistence now functions across sessions.

You're ready to expand the world by adding more wildlife, plants, structures, and player interactions.

