ESX = nil
local count = 0
local showMinutes = false
local timeToWait

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('messageAnnouncement')
AddEventHandler('messageAnnouncement', function(sender, message)

	if Config.ShowFreemode  then
		ESX.Scaleform.ShowFreemodeMessage(_U('chat_announcement'), message, Config.FreemodeTime)
	end
	if Config.ShowMessage  then
		local message = _U(type) .. " | " .. ":^0  " .. message
		TriggerEvent('chat:addMessage', {
		color = { 255, 0, 0},
		multiline = true,
		args = {tostring(sender), tostring(message) }
		})
	end
end)

RegisterNetEvent("messageTriggerCountdown")
AddEventHandler("messageTriggerCountdown", function(count_time)
	if Config.Wait >= 1 then
		count = count_time
		timeToWait = Config.Wait
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if count >= 1 then
			local show = count
			local messageC = ""
			
			--set waiting time
			if count < Config.One then
				timeToWait = 1000
			elseif count > 60 then
				timeToWait = Config.Wait
			end
			
			--show minutes or seconds
			if count >= 60 then
				show = count/60
				showMinutes = true
			elseif showMinutes then				
				showMinutes = false
			end
			
			--notification
			if Config.CountDownNotification then
				if showMinutes then
					messageC = tostring(string.format("%." .. "0" .. "f", show)) ..'' .. _U('notification_minutes')
				else
					messageC = tostring(string.format("%." .. "0" .. "f", show)) ..' ' .. _U('notification_seconds')
				end
				ESX.ShowNotification(_U('notification_string') .. ': ' .. messageC)
			end
			
			--message
			if Config.CountDownChat == true then
				messageC = _U('chat_string') .. " | " .."  "..":^0  "
				TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"Me", tostring(messageC) }
				})
			end
		
			count = count - (timeToWait/1000)
			Citizen.Wait(timeToWait)			
		end
	end
end)