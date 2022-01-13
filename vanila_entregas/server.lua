local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("vanila_entregas",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function func.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"vanilla.permissao") then
		if quantidade[source] == nil then
			quantidade[source] = math.random(4,8)
			TriggerClientEvent("Notify",source,"aviso","Vá para o local marcado no seu mapa e entregue <b>"..quantidade[source].." convites</b>.")
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você não faz parte desta organização.")
	end
end

function func.checkPayment()
	func.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"convite",quantidade[source]) then
			local encomendas = quantidade[source]
			local pagamento = math.random(300,400)*encomendas
			vRP.giveMoney(user_id,pagamento)
			TriggerClientEvent("Notify",source,"aviso","Você recebeu <b>$"..pagamento.."</b> por <b>"..encomendas.." convites</b>.")
			quantidade[source] = nil
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..quantidade[source].." convites</b>.")
		end
	end
end