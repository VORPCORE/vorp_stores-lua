--------------------------------------------------------------------------------------------------------------
--------------------------------------------- SERVER SIDE ----------------------------------------------------
local VORPcore = {}
local VORPinv


TriggerEvent("getCore", function(core)
    VORPcore = core
end)

VORPinv = exports.vorp_inventory:vorp_inventoryApi()


--------------------------------------------------------------------------------------------------------------
--------------------------------------------- SELL -----------------------------------------------------------

RegisterServerEvent('vorp_stores:sell')
AddEventHandler('vorp_stores:sell', function(label, name, type, price, qty)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local ItemName = name
    local ItemPrice = price
    local ItemLabel = label
    local currencyType = type
    local count = VORPinv.getItemCount(_source, ItemName)
    local quantity = qty
    local total = (ItemPrice * quantity)
    if count ~= 0 then
        if currencyType == "cash" then
            VORPinv.subItem(_source, ItemName, quantity)
            Character.addCurrency(0, total)
            TriggerClientEvent("vorp:TipRight", _source, _U("yousold") .. quantity .. "" .. ItemLabel .. _U("fr") .. total .. _U("ofcash"), 3000)
        end

        if currencyType == "gold" then

            VORPinv.subItem(_source, ItemName, quantity)
            Character.addCurrency(1, total)
            TriggerClientEvent("vorp:TipRight", _source, _U("yousold") .. quantity .. "" .. ItemLabel .. _U("fr") .. total .. _U("ofgold"), 3000)
        end
    else
        TriggerClientEvent("vorp:TipRight", _source, "no item ", 3000)
    end
end)

------------------------------------------------------------------------------------------------------------------------
---------------------------------------------- BUY ---------------------------------------------------------------------

RegisterServerEvent('vorp_stores:buy')
AddEventHandler('vorp_stores:buy', function(label, name, type, price, qty)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local money = Character.money
    local gold = Character.gold
    local ItemName = name
    local ItemPrice = price
    local ItemLabel = label
    local currencyType = type
    local quantity = qty
    local total = (ItemPrice * quantity)

    TriggerEvent("vorpCore:canCarryItems", tonumber(_source), 1, function(canCarry) --check inv
        TriggerEvent("vorpCore:canCarryItem", tonumber(_source), ItemName, 1, function(canCarry2) --check item count
            if canCarry and canCarry2 then
                if currencyType == "cash" then
                    if money >= ItemPrice then


                        VORPinv.addItem(_source, ItemName, quantity)
                        Character.removeCurrency(0, total)

                        TriggerClientEvent("vorp:TipRight", _source, _U("youbought") .. quantity .. " " .. ItemLabel .. _U("fr") .. total .. _U("ofcash"), 3000)

                    else
                        TriggerClientEvent("vorp:TipRight", _source, _U("youdontcash"), 3000)
                    end

                end
                if currencyType == "gold" then
                    if gold >= ItemPrice then


                        VORPinv.addItem(_source, ItemName, quantity)
                        Character.removeCurrency(1, total)
                        TriggerClientEvent("vorp:TipRight", _source, _U("youbought") .. quantity .. "" .. ItemLabel .. _U("fr") .. total .. _U("ofgold"), 3000)

                    else
                        TriggerClientEvent("vorp:TipRight", _source, _U("youdontgold"), 3000)
                    end
                end
            else
                TriggerClientEvent("vorp:TipRight", _source, _U("cantcarry"), 3000)
            end
        end)
    end)


end)

-------------------- GetJOB --------------------
RegisterServerEvent('vorp_stores:getPlayerJob')
AddEventHandler('vorp_stores:getPlayerJob', function()
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local CharacterJob = Character.job
    local CharacterGrade = Character.jobGrade

    TriggerClientEvent('vorp_stores:sendPlayerJob', _source, CharacterJob, CharacterGrade)
end)
