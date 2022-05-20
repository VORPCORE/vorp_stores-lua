Config = {}

-- TODO
-- CAMERA FACE NPC
-- NPC ANIMATION

--menu position
-- "center" / "top-left" / "top-right"
Config.Align = "top-left"

Config.defaultlang = "en_lang"

-- open stores
Config.Key = 0x760A9C6F --[G]



--- STORES ---
Config.Stores = {
    Valentine = {
        blipAllowed = true,
        BlipName = 'valentine store',
        storeName = 'valentine ',
        PromptName = "general store",
        sprite = 90287351,
        x = -380.723, y = 825.3263, z = 116.00, h = 100.00, --blip/ prompt and npc positions
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        AllowedJobs = {}, -- empty everyone can use
        JobGrade = 0, -- rank allowed
        category = { "food", "tools" }, -- you need to add the same words to the sellitems and buyitems category you can add new categories as long the items have the category names
        storeType = { "sell", "buy" } -- choose the storetype
    },

    Rhodes = {
        blipAllowed = true,
        BlipName = 'Rhodes Store',
        storeName = 'Rhodes',
        PromptName = " general sell store",
        sprite = 90287351,
        x = -345.014, y = 840.3168, z = 116.63, h = 100.00,
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        AllowedJobs = { "police", "sheriff" }, -- jobs allowed
        JobGrade = 0,
        category = { "food", "tools", "meds" },
        storeType = { "sell" } -- only one type

    },
}


----------------------------------------------- STORE ITEMS --------------------------------------------------------------

-- ItemLable = translate here
-- itemName = same as in your databse
-- curencytype = "cash" or "gold" only use one.
-- price = numbers only
-- desc = a description of the item
-- category = where the item will be displayed at

---------------------------------------------------- SELL ITEMS --------------------------------------------------------------
Config.SellItems = {
    Valentine = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", sellprice = 10, desc = "sell apples", category = "food" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", sellprice = 40, desc = "sell bandage", category = "meds" },

    },
    Rhodes = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", sellprice = 50, desc = " sell get cash", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", sellprice = 10, desc = " sell to get gold", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", sellprice = 40, desc = "sell bandage", category = "meds" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
    }
}

------------------------------------------------------ BUY ITEMS ---------------------------------------------------------
Config.BuyItems = {
    Valentine = {
        { itemLabel = "Gold nugget", itemName = "golden_nugget", currencyType = "gold", buyprice = 10, desc = " buy gold nuget ", category = "food" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", buyprice = 40, desc = " buy Pick Axe ", category = "tools" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", buyprice = 40, desc = " buy bandage", category = "meds" },

    },

    Rhodes = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", buyprice = 50, desc = " buy apple ", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", buyprice = 10, desc = "buy water ", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", buyprice = 40, desc = "buy bandage", category = "meds" },
        { itemLabel = "Gold nugget", itemName = "golden_nugget", currencyType = "gold", buyprice = 10, desc = " buy gold nuget ", category = "food" },
    }
}
