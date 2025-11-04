function PoliceItems()
    exports.ox_inventory:RegisterUse("det_cord", "PDItems", function(source, slot, itemData)
        local pState = Player(source).state
        if pState.onDuty == "police" then
            exports["sandbox-base"]:ClientCallback(source, "Police:DoDetCord", {}, function(s, doorId)
                if s and exports.ox_inventory:RemoveSlot(slot.Owner, slot.Name, 1, slot.Slot, 1) then
                    -- Use ox_doorlock to unlock the door
                    TriggerEvent('ox_doorlock:setState', doorId, false, source)
                    -- Add a timeout to re-lock the door after 1 hour (60 minutes)
                    SetTimeout(60 * 60 * 1000, function()
                        TriggerEvent('ox_doorlock:setState', doorId, true, source)
                    end)
                end
            end)
        end
    end)
end

RegisterNetEvent('ox_inventory:ready', function()
    if GetResourceState(GetCurrentResourceName()) == 'started' then
        PoliceItems()
    end
end)
