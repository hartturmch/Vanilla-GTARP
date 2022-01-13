local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("vanila_coletar",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"vanilla.permissao") then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("convite")*3 <= vRP.getInventoryMaxWeight(user_id) then
				SetTimeout(8000,function()
					vRP.giveInventoryItem(user_id,"convite",3)
					TriggerClientEvent("Notify",source,"aviso","Você recebeu <b>3 convites</b>.")
				end)
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Mochila cheia.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não pertence a esse grupo.")
		end
	end
end