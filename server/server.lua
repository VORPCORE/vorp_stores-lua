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
    local ItemName = name
    local ItemPrice = price
    local ItemCount = VORPinv.getItemItemCount(_source, ItemName)
    local ItemLabel = label
    local currencyType = type
    local sellprice

    if ItemCount == 0 then
        TriggerClientEvent("vorp:TipRight", _source, _U("you_broke"), 3000)
        return
    end

    if ItemCount >= 1 and currencyType == "cash" then


        VORPinv.subItem(_source, ItemName, ItemCount)

        sellprice = ItemPrice * ItemCount

        Character.addCurrency(0, sellprice)

    elseif ItemCount >= 1 and currencyType == "gold" then


        VORPinv.subItem(_source, ItemName, ItemCount)
        sellprice = ItemPrice * ItemCount
        Character.addCurrency(1, sellprice)


        TriggerClientEvent('vorp:ShowAdvancedRightNotification', ItemLabel, "inventory_items", "clothing_generic_boots", "COLOR_PURE_WHITE", 4000)
    else
        TriggerClientEvent("vorp:TipRight", _source, _U("you_broke"), 3000)
    end

end)


RegisterServerEvent('vorp_stores:buy')
AddEventHandler('vorp_stores:buy', function(label, name, price, type)
    print(label, name, price, type)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local ItemName = name
    local ItemPrice = price
    local ItemLabel = label
    local currencyType = type
    local buyPrice


    if currencyType == "cash" then

        VORPinv.addItem(_source, ItemName)
        Character.removeCurrency(0, ItemPrice)

        TriggerClientEvent('vorp:ShowAdvancedRightNotification', ItemLabel, "inventory_items", "clothing_generic_boots", "COLOR_PURE_WHITE", 4000)

    elseif currencyType == "gold" then


        VORPinv.addItem(_source, ItemName, ItemCount)

        buyPrice = ItemPrice * ItemCount

        Character.removeCurrency(1, buyPrice)
    else
        TriggerClientEvent("vorp:TipRight", _source, _U("you_broke"), 3000)
    end

end)


RegisterServerEvent('vorp_stores:getPlayerJob')
AddEventHandler('vorp_stores:getPlayerJob', function()
    local _source = source
    local User = VORPcore.getUser(_source)
    local Character = User.getUsedCharacter
    local CharacterJob = Character.job


    TriggerClientEvent('vorp_stores:sendPlayerJob', _source, CharacterJob)
end)
