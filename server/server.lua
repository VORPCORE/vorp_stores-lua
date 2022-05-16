--------------------------------------------------------------------------------------------------------------
--------------------------------------------- SERVER SIDE ----------------------------------------------------
local VORPcore = {}
local VORPinv


TriggerEvent("getCore", function(core)
    VORPcore = core
end)

VORPinv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('vorp_stores:sell')
AddEventHandler('vorp_stores:sell', function(label, name, type, price)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local money = Character.money
    local gold = Character.gold
    local ItemName = name
    local ItemPrice = price
    local ItemLabel = label
    local currencyType = type
    local count = VORPinv.getItemCount(_source, ItemName)



    if count ~= 0 then
        if currencyType == "cash" then
            local count = 1
            VORPinv.subItem(_source, ItemName, count)
            Character.addCurrency(0, ItemPrice)
            TriggerClientEvent('vorp:ShowAdvancedRightNotification', "paid with cash", "inventory_items", "clothing_generic_boots", "COLOR_PURE_WHITE", 4000)
            TriggerClientEvent("vorp:TipRight", _source, " paid with cash", 3000)
        end

        if currencyType == "gold" then
            local count = 1
            VORPinv.subItem(_source, ItemName, count)
            Character.addCurrency(1, ItemPrice)
            TriggerClientEvent("vorp:TipRight", _source, " paid with gold", 3000)
        end
    else
        TriggerClientEvent("vorp:TipRight", _source, "you dont have the items", 3000)
    end










end)


RegisterServerEvent('vorp_stores:buy')
AddEventHandler('vorp_stores:buy', function(label, name, type, price)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local money = Character.money
    local gold = Character.gold
    local ItemName = name
    local ItemPrice = price
    local ItemLabel = label
    local currencyType = type


    TriggerEvent("vorpCore:canCarryItems", tonumber(_source), 1, function(canCarry)
        TriggerEvent("vorpCore:canCarryItem", tonumber(_source), ItemName, 1, function(canCarry2)
            if canCarry and canCarry2 then

                if money >= ItemPrice then
                    if currencyType == "cash" then
                        local count = 1
                        VORPinv.addItem(_source, ItemName, count)
                        Character.removeCurrency(0, ItemPrice)

                        TriggerClientEvent("vorp:TipRight", _source, "you got " .. ItemLabel .. " paid with cash", 3000)
                    end
                else
                    TriggerClientEvent("vorp:TipRight", _source, "no money", 3000)

                end

                if gold >= ItemPrice then
                    if currencyType == "gold" then
                        local count = 1
                        VORPinv.addItem(_source, ItemName, count)
                        Character.removeCurrency(1, ItemPrice)
                        TriggerClientEvent("vorp:TipRight", _source, "you got" .. ItemLabel .. " paid with gold", 3000)
                    end
                else
                    TriggerClientEvent("vorp:TipRight", _source, "no gold", 3000)
                end
            else
                TriggerClientEvent("vorp:TipRight", _source, "cant carry gold", 3000)
            end
        end)
    end)


end)


RegisterServerEvent('vorp_stores:getPlayerJob')
AddEventHandler('vorp_stores:getPlayerJob', function()
    local _source = source
    local User = VORPcore.getUser(_source)
    local Character = User.getUsedCharacter
    local CharacterJob = Character.job


    TriggerClientEvent('vorp_stores:sendPlayerJob', _source, CharacterJob)
end)
