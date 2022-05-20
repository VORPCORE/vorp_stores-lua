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
Config.Key = 0x39336A4F --[Space]



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
        AllowedJobs = {}, -- empty everyone can use
        JobGrade = 0, -- rank allowed
        -- todo have stores decide which categories to have
        category = { "Food", "tools", "meds" }, -- you need to add the same to the items category
        categoryDescription = { "get some food", "get some meds" }
    },

    Rhodes = {
        blipAllowed = true,
        BlipName = 'Rhodes Store',
        storeName = 'Rhodes',
        Actions = { sell = true, buy = false },
        PromptName = " general sell store",
        sprite = 90287351,
        x = -345.014, y = 840.3168, z = 116.63, h = 100.00,
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        AllowedJobs = { "police", "sheriff" }, -- jobs allowed
        JobGrade = 1,
        -- todo have stores decide which categories to have
        category = { "Food", "tools", "meds" },
        categoryDescription = { "get some food", "get some tools", "get some meds" }

    },
}


----------------------------------------------- STORE ITEMS --------------------------------------------------------------

-- ItemLable = translate here
-- itemName = same as in your databse
-- curencytype = "cash" or "gold" only use one.
-- price = numbers only
-- desc = a description of the item
-- category = where the item will be displayed at

---- SELL ITEMS -----------
Config.SellItems = {
    Val = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", sellprice = 10, desc = "fresh apples", category = "Food" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "gold", sellprice = 40, desc = "sell pick axe", category = "tools" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", sellprice = 40, desc = "sell bandage", category = "meds" },

    },
    Rhodes = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", sellprice = 50, desc = " sell get cash", category = "Food" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", sellprice = 10, desc = " sell to get gold", category = "Food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", sellprice = 40, desc = "sell bandage", category = "meds" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "gold", sellprice = 40, desc = "sell pick axe", category = "tools" },
    }
}



--------- BUY ITEMS --------
Config.BuyItems = {
    Val = {
        { itemLabel = "Gold nugget", itemName = "golden_nugget", currencyType = "gold", buyprice = 10, desc = " gold nuget ", category = "Food" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", buyprice = 40, desc = " Pick Axe ", category = "tools" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", buyprice = 40, desc = "bandage", category = "meds" },

    },

    Rhodes = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", buyprice = 50, desc = "apple desc cash", category = "Food" },
        { itemLabel = "Water", itemName = "water", currencyType = "gold", buyprice = 10, desc = "buy water with gold", category = "Food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", buyprice = 40, desc = "sell bandage", category = "meds" },
        { itemLabel = "Gold nugget", itemName = "golden_nugget", currencyType = "gold", buyprice = 10, desc = " gold nuget ", category = "Food" },
    }
}
