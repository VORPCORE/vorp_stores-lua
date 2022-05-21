Config = {}

-- TODO
-- CAMERA FACE NPC
-- NPC ANIMATION

--menu position
-- "center" / "top-left" / "top-right"
Config.Align = "center"

Config.defaultlang = "en_lang"

-- open stores
Config.Key = 0x760A9C6F --[G]



--- STORES ---
Config.Stores = {
    Valentine = {
        blipAllowed = true,
        BlipName = "valentine store",
        storeName = "valentine",
        PromptName = "general store",
        sprite = 1475879922,
        x = -324.628, y = 803.9818, z = 116.88, h = -81.17, --blip/ prompt and npc positions
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "U_M_M_NbxGeneralStoreOwner_01",
        AllowedJobs = {}, -- empty everyone can use
        JobGrade = 0, -- rank allowed
        category = { "food", "tools", "meds" }, -- you need to add the same words to the sellitems and buyitems category you can add new categories as long the items have the category names
        storeType = { "sell", "buy" } -- choose the storetype
    },

    Rhodes = {
        blipAllowed = true,
        BlipName = "Rhodes Store",
        storeName = "Rhodes",
        PromptName = " general store",
        sprite = 1475879922,
        x = 1330.227, y = -1293.41, z = 76.021, h = 68.88,
        distanceOpenStore = 5.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        AllowedJobs = { "police", "sheriff" }, -- jobs allowed
        JobGrade = 0,
        category = { "food", "tools", "meds" },
        storeType = { "sell", "buy" } --remove one

    },
    Strawberry = {
        blipAllowed = true,
        BlipName = "Strawberry Store",
        storeName = "Strawberry",
        PromptName = "general store",
        sprite = 1475879922,
        x = -1789.66, y = -387.918, z = 159.32, h = 56.96,
        distanceOpenStore = 5.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        AllowedJobs = {}, -- jobs allowed
        JobGrade = 0,
        category = { "food", "tools", "meds" },
        storeType = { "sell", "buy" }

    },
    Blackwater = {
        blipAllowed = true,
        BlipName = "Blackwater Store",
        storeName = "Blackwater",
        PromptName = "general store",
        sprite = 1475879922,
        x = -784.738, y = -1321.73, z = 42.884, h = 179.63,
        distanceOpenStore = 5.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_UNIBUTCHERS_01",
        AllowedJobs = {}, -- jobs allowed
        JobGrade = 0,
        category = { "food", "tools", "meds" },
        storeType = { "sell", "buy" } -- only one type

    },
    Armadillo = {
        blipAllowed = true,
        BlipName = "Armadillo Store",
        storeName = "Armadillo",
        PromptName = "general store",
        sprite = 1475879922,
        x = -3687.34, y = -2623.53, z = -13.43, h = -85.32,
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "U_M_M_NbxGeneralStoreOwner_01",
        AllowedJobs = {}, -- jobs allowed
        JobGrade = 0,
        category = { "food", "tools", "meds" },
        storeType = { "sell", "buy" } -- only one type

    },
    Tumbleweed = {
        blipAllowed = true,
        BlipName = "Tumbleweed Store",
        storeName = "Tumbleweed",
        PromptName = "general store",
        sprite = 1475879922,
        x = -5485.70, y = -2938.08, z = -0.299, h = 127.72,
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "U_M_M_NbxGeneralStoreOwner_01",
        AllowedJobs = {}, -- jobs allowed
        JobGrade = 0,
        category = { "food", "tools", "meds" },
        storeType = { "sell", "buy" } -- only one type

    },
    StDenis = {
        blipAllowed = true,
        BlipName = "ST Denis Store",
        storeName = "ST Denis",
        PromptName = "general store",
        sprite = 1475879922,
        x = 2824.863, y = -1319.74, z = 45.755, h = -39.61,
        distanceOpenStore = 2.0,
        NpcAllowed = true,
        NpcModel = "U_M_M_NbxGeneralStoreOwner_01",
        AllowedJobs = {}, -- jobs allowed
        JobGrade = 0,
        category = { "food", "tools", "meds" },
        storeType = { "sell", "buy" } -- only one type

    },
    Vanhorn = {
        blipAllowed = true,
        BlipName = "Vanhorn Store",
        storeName = "Vanhorn",
        PromptName = "general store",
        sprite = 1475879922,
        x = 3025.420, y = 561.7910, z = 43.722, h = -99.20,
        distanceOpenStore = 2.5,
        NpcAllowed = true,
        NpcModel = "U_M_M_NbxGeneralStoreOwner_01",
        AllowedJobs = {}, -- jobs allowed
        JobGrade = 0,
        category = { "food", "tools", "meds" },
        storeType = { "sell", "buy" } -- only one type

    },
    BlackwaterFishing = {
        blipAllowed = true,
        BlipName = "Fishing store",
        storeName = "Bait Shop",
        PromptName = "fishing store",
        sprite = 3442726182,
        x = -757.069, y = -1360.76, z = 43.724, h = -90.80,
        distanceOpenStore = 2.5,
        NpcAllowed = false,
        NpcModel = "U_M_M_NbxGeneralStoreOwner_01",
        AllowedJobs = {}, -- jobs allowed
        JobGrade = 0,
        category = { "bait", "tools", },
        storeType = { "sell", "buy" } -- only one type

    },
    Wapiti = {
        blipAllowed = true,
        BlipName = "Wapiti store",
        storeName = "Wapiti Shop",
        PromptName = "Native store",
        sprite = 1475879922,
        x = 449.7435, y = 2216.437, z = 245.30, h = -73.78,
        distanceOpenStore = 2.5,
        NpcAllowed = true,
        NpcModel = "CS_EagleFlies",
        AllowedJobs = {}, -- jobs allowed
        JobGrade = 0,
        category = { "food", "tools", },
        storeType = { "sell", "buy" } -- only one type

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
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", sellprice = 10, desc = "sell apples", category = "food" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", sellprice = 40, desc = "sell bandage", category = "meds" },

    },
    Rhodes = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", sellprice = 50, desc = "sell", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", sellprice = 10, desc = "sell", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", sellprice = 40, desc = "sell bandage", category = "meds" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
    },
    Strawberry = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", sellprice = 50, desc = "sell", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", sellprice = 10, desc = "sell", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", sellprice = 40, desc = "sell bandage", category = "meds" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
    },
    Blackwater = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", sellprice = 50, desc = "sell", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", sellprice = 10, desc = "sell", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", sellprice = 40, desc = "sell bandage", category = "meds" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
    },
    Armadillo = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", sellprice = 50, desc = "sell", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", sellprice = 10, desc = "sell", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", sellprice = 40, desc = "sell bandage", category = "meds" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
    },
    Tumbleweed = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", sellprice = 50, desc = "sell", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", sellprice = 10, desc = "sell", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", sellprice = 40, desc = "sell bandage", category = "meds" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
    },
    StDenis = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", sellprice = 50, desc = "sell", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", sellprice = 10, desc = "sell", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", sellprice = 40, desc = "sell bandage", category = "meds" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
    },
    Vanhorn = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", sellprice = 50, desc = "sell", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", sellprice = 10, desc = "sell", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", sellprice = 40, desc = "sell bandage", category = "meds" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
    },
    BlackwaterFishing = {
        { itemLabel = "Bait", itemName = "Bait", currencyType = "cash", sellprice = 50, desc = "sell Bait", category = "bait" },
        { itemLabel = "Fish Bait", itemName = "fishbait", currencyType = "cash", sellprice = 10, desc = "sell", category = "bait" },
        { itemLabel = "Bread Bait", itemName = "p_baitBread01x", currencyType = "cash", sellprice = 40, desc = "sell", category = "bait" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
    },
    Wapiti = {
        { itemLabel = "Bait", itemName = "Bait", currencyType = "cash", sellprice = 50, desc = " sell Bait", category = "bait" },
        { itemLabel = "Fish Bait", itemName = "fishbait", currencyType = "cash", sellprice = 10, desc = " sell ", category = "bait" },
        { itemLabel = "Bread Bait", itemName = "p_baitBread01x", currencyType = "cash", sellprice = 40, desc = "sell ", category = "bait" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", sellprice = 40, desc = "sell pick axe", category = "tools" },
    },
}

------------------------------------------------------ BUY ITEMS ---------------------------------------------------------
Config.BuyItems = {
    Valentine = {
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", buyprice = 40, desc = "buy Pick Axe", category = "tools" },
        { itemLabel = "Gold nugget", itemName = "golden_nugget", currencyType = "gold", buyprice = 10, desc = "buy gold nuget", category = "food" },
        { itemLabel = "Pick Axe", itemName = "pickaxe", currencyType = "cash", buyprice = 40, desc = "buy Pick Axe", category = "tools" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", buyprice = 40, desc = "buy bandage", category = "meds" },

    },

    Rhodes = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", buyprice = 50, desc = "buy apple", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", buyprice = 10, desc = "buy water", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", buyprice = 40, desc = "buy bandage", category = "meds" },
        { itemLabel = "Gold nugget", itemName = "golden_nugget", currencyType = "gold", buyprice = 10, desc = "buy gold nuget", category = "food" },
    },

    Strawberry = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", buyprice = 50, desc = "buy apple", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", buyprice = 10, desc = "buy water", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", buyprice = 40, desc = "buy bandage", category = "meds" },

    },

    Blackwater = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", buyprice = 50, desc = "buy apple", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", buyprice = 10, desc = "buy water", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", buyprice = 40, desc = "buy bandage", category = "meds" },

    },
    Armadillo = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", buyprice = 50, desc = "buy apple", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", buyprice = 10, desc = "buy water", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", buyprice = 40, desc = "buy bandage", category = "meds" },

    },
    Tumbleweed = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", buyprice = 50, desc = "buy apple", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", buyprice = 10, desc = "buy water", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", buyprice = 40, desc = "buy bandage", category = "meds" },

    },
    StDenis = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", buyprice = 50, desc = "buy apple", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", buyprice = 10, desc = "buy water", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", buyprice = 40, desc = "buy bandage", category = "meds" },

    },
    Vanhorn = {
        { itemLabel = "Apple", itemName = "apple", currencyType = "cash", buyprice = 50, desc = "buy apple", category = "food" },
        { itemLabel = "Water", itemName = "water", currencyType = "cash", buyprice = 10, desc = "buy water", category = "food" },
        { itemLabel = "bandage", itemName = "bandage", currencyType = "cash", buyprice = 40, desc = "buy bandage", category = "meds" },

    },
    BlackwaterFishing = {
        { itemLabel = "Bait", itemName = "bait", currencyType = "cash", buyprice = 50, desc = "buy Bait", category = "bait" },
        { itemLabel = "Fish Bait", itemName = "fishbait", currencyType = "cash", buyprice = 10, desc = "buy", category = "bait" },
        { itemLabel = "Bread Bait", itemName = "p_baitBread01x", currencyType = "cash", buyprice = 40, desc = "buy", category = "bait" },

    },
    Wapiti = {
        { itemLabel = "Bait", itemName = "bait", currencyType = "cash", buyprice = 50, desc = "buy Bait", category = "bait" },
        { itemLabel = "Fish Bait", itemName = "fishbait", currencyType = "cash", buyprice = 10, desc = "buy", category = "bait" },
        { itemLabel = "Bread Bait", itemName = "p_baitBread01x", currencyType = "cash", buyprice = 40, desc = "buy", category = "bait" },

    }
}
