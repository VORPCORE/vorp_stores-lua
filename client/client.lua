local OpenStores = 0
local PromptGroup <const> = GetRandomIntInRange(0, 0xffffff)
local isInMenu = false
local MenuData = exports.vorp_menu:GetMenuData()
local Core = exports.vorp_core:GetCore()
local __StoreInUse = nil
local imgPathMenu = "<img style='max-height:120px;max-width:120px;float: center;' src='nui://vorp_stores/images/%s.png'><br>"
local imgPath = "<img style='max-height:64px;max-width:64px; float:%s; margin-top: -5px;' src='nui://vorp_inventory/html/img/items/%s.png'>"
local font = '<span style="font-family: crock; src:nui://vorp_menu/html/fonts/crock.ttf) format("truetype")</span>'
local T <const> = TranslationStores.Langs[Lang]

local function CheckJobs(store)
    local data = Config.Stores[store]

    if not next(data.AllowedJobs) then
        return true
    end

    local job = LocalPlayer.state.Character.Job
    local grade = LocalPlayer.state.Character.Grade

    for _, v in ipairs(data.AllowedJobs) do
        if v == job and grade >= data.JobGrade then
            return true
        end
    end

    return false
end

local function AddBlip(Store)
    if not CheckJobs(Store) then return end
    local value = Config.Stores[Store]
    local blip  = BlipAddForCoords(1664425300, value.Blip.Pos.x, value.Blip.Pos.y, value.Blip.Pos.z)
    SetBlipSprite(blip, value.Blip.sprite, false)
    BlipAddModifier(blip, joaat("BLIP_MODIFIER_MP_COLOR_32"))
    SetBlipName(blip, value.Blip.Name)
    value.Blip.BlipHandle = blip
end

local function GetPlayerDistanceFromCoords(vector)
    local playerPos = GetEntityCoords(PlayerPedId())
    return #(playerPos - vector)
end

local function SpawnNPC(Store)
    local value = Config.Stores[Store]
    local npcModel <const> = value.Npc.Model

    if not IsModelValid(npcModel) then
        return print(("Invalid npc model for %s (%s)."):format(Store, value.Npc.Model))
    end

    if not HasModelLoaded(npcModel) then
        RequestModel(npcModel, false)
        repeat Wait(100) until HasModelLoaded(npcModel)
    end

    local ped = CreatePed(npcModel, value.Npc.Pos.x, value.Npc.Pos.y, value.Npc.Pos.z, value.Npc.Pos.w, false, false, false, false)
    repeat Wait(100) until DoesEntityExist(ped)
    SetRandomOutfitVariation(ped, true)
    PlaceEntityOnGroundProperly(ped)
    SetEntityCanBeDamaged(ped, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    value.Npc.NpcHandle = ped
end

local function setUpPrompt()
    OpenStores = UiPromptRegisterBegin()
    UiPromptSetControlAction(OpenStores, Config.Key)
    local label = CreateVarString(10, 'LITERAL_STRING', T.SubPrompt)
    UiPromptSetText(OpenStores, label)
    UiPromptSetEnabled(OpenStores, true)
    UiPromptSetVisible(OpenStores, true)
    UiPromptSetStandardMode(OpenStores, true)
    UiPromptSetGroup(OpenStores, PromptGroup, 0)
    UiPromptRegisterEnd(OpenStores)
end

local function showPrompt(label, action)
    local labelToDisplay = CreateVarString(10, 'LITERAL_STRING', label)
    UiPromptSetActiveGroupThisFrame(PromptGroup, labelToDisplay, 0, 0, 0, 0)

    if UiPromptHasStandardModeCompleted(OpenStores, 0) then
        Wait(100)
        return action
    end
end

local function CheckStoreInUse(storeId)
    Core.Callback.TriggerAsync("vorp_stores:callback:canOpenStore", function(canOpen)
        if canOpen then
            OpenCategory(storeId)
            DisplayRadar(false)
            TaskStandStill(PlayerPedId(), -1)
            __StoreInUse = storeId
        else
            Core.NotifyObjective(T.StoreInUse, 5000)
        end
    end, storeId)
end

-- use this event from server side to actvate a store or deactivate based on what you want , like only open for this client via a command etc
RegisterNetEvent("vorp_stores:Server:ChangeStoreStatus", function(storeId, status)
    if not Config.Stores[storeId] then
        return print("Store not found in vorp stores configs")
    end
    Config.Stores[storeId].isDeactivated = status
end)

-- use this event client side to open a store from your scripts make sure locations match for security checks
AddEventHandler("vorp_stores:Client:OpenShop", function(storeId)
    local storeConfig = Config.Stores[storeId]
    if not storeConfig then
        return print("Store not found in vorp stores configs")
    end

    local distance = GetPlayerDistanceFromCoords(storeConfig.Blip.Pos)
    if distance <= storeConfig.distanceOpenStore then
        local canOpen = Core.Callback.TriggerAwait("vorp_stores:callback:canOpenStore", storeId)
        if not canOpen then
            return Core.NotifyObjective(T.StoreInUse, 5000)
        end
        __StoreInUse = storeId
        OpenCategory(storeId)
    else
        print("this event was fired but player is not near the location to open store")
    end
end)


local function storeOpen(storeConfig, storeId)
    local distance = GetPlayerDistanceFromCoords(storeConfig.Blip.Pos)

    if storeConfig.Blip.Allowed then
        if not Config.Stores[storeId].Blip.BlipHandle then
            AddBlip(storeId)
        else
            BlipAddModifier(Config.Stores[storeId].Blip.BlipHandle, joaat("BLIP_MODIFIER_MP_COLOR_32"))
        end
    end

    if storeConfig.Npc.Allowed then
        if distance < storeConfig.Npc.distanceRemoveNpc then
            if not Config.Stores[storeId].Npc.NpcHandle then
                SpawnNPC(storeId)
            end
        else
            if Config.Stores[storeId].Npc.NpcHandle then
                DeleteEntity(Config.Stores[storeId].Npc.NpcHandle)
                Config.Stores[storeId].Npc.NpcHandle = nil
            end
        end
    end

    local inDistance = (distance <= storeConfig.distanceOpenStore)
    if not next(storeConfig.AllowedJobs) then
        if inDistance then
            if (showPrompt(storeConfig.PromptName, "open") == "open") then
                CheckStoreInUse(storeId)
            end
        end
    else
        if inDistance then
            if not CheckJobs(storeId) then
                return
            end

            if (showPrompt(storeConfig.PromptName, "openJob") == "openJob") then
                CheckStoreInUse(storeId)
            end
        end
    end

    return inDistance
end

local function IsStoreClosed(storeConfig)
    local hour = GetClockHours()
    if hour >= storeConfig.StoreClose or hour < storeConfig.StoreOpen then
        return "closed"
    end
    return "opened"
end

local function closeAll()
    MenuData.CloseAll()
    isInMenu = false
    ClearPedTasksImmediately(PlayerPedId())
    DisplayRadar(true)
    Config.UI(false)
    Core.Callback.TriggerAsync("vorp_stores:callback:CloseStore", function()
        __StoreInUse = nil
    end, __StoreInUse)
end

-- * MAIN THREAD * --
CreateThread(function()
    repeat Wait(2000) until LocalPlayer.state.IsInSession
    setUpPrompt()

    while true do
        local sleep = 1000
        local player = PlayerPedId()
        local dead = IsEntityDead(player)

        if dead or isInMenu then
            goto skip
        end

        for storeId, storeConfig in pairs(Config.Stores) do
            if not storeConfig.isDeactivated then
                if storeConfig.StoreHoursAllowed then
                    if IsStoreClosed(storeConfig) == "closed" then
                        if storeConfig.Blip.BlipHandle then
                            BlipAddModifier(storeConfig.Blip.BlipHandle, joaat("BLIP_MODIFIER_MP_COLOR_2"))
                        end

                        if storeConfig.Npc.NpcHandle then
                            TaskWanderStandard(storeConfig.Npc.NpcHandle, 10.0, 10)
                            SetEntityAsNoLongerNeeded(storeConfig.Npc.NpcHandle)
                            DeleteEntity(storeConfig.Npc.NpcHandle)
                            storeConfig.Npc.NpcHandle = nil
                        end

                        local distance = GetPlayerDistanceFromCoords(storeConfig.Blip.Pos)

                        if (distance <= storeConfig.distanceOpenStore) then
                            sleep = 0
                            UiPromptSetEnabled(OpenStores, false)
                        end
                    else
                        UiPromptSetEnabled(OpenStores, true)
                        if storeOpen(storeConfig, storeId) then
                            sleep = 0
                        end
                    end
                else
                    if storeOpen(storeConfig, storeId) then
                        sleep = 0
                    end
                end
            end
        end

        :: skip ::
        Wait(sleep)
    end
end)



-- * MENU  * --
function OpenCategory(storeId)
    Config.UI(true)
    MenuData.CloseAll()
    isInMenu = true
    local elements = {}

    for k, value in pairs(Config.Stores[storeId].category) do
        elements[#elements + 1] = {
            label = value.label,
            value = value.Type,
            desc = imgPathMenu:format(value.img) .. " <br> " .. value.desc
        }
    end

    MenuData.Open('default', GetCurrentResourceName(), 'OpenCategory' .. storeId, {
        title = Config.Stores[storeId].storeName,
        subtext = T.SubMenu,
        align = Config.Align,
        elements = elements

    }, function(data, menu)
        OpenSubMenu(storeId, data.current.value)
    end, function(data, menu)
        closeAll()
    end)
end

-- * SUBMENU * --
function OpenSubMenu(storeId, category)
    MenuData.CloseAll()
    isInMenu = true
    local elements = {}

    for _, value in pairs(Config.Stores[storeId].storeType) do
        elements[#elements + 1] = {
            label = value.label,
            value = value.Type,
            desc = imgPathMenu:format(value.img) .. " <br> " .. value.desc
        }
    end

    MenuData.Open('default', GetCurrentResourceName(), 'OpenSubMenu' .. storeId .. category, {
        title = Config.Stores[storeId].storeName,
        subtext = T.SubMenu,
        align = Config.Align,
        elements = elements,
        lastmenu = "OpenCategory"

    }, function(data, menu)
        if (data.current == "backup") then
            _G[data.trigger](storeId, category)
        end

        if (data.current.value == "sell") then
            OpenSellMenu(storeId, category)
        end

        if (data.current.value == "buy") then
            OpenBuyMenu(storeId, category)
        end
    end, function(data, menu)
        closeAll()
    end)
end

function OpenSellMenu(storeId, category)
    MenuData.CloseAll()
    isInMenu = true
    local menuElements = {}
    local storeConfig = Config.Stores[storeId]
    local SellTable = {}
    local color = "Gold"
    local ctp = ""

    local result = Core.Callback.TriggerAwait('vorp_stores:callback:getShopStock', storeId)
    if not result then
        closeAll()
        return
    end

    local shopStocks  = result.shopStocks
    local playerItems = result.ItemsFound

    for _, storeItem in pairs(Config.SellItems[storeId]) do
        local itemFound = false
        for itemName, count in pairs(playerItems) do
            if itemName == storeItem.itemName then
                if storeItem.category == category then
                    if storeItem.currencyType == "cash" then
                        ctp = "$"
                        color = "Red"
                    end

                    if shopStocks[storeId] then
                        for _, items in pairs(shopStocks[storeId]) do
                            if items.itemName == storeItem.itemName and items.type == "sell" then
                                itemFound = true
                                menuElements[#menuElements + 1] = {
                                    label = imgPath:format("left", storeItem.itemName) .. storeItem.itemLabel ..
                                        " " .. T.forSale .. " <br> " .. items.amount .. " " .. T.avaliable,
                                    action = "sell",
                                    value = 0,
                                    min = 0,
                                    max = items.amount,
                                    type = "slider",
                                    desc = font .. T.sellfor ..
                                        '<span style="margin-left:90px;"><span style="font-size:25px;">' ..
                                        ctp .. '</span>' ..
                                        '<span style="font-size:30px;">' ..
                                        string.format("%.2f", storeItem.sellprice) ..
                                        "    </span><span style='color:" ..
                                        color .. ";'>   " .. storeItem.currencyType .. "</span><br><br>" ..
                                        storeItem.desc,
                                    info = storeItem,
                                    index = storeItem.itemName,

                                }
                            end
                        end
                    end

                    if not itemFound then
                        -- if not found in the stock allow to sell only what player holds
                        menuElements[#menuElements + 1] = {

                            label = imgPath:format("left", storeItem.itemName) ..
                                storeItem.itemLabel .. " " .. T.forSale .. " <br> " .. count .. " " .. T.avaliable,
                            action = "sell",
                            value = 0,
                            min = 0,
                            max = count,
                            type = "slider",
                            desc = font .. T.sellfor ..
                                '<span style="margin-left:90px;"><span style="font-size:25px;">' ..
                                ctp .. '</span>' ..
                                '<span style="font-size:30px;">' .. string.format("%.2f", storeItem.sellprice) ..
                                "    </span><span style='color:" ..
                                color .. ";'>   " .. storeItem.currencyType .. "</span><br><br>" ..
                                storeItem.desc,
                            info = storeItem,
                            index = storeItem.itemName
                        }
                    end
                end
            end
        end
    end

    if not next(menuElements) then
        print("No items found in this category for you to sell ")
        OpenCategory(storeId)
        return
    end

    menuElements[#menuElements + 1] = {
        label = T.totalToReceive .. " <br> " .. ctp .. 0,
        value = "sell",
        desc  = T.pressEnterToSell,
        info  = "finish"
    }

    MenuData.Open('default', GetCurrentResourceName(), 'OpenSellMenu' .. storeId .. category, {
        title = storeConfig.storeName,
        subtext = T.sellmenu,
        align = Config.Align,
        elements = menuElements,
        lastmenu = "OpenSubMenu",
        itemHeight = "4vh"
    }, function(data, menu)
        if (data.current == "backup") then
            _G[data.trigger](storeId, category)
        end

        if data.current.action == "sell" then
            local ItemName = data.current.info.itemName
            local ItemLabel = data.current.info.itemLabel
            local currencyType = data.current.info.currencyType
            local sellPrice = data.current.info.sellprice * data.current.value

            if not SellTable[ItemName] then
                SellTable[ItemName] = {
                    label = ItemLabel,
                    currency = currencyType,
                    price = data.current.info.sellprice,
                    quantity = data.current.value,
                    weapon = data.current.info.weapon,
                    total = sellPrice
                }
            end

            if SellTable[ItemName] then
                SellTable[ItemName].quantity = data.current.value
                SellTable[ItemName].total = sellPrice
            end

            for key, value in pairs(menu.data.elements) do
                if value.index == ItemName then
                    menu.setElement(key, "desc", font .. T.sellfor ..
                        '<span style="margin-left:90px;"><span style="font-size:25px;">' ..
                        ctp ..
                        '</span><span style="font-size:30px;">' ..
                        string.format("%.2f", data.current.info.sellprice) ..
                        "    </span><span style='color:" .. color .. ";'>   " .. currencyType ..
                        "</span><br><br><span style='font-size:25px;'> " .. T.totalToReceive .. " =</span> " ..
                        ctp .. "<span style='color: Green; font-size:25px;'>" .. sellPrice .. "</span><br><br>" ..
                        data.current.info.desc ..
                        "<br>" .. "<br><br><span style='color:" .. color .. ";'></span>")
                    menu.refresh()
                    break
                end
            end

            for key, value in pairs(menu.data.elements) do
                if value.info == "finish" then
                    local total = 0
                    for k, v in pairs(SellTable) do
                        total = total + v.total
                    end
                    menu.setElement(key, "label", T.totalToReceive .. " <br> " .. ctp .. total)
                    menu.refresh()
                    break
                end
            end
        end

        if data.current.value == "sell" then
            for key, value in pairs(SellTable) do
                if value.quantity <= 0 then
                    SellTable[key] = nil
                end
            end

            if not next(SellTable) then
                return Core.NotifyObjective(T.notSelectedItem, 5000)
            end

            TriggerServerEvent("vorp_stores:Client:sellItems", SellTable, storeId)
            closeAll()
            SellTable = {}
        end
    end, function(data, menu)

    end)
end

function OpenBuyMenu(storeId, category)
    MenuData.CloseAll()
    isInMenu = true
    local menuElements = {}
    local storeConfig = Config.Stores[storeId]
    local BuyTable = {}

    local result = Core.Callback.TriggerAwait('vorp_stores:callback:ShopStock', storeId)
    if not result then
        closeAll()
        return
    end
    local shopStocks = result.shopStock
    local ctp = ""
    local color = "Gold"
    for _, storeItem in pairs(Config.BuyItems[storeId]) do
        local itemFound = false
        if storeItem.category == category then
            if storeItem.currencyType == "cash" then
                ctp = "$"
                color = "Red"
            end

            if shopStocks[storeId] then
                for k, items in pairs(shopStocks[storeId]) do
                    if items.itemName == storeItem.itemName and items.type == "buy" then
                        itemFound = true
                        menuElements[#menuElements + 1] = {

                            label = imgPath:format("left", storeItem.itemName) ..
                                storeItem.itemLabel .. " <br> " .. items.amount .. " " .. T.avaliable,
                            value = 0,
                            min = 0,
                            max = items.amount,
                            action = "buy",
                            type = "slider",
                            desc = font .. T.buyfor ..
                                '<span style="margin-left:90px;"><span style="font-size:25px;">' ..
                                ctp .. '</span>' ..
                                '<span style="font-size:30px;">' .. string.format("%.2f", storeItem.buyprice) ..
                                "    </span><span style='color:" ..
                                color .. ";'>   " .. storeItem.currencyType .. "</span><br><br>" .. storeItem.desc,
                            info = storeItem,
                            index = storeItem.itemName

                        }
                    end
                end
            end

            if not itemFound then
                menuElements[#menuElements + 1] = {

                    label = imgPath:format("left", storeItem.itemName) .. storeItem.itemLabel .. " <br> " .. T
                        .chooseAmount,
                    value = 0,
                    min = 0,
                    max = 100,
                    type = "slider",
                    action = "buy",
                    desc = font ..
                        T.buyfor ..
                        '<span style="margin-left:90px;"><span style="font-size:25px;">' .. ctp .. '</span>' ..
                        '<span style="font-size:30px;">' .. string.format("%.2f", storeItem.buyprice) ..
                        "    </span><span style='color:" ..
                        color .. ";'>   " .. storeItem.currencyType .. "</span><br><br>" .. storeItem.desc,
                    info = storeItem,
                    index = storeItem.itemName

                }
            end
        end
    end

    if not next(menuElements) then
        OpenCategory(storeId)
        return
    end

    menuElements[#menuElements + 1] = {
        label = T.totalToPay .. " <br> " .. ctp .. 0,
        value = "finish",
        desc = T.pressHereToFinish,
        info = "finish"
    }

    MenuData.Open('default', GetCurrentResourceName(), 'OpenBuyMenu' .. storeId .. category, {
        title = storeConfig.storeName,
        subtext = T.buyMenu,
        align = Config.Align,
        elements = menuElements,
        lastmenu = "OpenSubMenu",
        itemHeight = "4vh",

    }, function(data, menu)
        if (data.current == "backup") then
            _G[data.trigger](storeId, category)
        end

        if data.current.action == "buy" then
            local ItemName = data.current.info.itemName
            local ItemLabel = data.current.info.itemLabel
            local currencyType = data.current.info.currencyType
            local buyPrice = data.current.info.buyprice * data.current.value

            if not BuyTable[ItemName] then
                BuyTable[ItemName] = {
                    label = ItemLabel,
                    currency = currencyType,
                    price = data.current.info.buyprice,
                    quantity = data.current.value,
                    weapon = data.current.info.weapon,
                    total = string.format("%.2f", buyPrice)
                }
            end

            if BuyTable[ItemName] then
                BuyTable[ItemName].quantity = data.current.value
                BuyTable[ItemName].price = buyPrice
            end

            for key, value in pairs(menu.data.elements) do
                if value.index == ItemName then
                    menu.setElement(key, "desc", font .. T.buyfor ..
                        '<span style="margin-left:90px;"><span style="font-size:25px;">' ..
                        ctp ..
                        '</span><span style="font-size:30px;">' ..
                        string.format("%.2f", data.current.info.buyprice) ..
                        "    </span><span style='color:" .. color .. ";'>   " .. currencyType ..
                        "</span><br><br><span style='font-size:25px;'> " .. T.totalToPay .. " =</span> " ..
                        ctp ..
                        "<span style='color: Green; font-size:25px;'>" ..
                        string.format("%.2f", buyPrice) .. "</span><br><br>" ..
                        data.current.info.desc ..
                        "<br>" .. "<br><br><span style='color:" .. color .. ";'></span>")
                    menu.refresh()
                    break
                end
            end

            for key, value in pairs(menu.data.elements) do
                if value.info == "finish" then
                    local total = 0
                    for k, v in pairs(BuyTable) do
                        total = total + v.total * v.quantity
                    end

                    menu.setElement(key, "label", T.totalToPay .. " <br> " .. ctp .. total)
                    menu.refresh()
                    break
                end
            end
        end

        if data.current.value == "finish" then
            for key, value in pairs(BuyTable) do
                if value.quantity <= 0 then
                    BuyTable[key] = nil
                end
            end

            if not next(BuyTable) then
                return Core.NotifyObjective(T.notSelectedItem, 5000)
            end

            TriggerServerEvent("vorp_stores:Client:buyItems", BuyTable, storeId) -- sell it
            BuyTable = {}
            closeAll()
        end
    end, function(data, menu)

    end)
end

-- *  EVENTS * --

RegisterNetEvent("vorp_stores:RefreshStorePrices", function(SellItems, BuyItems, Stores)
    Config.SellItems = SellItems
    Config.BuyItems = BuyItems
    Config.Stores = Stores
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    Wait(1000)
    TriggerServerEvent("vorp_stores:GetRefreshedPrices")
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    if isInMenu == true then
        ClearPedTasksImmediately(PlayerPedId())
        UiPromptDelete(OpenStores)
        MenuData.CloseAll()
    end
    for key, value in pairs(Config.Stores) do
        if value.Npc.Allowed and value.Npc.NpcHandle then
            DeleteEntity(value.Npc.NpcHandle)
        end
        if value.Blip.Allowed and value.Blip.BlipHandle then
            RemoveBlip(value.Blip.BlipHandle)
        end
    end
end)
