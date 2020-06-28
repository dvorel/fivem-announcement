ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("makean", function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	
    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
	    TriggerClientEvent("messageAnnouncement", -1, source, table.concat(args, " "))
	end	
end)

RegisterCommand("timedan", function(source, args, user)
  	local xPlayer = ESX.GetPlayerFromId(source)
	
	local toSay = ""
    local nArgs = #args
	local n = tonumber(args[nArgs])
	args[nArgs] = nil
	
    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
	    TriggerClientEvent("messageAnnouncement", -1, source, table.concat(args, " "))
		TriggerClientEvent("messageTriggerCountdown", -1, n)
	end	
	
end)
  
