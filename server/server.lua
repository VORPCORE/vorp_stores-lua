local Core <const> = exports.vorp_core:GetCore()
local storeLimits = {}
local T <const> = TranslationStores.Langs[Lang]


-- * STORE ITEM SELL/BUY LIMITS * --
CreateThread(function()
    local sellItems <const> = Config.SellItems
    local buyItems <const> = Config.BuyItems

    for index, v in pairs(sellItems) do
        for _, value in pairs(v) do
            if value.itemLimit and value.itemLimit > 0 then
                storeLimits[index] = storeLimits[index] or {}
                table.insert(storeLimits[index], {
                    itemName = value.itemName,
                    amount = value.itemLimit,
                    type = "sell"
                })
            end
        end
    end

    for key, value in pairs(buyItems) do
        for _, v in pairs(value) do
            if v.itemLimit and v.itemLimit > 0 then
                storeLimits[key] = storeLimits[key] or {}
                table.insert(storeLimits[key], {
                    itemName = v.itemName,
                    amount = v.itemLimit,
                    type = "buy"
                })
            end
        end
    end
end)

local function DiscordLog(message)
    if Config.UseWebhook == true then
        local WebhookUrl = "" -- add webhook link here
        Core.AddWebhook(Config.WebhookLanguage.WebhookTitle, WebhookUrl, message, Config.WebhookLanguage.WebhookColor, Config.WebhookLanguage.WebhookName, Config.WebhookLanguage.WebhookLogo, Config.WebhookLanguage.WebhookLogo2, Config.WebhookLanguage.WebhookAvatar)
    end
end

local function checkStoreLimits(storeId, ItemName, quantity, action)
    if not storeLimits[storeId] then
        return true
    end
    for k, v in pairs(storeLimits[storeId]) do
        if action == "sell" then
            if v.itemName == ItemName and v.type == "buy" then
                v.amount = v.amount + quantity
            end
            if v.itemName == ItemName and v.type == "sell" then
                v.amount = v.amount - quantity
            end
        end

        if action == "buy" then
            if v.itemName == ItemName and v.type == "buy" then
                if v.amount >= quantity then
                    v.amount = v.amount - quantity
                    return true
                else
                    return false
                end
            end
        end
    end
    return true
end

local function sellItems(_source, Character, value, ItemName, storeId)
    local fname = Character.firstname
    local lname = Character.lastname
    local canContinue = false

    local total = value.price * value.quantity
    local total2 = (math.floor(total * 100) / 100)

    if value.weapon then
        local countWeap = 0
        local userWeapons = exports.vorp_inventory:getUserInventoryWeapons(_source)

        for _, v in pairs(userWeapons) do
            if v.name == ItemName then
                exports.vorp_inventory:subWeapon(_source, v.id)
                exports.vorp_inventory:deleteWeapon(_source, v.id)
                canContinue = true
                countWeap = countWeap + 1
                if countWeap == value.quantity then
                    break
                end
            end
        end

        if countWeap == 0 then
            return Core.NotifyObjective(_source, T.noManyQty, 5000)
        end

        total = value.price * countWeap
        total2 = (math.floor(total * 100) / 100)
    else
        local userItem = exports.vorp_inventory:getItemById(_source, value.item.id)
        if userItem then
            if ItemName == userItem.name then
                if userItem.count >= value.quantity then
                    exports.vorp_inventory:subItemById(_source, value.item.id, nil, nil, value.quantity)
                    if Config.AllowSellItemsWithDecay and Config.SellItemBasedOnPercentage and userItem.isDegradable then
                        total = value.price * value.quantity * (userItem.percentage / 100) -- use percentage that we got when we requested items so the price is the same
                        total2 = math.floor(total * 100) / 100
                    end
                    canContinue = true
                end
            end
        end
    end

    if not canContinue then
        return Core.NotifyObjective(_source, T.noManyQty, 5000)
    end

    if Config.Stores[storeId].DynamicStore then
        if not checkStoreLimits(storeId, ItemName, value.quantity, "sell") then
            return Core.NotifyRightTip(_source, T.limitBuy, 3000)
        end
    end


    if value.currency == "cash" then
        Character.addCurrency(0, total)
        Core.NotifyRightTip(_source, T.yousold .. value.quantity .. " " .. value.label .. T.frcash .. total2 .. T.ofcash, 3000)
        DiscordLog(fname .. " " .. lname .. T.hassold .. " " .. value.quantity .. value.label .. T.frcash .. total2 .. T.ofcash)
    end

    if value.currency == "gold" then
        Character.addCurrency(1, total)
        Core.NotifyRightTip(_source, T.yousold .. value.quantity .. " " .. value.label .. T.fr .. total2 .. T.ofgold, 3000)
        DiscordLog(fname .. " " .. lname .. T.hassold .. " " .. value.quantity .. value.label .. T.fr .. total2 .. T.ofgold)
    end
end

local function buyItems(_source, Character, value, ItemName, storeId)
    local fname = Character.firstname
    local lname = Character.lastname
    local money = Character.money
    local gold = Character.gold
    local total = value.price
    local total2 = (math.floor(total * 100) / 100)


    if value.currency == "cash" then
        if money < total then
            return Core.NotifyRightTip(_source, T.youdontcash, 3000)
        end

        if value.weapon then
            for i = 1, value.quantity, 1 do
                exports.vorp_inventory:createWeapon(_source, ItemName)
            end
        else
            exports.vorp_inventory:addItem(_source, ItemName, value.quantity)
        end

        if Config.Stores[storeId].DynamicStore then
            if not checkStoreLimits(storeId, ItemName, value.quantity, "buy") then
                return Core.NotifyRightTip(_source, T.limitBuy, 3000)
            end
        end

        Character.removeCurrency(0, total)
        Character.money = Character.money - total
        Core.NotifyRightTip(_source, T.youbought .. value.quantity .. " " .. value.label .. T.frcash .. total2 .. T.ofcash, 3000)
        DiscordLog(fname .. " " .. lname .. T.hasbought .. " " .. value.quantity .. value.label .. T.frcash .. total2 .. T.ofcash)
        return
    end


    if value.currency == "gold" then
        if gold < total then
            return Core.NotifyRightTip(_source, T.youdontgold, 3000)
        end

        if value.weapon then
            for i = 1, value.quantity, 1 do
                exports.vorp_inventory:createWeapon(_source, ItemName)
            end
        else
            exports.vorp_inventory:addItem(_source, ItemName, value.quantity)
        end
        Character.removeCurrency(1, total)
        Core.NotifyRightTip(_source, T.youbought .. value.quantity .. " " .. value.label .. T.fr .. total2 .. T.ofgold, 3000)
        DiscordLog(fname .. " " .. lname .. T.hasbought .. " " .. value.quantity .. value.label .. T.fr .. total2 .. T.ofgold)

        if Config.Stores[storeId].DynamicStore then
            if not checkStoreLimits(storeId, ItemName, value.quantity, "buy") then
                return Core.NotifyRightTip(_source, T.limitBuy, 3000)
            end
        end
    end
end



-- * EVENTS * --
RegisterServerEvent('vorp_stores:Client:sellItems', function(dataItems, storeId)
    local _source = source
    local User = Core.getUser(_source)

    if not User then return end

    local Character = User.getUsedCharacter

    for ItemName, value in pairs(dataItems) do
        Wait(200)
        if value.quantity > 0 then
            sellItems(_source, Character, value, ItemName, storeId)
        end
    end
end)


RegisterServerEvent('vorp_stores:Client:buyItems', function(dataItems, storeId)
    local _source = source
    local User = Core.getUser(_source)

    if not User then return end

    local Character = User.getUsedCharacter

    for ItemName, value in pairs(dataItems) do
        Wait(200)

        if not value.weapon then
            local quantity = value.quantity
            local canCarry = exports.vorp_inventory:canCarryItem(_source, ItemName, quantity) --cancarry item limit
            if not canCarry then
                return Core.NotifyRightTip(_source, T.cantcarryitem, 3000)
            end

            buyItems(_source, Character, value, ItemName, storeId)
        end

        if value.weapon then
            local quantity = value.quantity
            local canCarryWep = exports.vorp_inventory:canCarryWeapons(_source, quantity, nil, ItemName) --can carry weapons

            if not canCarryWep then
                return Core.NotifyRightTip(_source, T.cantcarryweapon, 5000)
            end

            buyItems(_source, Character, value, ItemName, storeId)
        end
    end
end)


-- * CALLBACKS * --
Core.Callback.Register('vorp_stores:callback:getShopStock', function(source, cb, args)
    local items = Config.SellItems[args]
    local ItemsFound = false
    local PlayerItems = {}
    local userInv = exports.vorp_inventory:getUserInventoryItems(source)
    local userWeapons = exports.vorp_inventory:getUserInventoryWeapons(source)
    for _, value in pairs(userInv) do
        for _, v in ipairs(items) do
            if value.name == v.itemName then
                -- if config says no decay allowed then only get items with no decay
                if Config.AllowSellItemsWithDecay then
                    if value.isDegradable then
                        -- item is degradable

                        if value.percentage > Config.DecayPercentage then
                            -- percentage is met, remember decay is still counting while in menu
                            ItemsFound = true
                            PlayerItems[value.name] = value
                        end
                    else
                        -- items that arent degradable
                        ItemsFound = true
                        PlayerItems[value.name] = value
                    end
                else
                    if not value.isDegradable then
                        -- only items with no decay are allowed
                        ItemsFound = true
                        PlayerItems[value.name] = value
                    end
                end
            end
        end
    end

    for _, value in pairs(userWeapons) do
        for _, v in pairs(items) do
            if value.name == v.itemName then
                local count = 1
                ItemsFound = true
                if PlayerItems[value.name] == nil then
                    PlayerItems[value.name] = {}
                    PlayerItems[value.name].count = count
                else
                    PlayerItems[value.name].count = PlayerItems[value.name].count + count
                end
            end
        end
    end

    if not ItemsFound then
        ItemsFound = false
        Core.NotifyRightTip(source, T.notAllowItem, 3000)
        return cb(false)
    end

    local data = {
        shopStocks = storeLimits[args],
        ItemsFound = PlayerItems
    }
    return cb(data)
end)

Core.Callback.Register('vorp_stores:callback:ShopStock', function(source, cb, args)
    local data = {
        shopStock = storeLimits[args]
    }
    return cb(data)
end)


local storesInUse = {}
Core.Callback.Register("vorp_stores:callback:canOpenStore", function(source, cb, storeIndex)
    local _source = source

    if not storesInUse[storeIndex] then
        storesInUse[storeIndex] = _source
        return cb(true)
    end

    return cb(false)
end)

Core.Callback.Register("vorp_stores:callback:CloseStore", function(source, cb, storeIndex)
    if storesInUse[storeIndex] then
        storesInUse[storeIndex] = nil
        return cb(true)
    end
    return cb(false)
end)

-- * LOGIC FOR RANDOM PRICES * --
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for storeId, storeConfig in pairs(Config.Stores) do
        if storeConfig.RandomPrices then
            for index, storeItem in ipairs(Config.SellItems[storeId] or {}) do
                Config.SellItems[storeId][index].sellprice = storeItem.randomprice
            end
            for index, storeItem in ipairs(Config.BuyItems[storeId] or {}) do
                Config.BuyItems[storeId][index].buyprice = storeItem.randomprice
            end
        end
        if storeConfig.useRandomLocation then
            local randomLocation = math.random(1, #storeConfig.possibleLocations.OpenMenu)
            Config.Stores[storeId].Blip.Pos = storeConfig.possibleLocations.OpenMenu[randomLocation]
            Config.Stores[storeId].Npc.Pos = storeConfig.possibleLocations.Npcs[randomLocation]
        end
    end
end)



RegisterServerEvent('vorp_stores:GetRefreshedPrices', function()
    local _source = source
    local msgpack = msgpack.pack(Config.SellItems, Config.BuyItems, Config.Stores)
    TriggerClientEvent('vorp_stores:RefreshStorePrices', _source, msgpack)
end)


-- event drrop player
AddEventHandler('playerDropped', function(reason)
    local _source = source
    for k, v in pairs(storesInUse) do
        if v == _source then
            storesInUse[k] = nil
        end
    end
end)
