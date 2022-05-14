Config = {}

-- TODO
-- ADD BLUR
-- CAMERA FACE NPC
-- CINEMATIC
-- NPC ANIMATION
-- TYPE SELL OR BUY
-- npc
-- npc allowed


Config.Align = "center" -- "center" / "top-left" / "top-right"


-- UNIQUE STORES

Config.Stores = {
    Val = {
        BlipName = 'valentine',
        shopName = 'valentines',
        PromptName = " general store",
        sprite = 90287351,
        x = -380.723, y = 825.3263, z = 116.00,
        blipAllowed = true
    },

    Rhodes = {
        BlipName = 'Rhodes store',
        shopName = 'Rhodes shop',
        PromptName = " general sell store",
        sprite = 90287351,
        x = -345.014, y = 840.3168, z = 116.63,
        blipAllowed = true
    },
}

Config.sellItems = {
    Val = {
        { itemLabel = "Gold ", itemName = "golden_nugget", price = 1, desc = "gold nuget<br><br><br>PRICE = <span style=color:Yellow;>" },
        { itemLabel = "Pick", itemName = "pickaxe", price = 40, desc = "gold nuget<br><br><br>PRICE = <span style=color:Yellow;>" },

    },
    Rhodes = {
        { itemLabel = "Golden Ring", itemName = "golden_ring", price = 50, desc = " delicious" },
        { itemLabel = "Worm", itemName = "worm", price = 1, desc = " good worm" },

    }
}
