-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÃO DE LICENÇA
-----------------------------------------------------------------------------------------------------------------------------------------
local LICENSE_CONFIG = {
	GitHubURL = "https://raw.githubusercontent.com/dylakkj/license/refs/heads/main/license.json",
	RecheckInterval = 30,
	ResourceName = "ayx-animations",

	-- Chave de licença local (alternativa ao IP)
	-- Configure no server.cfg: set ayx_license_key "SUA-CHAVE-AQUI"
	-- Ou defina diretamente aqui (menos recomendado):
	LicenseKey = nil,
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS DE LICENÇA
-----------------------------------------------------------------------------------------------------------------------------------------
local isLicensed = false
local serverIP = nil
local licenseChecked = false
local authMethod = nil -- "ip" ou "license_key"

-----------------------------------------------------------------------------------------------------------------------------------------
-- UTILITÁRIOS DE LICENÇA
-----------------------------------------------------------------------------------------------------------------------------------------

local function LicenseLog(msg, tipo)
	local prefix = {
		success = "^2[+]^0",
		error   = "^1[-]^0",
		warning = "^3[!]^0",
		info    = "^5[-]^0",
	}
	print((prefix[tipo] or prefix.info) .. " " .. msg)
end

local function HttpRequest(url, cb)
	PerformHttpRequest(url, function(statusCode, responseText, headers)
		if cb then
			cb(statusCode, responseText, headers)
		end
	end, "GET", "", { ["Content-Type"] = "application/json", ["Cache-Control"] = "no-cache" })
end

--- Obtém a license key configurada (convar > config)
local function GetLicenseKey()
	local convarKey = GetConvar("ayx_license_key", "")
	if convarKey and convarKey ~= "" then
		return convarKey
	end
	if LICENSE_CONFIG.LicenseKey and LICENSE_CONFIG.LicenseKey ~= "" then
		return LICENSE_CONFIG.LicenseKey
	end
	return nil
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- OBTER IP DO SERVIDOR
-----------------------------------------------------------------------------------------------------------------------------------------

local function GetServerPublicIP(cb)
	HttpRequest("https://api.ipify.org", function(code, body)
		if code == 200 and body and #body > 0 then
			local ip = body:gsub("%s+", "")
			cb(ip)
		else
			HttpRequest("https://api64.ipify.org", function(code2, body2)
				if code2 == 200 and body2 and #body2 > 0 then
					local ip = body2:gsub("%s+", "")
					cb(ip)
				else
					HttpRequest("https://ifconfig.me/ip", function(code3, body3)
						if code3 == 200 and body3 and #body3 > 0 then
							local ip = body3:gsub("%s+", "")
							cb(ip)
						else
							cb(nil)
						end
					end)
				end
			end)
		end
	end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICAÇÃO DE LICENÇA
-----------------------------------------------------------------------------------------------------------------------------------------

local recheckRetries = 0
local MAX_RECHECK_RETRIES = 3

--- Verifica expiração de uma entrada de licença
local function CheckExpiry(entry)
	if entry and entry.expires then
		local year, month, day = entry.expires:match("(%d+)-(%d+)-(%d+)")
		if year then
			local expiryTime = os.time({ year = tonumber(year), month = tonumber(month), day = tonumber(day) })
			if os.time() > expiryTime then
				LicenseLog("═══════════════════════════════════════════", "error")
				LicenseLog("  LICENÇA EXPIRADA!", "error")
				LicenseLog("  Entre em contato para renovar.", "error")
				LicenseLog("═══════════════════════════════════════════", "error")
				return true -- expirada
			end
		end
	end
	return false -- válida
end

--- Tenta autenticar por IP
local function TryAuthByIP(licenses, ip)
	if not licenses.authorized_ips or type(licenses.authorized_ips) ~= "table" then
		return false, nil
	end
	for _, entry in ipairs(licenses.authorized_ips) do
		if type(entry) == "table" and entry.ip == ip then
			return true, entry
		elseif type(entry) == "string" and entry == ip then
			return true, nil
		end
	end
	return false, nil
end

--- Tenta autenticar por license key
local function TryAuthByLicenseKey(licenses, key)
	if not key or not licenses.authorized_licenses or type(licenses.authorized_licenses) ~= "table" then
		return false, nil
	end
	for _, entry in ipairs(licenses.authorized_licenses) do
		if type(entry) == "table" and entry.key == key then
			return true, entry
		elseif type(entry) == "string" and entry == key then
			return true, nil
		end
	end
	return false, nil
end

local function CheckLicense(isRecheck)
	local licenseKey = GetLicenseKey()
	
	---------------------------------------------------------------------------
	-- FLUXO RÁPIDO: Se tem license key configurada, verifica PRIMEIRO (sem esperar IP)
	---------------------------------------------------------------------------
	if licenseKey then
		local url = LICENSE_CONFIG.GitHubURL .. "?t=" .. os.time()
		HttpRequest(url, function(code, body)
			if code ~= 200 or not body then
				if isRecheck then
					recheckRetries = recheckRetries + 1
					LicenseLog("Re-verificação: Falha ao acessar servidor de licenças - HTTP " .. tostring(code) .. " (tentativa " .. recheckRetries .. "/" .. MAX_RECHECK_RETRIES .. ").", "warning")
					if recheckRetries >= MAX_RECHECK_RETRIES then
						LicenseLog("Re-verificação: Máximo de tentativas atingido. Mantendo estado atual da licença.", "warning")
						recheckRetries = 0
					end
					return
				end
				LicenseLog("Falha ao acessar o servidor de licenças (HTTP " .. tostring(code) .. ").", "error")
				LicenseLog("Verifique a URL do GitHub e sua conexão com a internet.", "error")
				isLicensed = false
				licenseChecked = true
				return
			end

			local licenses = json.decode(body)
			if not licenses or type(licenses) ~= "table" then
				if isRecheck then
					recheckRetries = recheckRetries + 1
					LicenseLog("Re-verificação: JSON inválido na resposta (tentativa " .. recheckRetries .. "/" .. MAX_RECHECK_RETRIES .. ").", "warning")
					if recheckRetries >= MAX_RECHECK_RETRIES then
						LicenseLog("Re-verificação: Máximo de tentativas atingido. Mantendo estado atual da licença.", "warning")
						recheckRetries = 0
					end
					return
				end
				LicenseLog("Arquivo de licenças inválido (JSON malformado).", "error")
				isLicensed = false
				licenseChecked = true
				return
			end

			recheckRetries = 0

			local authorized = false
			local licenseInfo = nil
			local method = nil

			authorized, licenseInfo = TryAuthByLicenseKey(licenses, licenseKey)
			if authorized then
				method = "license_key"
			end

			if not authorized then
				GetServerPublicIP(function(ip)
					if ip then
						serverIP = ip
						local ipAuth, ipInfo = TryAuthByIP(licenses, ip)
						if ipAuth then
							if CheckExpiry(ipInfo) then
								isLicensed = false
								licenseChecked = true
								return
							end
							isLicensed = true
							licenseChecked = true
							authMethod = "ip"
							if not isRecheck then
								LicenseLog("Licença verificada com sucesso!", "success")
							end
							return
						end
					end
					isLicensed = false
					licenseChecked = true
					LicenseLog("  License Key não encontrada no servidor de licenças.", "error")
					if ip then
						LicenseLog("  IP: " .. ip .. " também não possui uma licença válida.", "error")
					end
				end)
				return
			end

			if CheckExpiry(licenseInfo) then
				isLicensed = false
				licenseChecked = true
				return
			end

			isLicensed = true
			licenseChecked = true
			authMethod = method

			if not isRecheck then
				LicenseLog("Licença verificada com sucesso!", "success")
			end
		end)
	else
		-----------------------------------------------------------------------
		-- FLUXO PADRÃO: Sem license key, verifica por IP (comportamento original)
		-----------------------------------------------------------------------
		GetServerPublicIP(function(ip)
			if not ip then
				if isRecheck then
					recheckRetries = recheckRetries + 1
					LicenseLog("Re-verificação: Não foi possível obter o IP público (tentativa " .. recheckRetries .. "/" .. MAX_RECHECK_RETRIES .. ").", "warning")
					if recheckRetries >= MAX_RECHECK_RETRIES then
						LicenseLog("Re-verificação: Máximo de tentativas atingido. Mantendo estado atual da licença.", "warning")
						recheckRetries = 0
					end
					return
				end
				LicenseLog("Não foi possível obter o IP público do servidor.", "error")
				--[[ LicenseLog("Dica: Configure 'set ayx_license_key' no server.cfg para autenticação rápida por chave.", "info") ]]
				LicenseLog("Funções bloqueadas por segurança.", "error")
				isLicensed = false
				licenseChecked = true
				return
			end

			serverIP = ip

			local url = LICENSE_CONFIG.GitHubURL .. "?t=" .. os.time()
			HttpRequest(url, function(code, body)
				if code ~= 200 or not body then
					if isRecheck then
						recheckRetries = recheckRetries + 1
						LicenseLog("Re-verificação: Falha ao acessar servidor de licenças - HTTP " .. tostring(code) .. " (tentativa " .. recheckRetries .. "/" .. MAX_RECHECK_RETRIES .. ").", "warning")
						if recheckRetries >= MAX_RECHECK_RETRIES then
							LicenseLog("Re-verificação: Máximo de tentativas atingido. Mantendo estado atual da licença.", "warning")
							recheckRetries = 0
						end
						return
					end
					LicenseLog("Falha ao acessar o servidor de licenças (HTTP " .. tostring(code) .. ").", "error")
					LicenseLog("Verifique a URL do GitHub e sua conexão com a internet.", "error")
					isLicensed = false
					licenseChecked = true
					return
				end

				local licenses = json.decode(body)
				if not licenses or type(licenses) ~= "table" then
					if isRecheck then
						recheckRetries = recheckRetries + 1
						LicenseLog("Re-verificação: JSON inválido na resposta (tentativa " .. recheckRetries .. "/" .. MAX_RECHECK_RETRIES .. ").", "warning")
						if recheckRetries >= MAX_RECHECK_RETRIES then
							LicenseLog("Re-verificação: Máximo de tentativas atingido. Mantendo estado atual da licença.", "warning")
							recheckRetries = 0
						end
						return
					end
					LicenseLog("Arquivo de licenças inválido (JSON malformado).", "error")
					isLicensed = false
					licenseChecked = true
					return
				end

				recheckRetries = 0

				local authorized, licenseInfo = TryAuthByIP(licenses, ip)

				if authorized then
					if CheckExpiry(licenseInfo) then
						isLicensed = false
						licenseChecked = true
						return
					end

					isLicensed = true
					licenseChecked = true
					authMethod = "ip"

					if not isRecheck then
						LicenseLog("Licença verificada com sucesso!", "success")
					end
				else
					isLicensed = false
					licenseChecked = true
					LicenseLog("  IP: " .. ip .. " não possui uma licença válida.", "error")
					--[[ LicenseLog("  Dica: Configure 'set ayx_license_key' no server.cfg para autenticação por chave.", "info") ]]
				end
			end)
		end)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES DE LICENÇA EXPOSTAS
-----------------------------------------------------------------------------------------------------------------------------------------

function IsServerLicensed()
	return isLicensed
end

function GetAuthMethod()
	return authMethod
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIALIZAÇÃO DA LICENÇA
-----------------------------------------------------------------------------------------------------------------------------------------

CreateThread(function()
	Wait(1000)
	local licenseKey = GetLicenseKey()
	--[[ if licenseKey then
		LicenseLog("License Key detectada.", "info")
	end ]]
	CheckLicense(false)
end)

if LICENSE_CONFIG.RecheckInterval > 0 then
	CreateThread(function()
		while true do
			Wait(LICENSE_CONFIG.RecheckInterval * 60 * 1000)
			if isLicensed then
				CheckLicense(true)
			end
		end
	end)
end

AddEventHandler("onResourceStart", function(resourceName)
	if resourceName == GetCurrentResourceName() then
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("animacoes",src)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local activeShared = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- LICENSE GUARD - Verifica licença e bloqueia TODAS as funções se inválida
-----------------------------------------------------------------------------------------------------------------------------------------
local function LicenseGuard()
	if not IsServerLicensed() then
		return true -- bloqueado
	end
	return false -- permitido
end

CreateThread(function()
	Wait(5000)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK LICENSE STATUS (chamado pelo client via Tunnel)
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CheckLicenseStatus()
	return IsServerLicensed()
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKBUCKET
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CheckBucket()
	if LicenseGuard() then return true end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- BYPASSPL
-----------------------------------------------------------------------------------------------------------------------------------------
function src.BypassPL(prop)
	if LicenseGuard() then return false end
	return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STATEANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.StateAnim(status,target)
	if LicenseGuard() then return end
	local source = source
	if status and target then
		activeShared[source] = target
		activeShared[target] = source
	else
		if activeShared[source] then
			local partner = activeShared[source]
			activeShared[partner] = nil
			activeShared[source] = nil
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ISADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
function src.IsAdmin()
	if LicenseGuard() then return false end
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local pID = tonumber(Passport)
		return vRP.HasGroup(pID,"Owner") or vRP.HasGroup(pID,"Admin",2) or vRP.HasGroup(Passport,"Owner") or vRP.HasGroup(Passport,"Admin",2)
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND /Y
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("y",function(source,Message)
	if LicenseGuard() then return end
	local Passport = vRP.Passport(source)
	if Passport and Config.AuthorizedPassports[tonumber(Passport)] then
		local emoteName = Message[1]
		local isFriend = (Message[2] and Message[2] == "friend") or false
		TriggerClientEvent("ayxlz_emotes:commandEmote",source,emoteName,isFriend,true)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND /Y2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("y2",function(source,Message)
	if LicenseGuard() then return end
	local Passport = vRP.Passport(source)
	if Passport and Config.AuthorizedPassports[tonumber(Passport)] then
		local emoteName = Message[1]
		TriggerClientEvent("ayxlz_emotes:forceCommandEmote",source,emoteName)
	end
end)

RegisterNetEvent("ayxlz_emotes:forceSharedEmote")
AddEventHandler("ayxlz_emotes:forceSharedEmote", function(target, emoteName, targetEmote)
	if LicenseGuard() then return end
	local source = source
	local nPlayer = tonumber(target)
	
	if nPlayer and nPlayer ~= -1 then
		local requesterPed = GetPlayerPed(source)
		local responderPed = GetPlayerPed(nPlayer)
		
		local requesterNetId = NetworkGetNetworkIdFromEntity(requesterPed)
		local responderNetId = NetworkGetNetworkIdFromEntity(responderPed)
		
		-- Captura posição e heading exatos do requester (âncora) pelo servidor
		local anchorCoords = GetEntityCoords(requesterPed)
		local anchorHeading = GetEntityHeading(requesterPed)
		
		local anchorData = {
			x = anchorCoords.x,
			y = anchorCoords.y,
			z = anchorCoords.z,
			h = anchorHeading
		}
		
		-- Player 1 (source/âncora)
		TriggerClientEvent("ayxlz_emotes:playSharedEmoteSync", source, {
			emoteName = emoteName,
			targetNetId = responderNetId,
			anchor = anchorData,
			role = "anchor"
		})
		
		-- Player 2 (target/synced)
		TriggerClientEvent("ayxlz_emotes:playSharedEmoteSync", nPlayer, {
			emoteName = targetEmote,
			targetNetId = requesterNetId,
			anchor = anchorData,
			role = "synced"
		})
		
		activeShared[source] = nPlayer
		activeShared[nPlayer] = source
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND /A (Global)
-----------------------------------------------------------------------------------------------------------------------------------------
local function globalAnimCommand(source,Message)
	if LicenseGuard() then return end
	
	if not Message[1] then
		TriggerClientEvent("ayxlz_emotes:notify", source, "Animação", "Você precisa informar o nome da animação.", "amarelo")
		return
	end


	
	local emoteName = Message[1]
	local isFriend = (Message[2] and (Message[2] == "friend" or Message[2] == "f")) or false
	
	-- Retorna false no bypass para aplicar a seguranca do arquivo config contra animations exclusivas
	TriggerClientEvent("ayxlz_emotes:commandEmote",source,emoteName,isFriend,false)
end

RegisterCommand("a", globalAnimCommand)
RegisterCommand("n", globalAnimCommand)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:request")
AddEventHandler("ayxlz_emotes:request",function(target,emoteName,targetEmote,isEveryone,randomId)
	if LicenseGuard() then return end
	local source = source
	local nPlayer = tonumber(target)
	
	if nPlayer and nPlayer ~= -1 then
		TriggerClientEvent("ayxlz_emotes:sendRequest",nPlayer,{
			source = source,
			emoteName = emoteName,
			targetEmote = targetEmote,
			accepted = false
		})
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPONSE (com sincronização de posição)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:response")
AddEventHandler("ayxlz_emotes:response",function(request,accepted)
	if LicenseGuard() then return end
	local source = source
	local requester = request.source
	
	if accepted then
		local requesterPed = GetPlayerPed(requester)
		local responderPed = GetPlayerPed(source)
		
		local requesterNetId = NetworkGetNetworkIdFromEntity(requesterPed)
		local responderNetId = NetworkGetNetworkIdFromEntity(responderPed)
		
		-- Captura posição e heading exatos do requester (âncora) pelo servidor
		local anchorCoords = GetEntityCoords(requesterPed)
		local anchorHeading = GetEntityHeading(requesterPed)
		
		local anchorData = {
			x = anchorCoords.x,
			y = anchorCoords.y,
			z = anchorCoords.z,
			h = anchorHeading
		}
		
		-- Player 1 (requester/âncora): recebe evento com role "anchor"
		TriggerClientEvent("ayxlz_emotes:playSharedEmoteSync", requester, {
			emoteName = request.emoteName,
			targetNetId = responderNetId,
			anchor = anchorData,
			role = "anchor"
		})
		
		-- Player 2 (responder): recebe evento com role "synced" + coordenadas do âncora
		TriggerClientEvent("ayxlz_emotes:playSharedEmoteSync", source, {
			emoteName = request.targetEmote,
			targetNetId = requesterNetId,
			anchor = anchorData,
			role = "synced"
		})
		
		activeShared[requester] = source
		activeShared[source] = requester
	else
		TriggerClientEvent("ayxlz_emotes:declinedRequest",requester)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELSHARED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:cancelShared")
AddEventHandler("ayxlz_emotes:cancelShared",function()
	if LicenseGuard() then return end
	local source = source
	local partner = activeShared[source]
	
	if partner then
		TriggerClientEvent("ayxlz_emotes:cancelEmote",partner)
		activeShared[partner] = nil
	end
	activeShared[source] = nil
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped",function()
	local source = source
	if activeShared[source] then
		local partner = activeShared[source]
		TriggerClientEvent("ayxlz_emotes:cancelEmote",partner)
		activeShared[partner] = nil
		activeShared[source] = nil
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND SPAWNPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("spawnped", function(source, Message)
	if LicenseGuard() then return end
	local src = source
	local Passport = vRP.Passport(src)
	
	if Passport and Config.AuthorizedPassports[tonumber(Passport)] then
		local targetId = parseInt(Message[1])
		
		if targetId <= 0 or targetId == Passport then
			-- Spawn clone of current appearance
			TriggerClientEvent("ayxlz_emotes:spawnTestPedCli", src)
			return
		end
		
		-- Fetch target data from DB
		CreateThread(function()
			local result = exports['oxmysql']:query_async('SELECT * FROM `characters` WHERE `id` = ?;',{targetId})
			if type(result) == 'table' and result[1] then
				result = result[1]
				local char = { skin = json.decode(result.skinn), clothes = json.decode(result.clothes), tattoos = json.decode(result.tattoos) }
				
				if char.skin and type(char.skin) == 'table' and next(char.skin) ~= nil then
					if type(char.clothes) == "table" and next(char.clothes) == nil then char.clothes = nil end
					if type(char.tattoos) == "table" and next(char.tattoos) == nil then char.tattoos = nil end
					
					-- Salva a roupa atual do jogador
					local result2 = exports['oxmysql']:query_async('SELECT * FROM `characters` WHERE `id` = ?;',{Passport})
					if type(result2) == 'table' and result2[1] then
						local myChar = { skin = json.decode(result2[1].skinn), clothes = json.decode(result2[1].clothes), tattoos = json.decode(result2[1].tattoos) }
						if type(myChar.clothes) == "table" and next(myChar.clothes) == nil then myChar.clothes = nil end
						if type(myChar.tattoos) == "table" and next(myChar.tattoos) == nil then myChar.tattoos = nil end
						
						-- Aplica roupa do player alvo (temporariamente)
						exports['snt-creator']:setCharacterData(src, char)
						Wait(1500)
						
						-- Clona
						TriggerClientEvent("ayxlz_emotes:spawnTestPedCli", src)
						Wait(500)
						
						-- Reverte para a roupa anterior
						exports['snt-creator']:setCharacterData(src, myChar)
						TriggerClientEvent('Notify',src,'sucesso','Ped spawnado com as roupas do passaporte <b>#'..targetId..'</b>.',"verde",5000)
						return
					end
				end
			end
			TriggerClientEvent('Notify',src,'negado','Nenhum dado encontrado para o personagem <b>#'..targetId..'</b>!',"vermelho",5000)
		end)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND SPAWNPED 2 (ENTIDADE FÍSICA)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("spawnped2", function(source, Message)
	if LicenseGuard() then return end
	local src = source
	local Passport = vRP.Passport(src)
	
	if Passport and Config.AuthorizedPassports[tonumber(Passport)] then
		local targetId = parseInt(Message[1])
		
		if targetId <= 0 or targetId == Passport then
			-- Spawn clone of current appearance
			TriggerClientEvent("ayxlz_emotes:spawnTestPed2Cli", src)
			return
		end
		
		-- Fetch target data from DB
		CreateThread(function()
			local result = exports['oxmysql']:query_async('SELECT * FROM `characters` WHERE `id` = ?;',{targetId})
			if type(result) == 'table' and result[1] then
				result = result[1]
				local char = { skin = json.decode(result.skinn), clothes = json.decode(result.clothes), tattoos = json.decode(result.tattoos) }
				
				if char.skin and type(char.skin) == 'table' and next(char.skin) ~= nil then
					if type(char.clothes) == "table" and next(char.clothes) == nil then char.clothes = nil end
					if type(char.tattoos) == "table" and next(char.tattoos) == nil then char.tattoos = nil end
					
					-- Salva a roupa atual do jogador
					local result2 = exports['oxmysql']:query_async('SELECT * FROM `characters` WHERE `id` = ?;',{Passport})
					if type(result2) == 'table' and result2[1] then
						local myChar = { skin = json.decode(result2[1].skinn), clothes = json.decode(result2[1].clothes), tattoos = json.decode(result2[1].tattoos) }
						if type(myChar.clothes) == "table" and next(myChar.clothes) == nil then myChar.clothes = nil end
						if type(myChar.tattoos) == "table" and next(myChar.tattoos) == nil then myChar.tattoos = nil end
						
						-- Aplica roupa do player alvo (temporariamente)
						exports['snt-creator']:setCharacterData(src, char)
						Wait(1500)
						
						-- Clona
						TriggerClientEvent("ayxlz_emotes:spawnTestPed2Cli", src)
						Wait(500)
						
						-- Reverte para a roupa anterior
						exports['snt-creator']:setCharacterData(src, myChar)
						TriggerClientEvent('Notify',src,'sucesso','Ped físico spawnado com as roupas do passaporte <b>#'..targetId..'</b>.',"verde",5000)
						return
					end
				end
			end
			TriggerClientEvent('Notify',src,'negado','Nenhum dado encontrado para o personagem <b>#'..targetId..'</b>!',"vermelho",5000)
		end)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND MOVERPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("moverped", function(source, Message)
	if LicenseGuard() then return end
	local src = source
	local Passport = vRP.Passport(src)
	
	if Passport and Config.AuthorizedPassports[tonumber(Passport)] then
		TriggerClientEvent("ayxlz_emotes:moveTestPedCli", src)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND REMPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rempeds", function(source, Message)
	if LicenseGuard() then return end
	local src = source
	local Passport = vRP.Passport(src)
	
	if Passport and Config.AuthorizedPassports[tonumber(Passport)] then
		local pedId = tonumber(Message[1])
		TriggerClientEvent("ayxlz_emotes:remTestPedsCli", src, pedId)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND ANIM PED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("animped", function(source, Message)
	if LicenseGuard() then return end
	local src = source
	local Passport = vRP.Passport(src)
	
	if Passport and Config.AuthorizedPassports[tonumber(Passport)] then
		local emoteName = Message[1]
		if emoteName then
			TriggerClientEvent("ayxlz_emotes:animPedCli", src, emoteName)
		else
			TriggerClientEvent("Notify",src,"Animação","Insira o nome de uma animação. Uso: /animped [nome]","vermelho",5000)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND ANIM PED COUPLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("animpedcouple", function(source, Message)
	if LicenseGuard() then return end
	local src = source
	local Passport = vRP.Passport(src)
	
	if Passport and Config.AuthorizedPassports[tonumber(Passport)] then
		local emoteName = Message[1]
		if emoteName then
			TriggerClientEvent("ayxlz_emotes:animPedCoupleCli", src, emoteName)
		else
			TriggerClientEvent("Notify",src,"Animação","Insira o nome de uma animação dupla. Uso: /animpedcouple [nome]","vermelho",5000)
		end
	end
end)

RegisterNetEvent("ayxlz_emotes:syncPedAppearanceSvr")
AddEventHandler("ayxlz_emotes:syncPedAppearanceSvr", function(netId, pedData)
	if LicenseGuard() then return end
	TriggerClientEvent("ayxlz_emotes:syncPedAppearanceCli", -1, netId, pedData)
end)

RegisterNetEvent("ayxlz_emotes:deletePedServer")
AddEventHandler("ayxlz_emotes:deletePedServer", function(netId)
	if LicenseGuard() then return end
	local entity = NetworkGetEntityFromNetworkId(netId)
	if DoesEntityExist(entity) then
		DeleteEntity(entity)
	end
end)
