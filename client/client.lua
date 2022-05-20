------------------------------------------------------------------------------------------------------
-------------------------------------------- CLIENT --------------------------------------------------

local OpenStores
local PlayerJob
local JobGrade
local PromptGroup = GetRandomIntInRange(0, 0xffffff)
local isInMenu = false
local blips = {}
local npcs = {}
MenuData = {}


TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)


---------------- BLIPS ---------------------
function Blips()
    for i, v in pairs(Config.Stores) do
        if v.blipAllowed then
            blips[i] = N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z)
            SetBlipSprite(blips[i], v.sprite, 1)
            SetBlipScale(blips[i], 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, blips[i], v.BlipName)
        end
    end
end

------------------ PROMPTS ------------------
function PromptSetUp()
    local str = _U("SubPrompt")
    OpenStores = PromptRegisterBegin()
    PromptSetControlAction(OpenStores, Config.Key)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(OpenStores, str)
    PromptSetEnabled(OpenStores, 1)
    PromptSetVisible(OpenStores, 1)
    PromptSetStandardMode(OpenStores, 1)
    PromptSetGroup(OpenStores, PromptGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, OpenStores, true)
    PromptRegisterEnd(OpenStores)
    Blips()
end

------------------- NPCS --------------------
function LoadModel(model)
    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(100)
    end
end

function InsertNpcs()
    for k, v in pairs(Config.Stores) do
        LoadModel(v.NpcModel)
        if v.NpcAllowed then
            local npc = CreatePed(v.NpcModel, v.x, v.y, v.z, v.h, false, true, true, true)
            Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
            SetEntityCanBeDamaged(npc, false)
            SetEntityInvincible(npc, true)
            Wait(500)
            FreezeEntityPosition(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)
            table.insert(npcs, { npc = npc, coords = vector3(v.x, v.y, v.z) })

        end
    end
end

function CheckJob(table, element)
    for k, v in pairs(table) do
        if v == element then
            return true
        end
    end
    return false
end

------- STORES START ----------
Citizen.CreateThread(function()
    PromptSetUp()
    InsertNpcs()

    while true do
        Citizen.Wait(15)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local sleep = coords, true
        local dead = IsEntityDead(player)


        if isInMenu == false and not dead then

            for storeId, storeConfig in pairs(Config.Stores) do

                --## run this before distance check  no need to run a code that is no meant for the client ## --
                if not next(storeConfig.AllowedJobs) then -- if jobs empty then everyone can use

                    local distance = Vdist2(coords.x, coords.y, coords.z, storeConfig.x, storeConfig.y, storeConfig.z, true)

                    if (distance <= storeConfig.distanceOpenStore) then --check distance
                        sleep = false
                        local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)

                        PromptSetActiveGroupThisFrame(PromptGroup, label)
                        if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then -- iff all pass open menu
                            OpenCategory(storeId)
                            TaskStandStill(player, -1)
                        end
                    end

                else -- job only

                    TriggerServerEvent("vorp_stores:getPlayerJob")

                    if CheckJob(storeConfig.AllowedJobs, PlayerJob) then
                        if storeConfig.JobGrade == JobGrade then
                            local distance = Vdist2(coords.x, coords.y, coords.z, storeConfig.x, storeConfig.y, storeConfig.z, true)

                            if (distance <= storeConfig.distanceOpenStore) then
                                sleep = false
                                local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)

                                PromptSetActiveGroupThisFrame(PromptGroup, label)
                                if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then
                                    OpenCategory(storeId)
                                    TaskStandStill(player, -1)
                                end
                            end
                        end
                    end

                end
            end
        end
        if sleep then
            Citizen.Wait(1000)
        end
    end
end)



---- items category ------
function OpenCategory(storeId) -- CreateBaseMenu(storeId)
    MenuData.CloseAll()
    isInMenu = true

    local elements = {}

    --   { label = _U("category_Food"), value = "food", desc = " Get some food" },
    --    { label = _U("category_Tools"), value = "tools", desc = "Get some tools " },
    --    { label = _U("category_misc"), value = "f", desc = "Get some tools " },

    --}
    for k, v in pairs(Config.Stores[storeId]) do
        table.insert(elements, { label = v.categoryLabel, value = "test", desc = "" })
    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi' .. storeId, {
        title    = Config.Stores[storeId].storeName,
        subtext  = _U("SubMenu"),
        align    = Config.Align,
        elements = elements,


    },
        function(data, menu)
            OpenSubMenuSell(storeId, data.current.value)
        end,

        function(data, menu)
            menu.close()
            isInMenu = false
        end)

end

--sell only
function OpenSubMenuSell(storeId, category)
    MenuData.CloseAll()
    isInMenu = true
    local elements = {
        { label = "sell", value = 'sell', desc = "sell items" },
        { label = "buy", value = 'buy', desc = "buy items" }
    }




    MenuData.Open('default', GetCurrentResourceName(), 'menuapi' .. storeId .. category, {
        title    = Config.Stores[storeId].storeName,
        subtext  = _U("SubMenu"),
        align    = Config.Align,
        elements = elements,


    },
        function(data, menu)
            if (data.current.value == 'sell') then
                OpenSellMenu(storeId, category)

            end

            if (data.current.value == 'buy') then
                OpenBuyMenu(storeId, category)
            end

        end,

        function(data, menu)
            menu.close()
            isInMenu = false
        end)

end

--sell
function OpenSellMenu(storeId, category)
    MenuData.CloseAll()
    isInMenu = true
    local menuElements = {}
    local player = PlayerPedId()
    local storeConfig = Config.Stores[storeId]

    local elementIndex = 1

    for index, storeItem in ipairs(Config.SellItems[storeId]) do
        if storeItem.category == category then

            menuElements[elementIndex] = {
                label = "<img style='max-height:40px;max-width:40px;float: left;text-align: center;' src='nui://vorp_inventory/html/img/items/" .. storeItem.itemName .. ".png'><span style=margin-left:140px;font-size:25px;text-align:center;>" .. storeItem.itemLabel .. "</span>",
                value = "sell" .. tostring(elementIndex),
                desc = "" .. '<span style="font-family: crock; src:nui://menuapi/html/fonts/crock.ttf) format("truetype")</span>' .. "SELL FOR" .. '<span style="margin-left:90px;">' .. '<span style="font-size:25px;">$</span>' .. '<span style="font-size:30px;">' .. storeItem.sellprice .. "</span><br><br><br>" .. storeItem.desc,
                info = storeItem


            }

            elementIndex = elementIndex + 1

        end

    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi' .. storeId .. category, {
        title    = storeConfig.storeName,
        subtext  = "SELL MENU",
        align    = Config.Align,
        elements = menuElements,
        lastmenu = ''



    },
        function(data, menu)

            local ItemName = data.current.info.itemName
            local ItemLabel = data.current.info.itemLabel
            local currencyType = data.current.info.currencyType
            local sellPrice = data.current.info.sellprice

            TriggerServerEvent("vorp_stores:sell", ItemLabel, ItemName, currencyType, sellPrice) --sell it

        end,

        function(data, menu)
            menu.close()
            ClearPedTasksImmediately(player)
            isInMenu = false
        end)

end

--- buy
function OpenBuyMenu(storeId, category)
    MenuData.CloseAll()
    isInMenu = true
    local menuElements = {}
    local player = PlayerPedId()
    local storeConfig = Config.Stores[storeId]

    local elementIndex = 1

    for index, storeItem in ipairs(Config.BuyItems[storeId]) do
        if storeItem.category == category then

            menuElements[elementIndex] = {
                label = "<img style='max-height:40px;max-width:40px;float: left;text-align: center;' src='nui://vorp_inventory/html/img/items/" .. storeItem.itemName .. ".png'><span style=margin-left:140px;font-size:25px;text-align:center;>" .. storeItem.itemLabel .. "</span>",
                value = "sell" .. tostring(elementIndex),
                desc = "" .. '<span style="font-family: crock; src:nui://menuapi/html/fonts/crock.ttf) format("truetype")</span>' .. "SELL FOR" .. '<span style="margin-left:90px;">' .. '<span style="font-size:25px;">$</span>' .. '<span style="font-size:30px;">' .. storeItem.buyprice .. "</span><br><br><br>" .. storeItem.desc .. " get " .. storeItem.currencyType,
                info = storeItem


            }

            elementIndex = elementIndex + 1

        end

    end



    MenuData.Open('default', GetCurrentResourceName(), 'menuapi' .. storeId .. category, {
        title    = storeConfig.storeName,
        subtext  = "BUY MENU",
        align    = Config.Align,
        elements = menuElements,


    },
        function(data, menu)
            local ItemName = data.current.info.itemName
            local ItemLabel = data.current.info.itemLabel
            local currencyType = data.current.info.currencyType
            local buyPrice = data.current.info.buyprice
            TriggerServerEvent("vorp_stores:buy", ItemLabel, ItemName, currencyType, buyPrice)

        end,

        function(data, menu)
            menu.close()
            ClearPedTasksImmediately(player)
            isInMenu = false
        end)

end

RegisterNetEvent("vorp_stores:sendPlayerJob")
AddEventHandler("vorp_stores:sendPlayerJob", function(Job, grade)
    PlayerJob = Job
    JobGrade = grade
end)


AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    if isInMenu == true then
        ClearPedTasksImmediately(PlayerPedId())
        PromptDelete(OpenStores)
        MenuData.CloseAll()
    end
    for _, v in pairs(blips) do
        RemoveBlip(v)

    end
    for _, v in pairs(npcs) do
        DeleteEntity(v.npc)
        DeletePed(v.npc)
        SetEntityAsNoLongerNeeded(v.npc)
    end

end)
