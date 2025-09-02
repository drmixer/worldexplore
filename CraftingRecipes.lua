local CraftingRecipes = {}

-- Basic crafting recipes for primitive tools
CraftingRecipes.Recipes = {
    StoneKnife = {
        Materials = {Stone = 1, Stick = 1},
        Output = {Item = "StoneKnife", Quantity = 1}
    },
    WoodenSpear = {
        Materials = {Stick = 2, Fiber = 1},
        Output = {Item = "WoodenSpear", Quantity = 1}
    },
    Campfire = {
        Materials = {Stick = 3, Stone = 3},
        Output = {Item = "Campfire", Quantity = 1}
    }
}

return CraftingRecipes
