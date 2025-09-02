# Brave New World

This repository contains Lua modules for the primitive quadrant of the *Brave New World* Roblox game. The initial modules cover
 basic wildlife spawning and behavior, plant foraging, clan management, crafting recipes, inventory tracking, and a simple barter-based trading system.

## Modules
- `WildlifeSpawner` – defines wildlife types and placeholder spawn logic.
- `WildlifeBehavior` – handles simple AI, combat, and loot drops for wildlife.
- `ClanSystem` – basic clan creation and member management.
- `CraftingRecipes` – sample crafting recipes for primitive tools and structures.
- `InventoryManager` – inventory helper functions for adding, removing, and checking items.
- `TradeService` – a simple item-for-item trade validator.
- `ForagingSystem` – spawns plants and handles harvesting with regrowth timers.
- `BuildingSystem` – grid-based placement of huts, fences, and campfires.
- `Campfire` – basic workstation logic for fueling and cooking food.
- `DataPersistence` – saves and loads player inventories and clan data.
- `WorldTime` – manages a quick day/night cycle and randomized weather states.
- `RemoteEvents` – registers RemoteEvents for harvesting, trading, building, and combat.
- `WorldBuilder` – procedural helper that carves out multiple biomes with terrain, trees, plants, and wildlife for a starter map.

These modules are designed for use within `ReplicatedStorage/Modules` in Roblox Studio. See `DEPLOYMENT.md` for an exhaustive, step-by-step setup guide.

## Server script
- `WorldInit` – calls `WorldBuilder` to generate distinct forest, plains, swamp, mountain, and coastal regions for quick prototyping.
