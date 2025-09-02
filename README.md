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


## Codespaces + Rojo + Open Cloud

**One-time Roblox setup**
1. Create (or open) your Experience in Creator Hub.
2. Copy your **Universe ID** (aka experience ID) from Creator Hub.
3. Copy your **Place ID** (open the place page in a browser; the numeric ID in the URL).

**GitHub repo config**
- Settings → Secrets and variables → Actions
  - Secret: `ROBLOX_API_KEY` = your Open Cloud key
  - Variables: `ROBLOX_UNIVERSE_ID`, `ROBLOX_PLACE_ID`

**Develop in Codespaces**
- Open the repo in Codespaces — Rojo installs automatically.
- Build: `rojo build -o build/build.rbxlx`
- Push to `main` → CI builds & publishes.
