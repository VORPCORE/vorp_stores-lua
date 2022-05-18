Config = {}

-- TODO
-- ADD BLUR
-- CAMERA FACE NPC
-- CINEMATIC
-- NPC ANIMATION
-- TYPE SELL OR BUY
-- jobrank


--- MENU POSITION ---

-- "center" / "top-left" / "top-right"
Config.Align = "center"

--- CHOOSE LANGUAGE IF AVAILABLE ---
Config.defaultlang = "en_lang"

-- open stores
Config.Key = 0x39336A4F --Space



--- STORES ---
Config.Stores = {
    Val = {
        blipAllowed = true,
        BlipName = 'valentine store',
        storeName = 'valentine ',
        PromptName = "general store",
        Actions = { sell = true, buy = false },
        sprite = 90287351,
        x = -380.723, y = 825.3263, z = 116.00, h = 100.00, --blip/ prompt and npc positions
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        AllowedJobs = {} -- empty everyone can use

    },

    Rhodes = {
        blipAllowed = true,
        BlipName = 'Rhodes Store',
        storeName = 'Rhodes',
        Actions = { "sell" },
        PromptName = " general sell store",
        sprite = 90287351,
        x = -345.014, y = 840.3168, z = 116.63, h = 100.00,
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        AllowedJobs = { "police", "sheriff" } -- -- jobs allowed

    },
}


----------------------------------------------- STORE ITEMS --------------------------------------------------------------
-- curencytype "cash" or "gold"

---- SELL ITEMS -----------
Config.SellItems = {
    Val = {
        { itemLabel = "banana ", itemName = "apple", currencyType = "cash", price = 1, desc = "sell with cash", category = "food" },
        { itemLabel = "Pick", itemName = "pickaxe", currencyType = "cash", price = 40, desc = "sell with gold pick axe", category = "tools" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", price = 40, desc = "sell bandage", category = "tools" },

    },
    Rhodes = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = " sell get cash", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 10, desc = " sell to get gold", category = "tools" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", price = 40, desc = "sell bandage", category = "meds" },
    }
}



--------- BUY ITEMS --------
Config.BuyItems = {
    Val = {
        { itemLabel = "Gold", itemName = "golden_nugget", currencyType = "cash", price = 1, desc = "buy with cash gold nuget ", category = "food" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "gold", price = 40, desc = "buy with gold Pick Axe ", category = "tools" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", price = 40, desc = "sell bandage", category = "meds" },

    },

    Rhodes = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", price = 50, desc = "apple desc cash", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", price = 1, desc = "buy water with gold", category = "tools" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", price = 40, desc = "sell bandage", category = "meds" },
    }
}
