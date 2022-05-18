------------------------------------------------------------------------------------------------------
-------------------------------------------- CLIENT --------------------------------------------------
local key = Config.Key
local OpenStores
local PlayerJob
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
    PromptSetControlAction(OpenStores, key)
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

function CheckJob(table, element) -- Jobs in a table
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

            for k, v in pairs(Config.Stores) do

                --## run this before distance check  no need to run a code that is no meant for the client ## --
                if v.JobAllowed == false then --everyone can use

                    local distance = Vdist2(coords.x, coords.y, coords.z, v.x, v.y, v.z, true)

                    if (distance < v.distanceOpenStore) then --check distance
                        sleep = false
                        local label = CreateVarString(10, 'LITERAL_STRING', v.PromptName)

                        PromptSetActiveGroupThisFrame(PromptGroup, label)
                        if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then -- iff all pass open menu
                            OpenCategory(k)
                            TaskStandStill(player, -1)
                        end
                    end

                else -- job only

                    TriggerServerEvent("vorp_stores:getPlayerJob") -- get players job

                    if CheckJob(v.Jobs, PlayerJob) then

                        local distance = Vdist2(coords.x, coords.y, coords.z, v.x, v.y, v.z, true)

                        if (distance < v.distanceOpenStore) then --check distance
                            sleep = false
                            local label = CreateVarString(10, 'LITERAL_STRING', v.PromptName)

                            PromptSetActiveGroupThisFrame(PromptGroup, label)
                            if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then -- iff all pass open menu
                                OpenCategory(k)
                                TaskStandStill(player, -1)
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
function OpenCategory(Value)
    MenuData.CloseAll()
    isInMenu = true

    local elements = {

        { label = "Food", value = 'food', desc = " Get some food" },
        { label = "Tools", value = 'tools', desc = "Get some tools " },
        { label = "Meds", value = 'meds', desc = "Get some medicine" },

    }



    MenuData.Open('default', GetCurrentResourceName(), 'category' .. Value, {
        title    = Config.Stores[Value].storeName,
        subtext  = _U("SubMenu"),
        align    = Config.Align,
        elements = elements,


    },
        function(data, menu)
            if (data.current.value == 'food') then
                -- TEST
                OpenSellMenu(Value)

            end

            if (data.current.value == 'tools') then

                --OpenSellMenu2(Value)
            end

            if (data.current.value == 'meds') then
                --OpenMeds(Value)

            end
        end,

        function(data, menu)
            menu.close()
            isInMenu = false
        end)

end

--sell only
function OpenSubMenuSell(Value)
    MenuData.CloseAll()
    isInMenu = true
    local elements = {
        { label = "sell", value = 'sell', desc = "sell items" },
    }




    MenuData.Open('default', GetCurrentResourceName(), 'submenu' .. Value, {
        title    = Config.Stores[Value].storeName,
        subtext  = _U("SubMenu"),
        align    = Config.Align,
        elements = elements,


    },
        function(data, menu)
            if (data.current.value == 'sell') then
                --OpenSellMenu(Value)
                --OpenCategory(Value)
            end


        end,

        function(data, menu)
            menu.close()
            isInMenu = false
        end)

end

--test buy only
function OpenSubMenuBuy(Value)
    MenuData.CloseAll()
    isInMenu = true
    local elements = {
        { label = "buy", value = 'buy', desc = "buy items" },
    }


    MenuData.Open('default', GetCurrentResourceName(), 'submenu' .. Value, {
        title    = Config.Stores[Value].storeName,
        subtext  = _U("SubMenu"),
        align    = Config.Align,
        elements = elements,


    },
        function(data, menu)


            if (data.current.value == 'buy') then
                OpenBuyMenu(Value)
            end
        end,

        function(data, menu)
            menu.close()
            isInMenu = false
        end)

end

--sell
function OpenSellMenu(Value)
    MenuData.CloseAll()
    isInMenu = true
    local elements = {}
    local player = PlayerPedId()

    for k, v in pairs(Config.SellItems[Value]) do

        if v.category == "food" then --get category
            --display only items with category food
            elements[k] = {
                label = v.itemLabel,
                value = "sell" .. k,
                desc = v.desc .. "<br><br><br>" .. "PRICE" .. " = <span style=color:Yellow;>" .. v.price .. " $" .. "",
                info = v


            }

        end

    end


    MenuData.Open('default', GetCurrentResourceName(), 'sellstore' .. Value, {
        title    = Config.Stores[Value].storeName,
        subtext  = _U("SubMenu"),
        align    = Config.Align,
        elements = elements,


    },
        function(data, menu)
            local ItemName = data.current.info.itemName
            local ItemLabel = data.current.info.itemLabel
            local currencyType = data.current.info.currencyType
            local ItemPrice = data.current.info.price

            TriggerServerEvent("vorp_stores:sell", ItemLabel, ItemName, currencyType, ItemPrice) --sell it

        end,

        function(data, menu)
            menu.close()
            ClearPedTasksImmediately(player)
            isInMenu = false
        end)

end

--- buy
function OpenBuyMenu(Value)
    MenuData.CloseAll()
    isInMenu = true
    local elements = {}
    local player = PlayerPedId()

    for i, v in pairs(Config.BuyItems[Value]) do
        elements[i] = {
            label = v.itemLabel,
            value = "buy" .. i,
            desc = v.desc .. "<br><br><br>" .. _U("price") .. " = <span style=color:Yellow;>" .. v.price .. " $" .. "<br>Your money",
            info = v
        }


    end



    MenuData.Open('default', GetCurrentResourceName(), 'buystore' .. Value, {
        title    = Config.Stores[Value].storeName,
        subtext  = _U("SubMenu"),
        align    = Config.Align,
        elements = elements,


    },
        function(data, menu)
            local ItemName = data.current.info.itemName
            local ItemLabel = data.current.info.itemLabel
            local currencyType = data.current.info.currencyType
            local ItemPrice = data.current.info.price
            TriggerServerEvent("vorp_stores:buy", ItemLabel, ItemName, currencyType, ItemPrice)

        end,

        function(data, menu)
            menu.close()
            ClearPedTasksImmediately(player)
            isInMenu = false
        end)

end

--- get job
RegisterNetEvent("vorp_stores:sendPlayerJob")
AddEventHandler("vorp_stores:sendPlayerJob", function(CharacterJob)
    PlayerJob = CharacterJob

end)

--remove all
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
