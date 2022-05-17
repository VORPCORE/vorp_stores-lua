Config = {}

-- TODO
-- ADD BLUR
-- CAMERA FACE NPC
-- CINEMATIC
-- NPC ANIMATION
-- TYPE SELL OR BUY
-- show only inventory items for sell if exist
-- jobrank


--- MENU POSITION ---

-- "center" / "top-left" / "top-right"
Config.Align = "top-right"

--- CHOOSE LANGUAGE IF AVAILABLE ---
Config.defaultlang = "en_lang"

-- open stores
Config.Key = 0x39336A4F --Space



--- STORES ---
Config.Stores = {
    Valentine = {
        blipAllowed = true,
        BlipName = 'Valentine Store',
        storeName = 'Valentine',
        --  StoreType = "sell",
        StoreTypeDesc = "sell items", -- or buy
        PromptName = "General Store",
        sprite = 1475879922,
        x = -324.134, y = 803.567, z = 116.8816, h = 283.007, --blip/ prompt and npc positions
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        JobAllowed = false, -- if true edit above the jobs allwoed to use the store
        Jobs = { "police", "sheriff" } -- jobs allowed

    },

    Rhodes = {
        blipAllowed = true,
        BlipName = 'Rhodes Store',
        storeName = 'Rhodes',
        -- StoreType = "sell", -- or buy
        StoreTypeDesc = "sell items",
        PromptName = "General Store",
        sprite = 1475879922,
        x = 1329.900, y = -1294.152, z = 76.021, h = 67.742,
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        JobAllowed = false,
        Jobs = { "police", "sheriff" } -- -- jobs allowed

    },

    Strawberry = {
        blipAllowed = true,
        BlipName = 'Strawberry Store',
        storeName = 'Strawberry',
        --  StoreType = "sell",
        StoreTypeDesc = "sell items", -- or buy
        PromptName = "General Store",
        sprite = 1475879922,
        x = -1789.906, y = -388.316, z = 159.328, h = 52.30, --blip/ prompt and npc positions
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        JobAllowed = false, -- if true edit above the jobs allwoed to use the store
        Jobs = { "police", "sheriff" } -- jobs allowed

    },

    Blackwater = {
        blipAllowed = true,
        BlipName = 'Blackwater Store',
        storeName = 'Blackwater',
        --  StoreType = "sell",
        StoreTypeDesc = "sell items", -- or buy
        PromptName = "General Store",
        sprite = 1475879922,
        x = -784.220, y = -1322.134, z = 42.884, h = 173.266, --blip/ prompt and npc positions
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        JobAllowed = false, -- if true edit above the jobs allwoed to use the store
        Jobs = { "police", "sheriff" } -- jobs allowed

    },

    Armadillo = {
        blipAllowed = true,
        BlipName = 'Armadillo Store',
        storeName = 'Armadillo',
        --  StoreType = "sell",
        StoreTypeDesc = "sell items", -- or buy
        PromptName = "General Store",
        sprite = 1475879922,
        x = -3687.265, y = -2623.203, z = -14.431, h = 267.522, --blip/ prompt and npc positions
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        JobAllowed = false, -- if true edit above the jobs allwoed to use the store
        Jobs = { "police", "sheriff" } -- jobs allowed

    },

    Tumbleweed = {
        blipAllowed = true,
        BlipName = 'Tumbleweed Store',
        storeName = 'Tumbleweed',
        --  StoreType = "sell",
        StoreTypeDesc = "sell items", -- or buy
        PromptName = "General Store",
        sprite = 1475879922,
        x = -5485.910, y = -2938.069,z =  -1.399, h = 127.656, --blip/ prompt and npc positions
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        JobAllowed = false, -- if true edit above the jobs allwoed to use the store
        Jobs = { "police", "sheriff" } -- jobs allowed

    },

    SaintDenis = {
        blipAllowed = true,
        BlipName = 'Saint Denis Store',
        storeName = 'Saint Denis',
        --  StoreType = "sell",
        StoreTypeDesc = "sell items", -- or buy
        PromptName = "General Store",
        sprite = 1475879922,
        x = 2824.634, y = -1319.550, z = 45.755, h = 329.788, --blip/ prompt and npc positions
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        JobAllowed = false, -- if true edit above the jobs allwoed to use the store
        Jobs = { "police", "sheriff" } -- jobs allowed

    },
}

----------------------------------------------- STORE ITEMS --------------------------------------------------------------
-- curencytype "cash" or "gold"

---- SELL ITEMS -----------
Config.SellItems = {
    Valentine = {
        { itemLabel = "Apple ", itemName = "apple", currencyType = "cash", price = 1, desc = "sell with cash" },
        { itemLabel = "Pick", itemName = "pickaxe", currencyType = "cash", price = 40, desc = "sell with gold pick axe" },

    },
    Rhodes = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = " sell get cash" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 10, desc = " sell to get gold" },

    },
    Strawberry = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = " sell get cash" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 10, desc = " sell to get gold" },

    },
    Blackwater = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = " sell get cash" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 10, desc = " sell to get gold" },

    },
    Armadillo = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = " sell get cash" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 10, desc = " sell to get gold" },

    },
    Tumbleweed = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = " sell get cash" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 10, desc = " sell to get gold" },

    },
    SaintDenis = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = " sell get cash" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 10, desc = " sell to get gold" },

    }
}

--------- BUY ITEMS --------
Config.BuyItems = {
    Valentine = {
        { itemLabel = "Gold ", itemName = "golden_nugget", currencyType = "cash", price = 1, desc = "buy with cash gold nuget " },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "gold", price = 40, desc = "buy with gold Pick Axe " },


    },
    Rhodes = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = "apple desc cash" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 1, desc = "buy water with gold" },

    },
    Strawberry = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = "apple desc cash" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 1, desc = "buy water with gold" },

    },
    Blackwater = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = "apple desc cash" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 1, desc = "buy water with gold" },

    },
    Armadillo = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = "apple desc cash" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 1, desc = "buy water with gold" },

    },
    Tumbleweed = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = "apple desc cash" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 1, desc = "buy water with gold" },

    },
    SaintDenis = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = "apple desc cash" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 1, desc = "buy water with gold" },

    }

}