local resourceName = GetCurrentResourceName()
local githubRepo = "dylakkj/ayx-animations"
local githubBranch = "main"
local githubRawUrl = "https://raw.githubusercontent.com/" .. githubRepo .. "/" .. githubBranch .. "/"
local licenseUrl = "https://raw.githubusercontent.com/dylakkj/license/refs/heads/main/license.json"

local updateFiles = {
    "fxmanifest.lua",
    "updater/_version.json",
    "updater/_server.lua",
    "custom.lua",
    "adapter/config.shared.lua",    
    "adapter/animations.client.lua",
    "adapter/core.client.lua",
    "adapter/core.server.lua"
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- UTILITÁRIOS DE IP (EQUIPARADO AO CORE)
-----------------------------------------------------------------------------------------------------------------------------------------
local function GetServerPublicIP(cb)
    PerformHttpRequest("https://api.ipify.org", function(code, body)
        if code == 200 and body and #body > 0 then
            cb(body:gsub("%s+", ""))
        else
            PerformHttpRequest("https://api64.ipify.org", function(code2, body2)
                if code2 == 200 and body2 and #body2 > 0 then
                    cb(body2:gsub("%s+", ""))
                else
                    PerformHttpRequest("https://ifconfig.me/ip", function(code3, body3)
                        if code3 == 200 and body3 and #body3 > 0 then
                            cb(body3:gsub("%s+", ""))
                        else
                            cb(nil)
                        end
                    end)
                end
            end)
        end
    end)
end

local function determineFolder(cb)
    local convarKey = ""
    
    local localFile = LoadResourceFile(resourceName, "_license.json")
    if localFile then
        local data = json.decode(localFile)
        if data and data.key then
            convarKey = data.key
        end
    end

    if convarKey == "" then
        convarKey = GetConvar("ayx_license_key", "")
    end

    PerformHttpRequest(licenseUrl .. "?t=" .. os.time(), function(code, body)
        if code ~= 200 or not body then
            cb(nil)
            return
        end

        local licenses = json.decode(body)
        if not licenses then cb(nil) return end

        local isDev = false
        local isAuthorized = false

        -- 1. Verifica pela Key
        if convarKey ~= "" and licenses.authorized_licenses then
            for _, entry in ipairs(licenses.authorized_licenses) do
                if type(entry) == "table" and entry.key == convarKey then
                    isAuthorized = true
                    if entry.dev then isDev = true end
                    break
                end
            end
        end

        -- 2. Se não autorizado pela key, verifica pelo IP (Fallback)
        if not isAuthorized and licenses.authorized_ips then
            GetServerPublicIP(function(ip)
                if ip then
                    for _, entry in ipairs(licenses.authorized_ips) do
                        if (type(entry) == "table" and entry.ip == ip) or (type(entry) == "string" and entry == ip) then
                            isAuthorized = true
                            if type(entry) == "table" and entry.dev then isDev = true end
                            break
                        end
                    end
                end

                if isAuthorized then
                    if isDev then
                        print("^3["..resourceName.."] Autenticado: Versão de Desenvolvimento (Open)^7")
                    end
                    cb(isDev and "open/" or "obfuscated/")
                else
                    --[[ print("^1["..resourceName.."] Erro de Autenticação: IP ou Chave não autorizados para atualizações.^7") ]]
                    cb(nil) -- Bloqueado
                end
            end)
            return
        end

        if isAuthorized then
            if isDev then
                print("^3["..resourceName.."] Versão de Desenvolvimento (Open)^7")
            end
            cb(isDev and "open/" or "obfuscated/")
        else
            print("^1["..resourceName.."] Erro de Autenticação: Licença não encontrada.^7")
            cb(nil) -- Bloqueado
        end
    end, "GET", "", { ["Content-Type"] = "application/json", ["Cache-Control"] = "no-cache" })
end

local function checkVersion(targetFolder)
    local localVersionJson = LoadResourceFile(resourceName, "updater/_version.json")
    local localData = localVersionJson and json.decode(localVersionJson) or { hash = "none", folder = "none" }
    
    local commitApiUrl = "https://api.github.com/repos/" .. githubRepo .. "/commits?sha=" .. githubBranch .. "&path=" .. targetFolder .. "&per_page=1"
    
    PerformHttpRequest(commitApiUrl, function(errorCode, resultData)
        if errorCode == 200 and resultData then
            local commits = json.decode(resultData)
            if commits and commits[1] then
                local remoteHash = commits[1].sha
                
                -- Verifica se o hash mudou ou se o tipo de pasta (open/obfuscated) mudou
                if localData.hash ~= remoteHash or localData.folder ~= targetFolder then
                    if localData.folder ~= targetFolder and localData.folder ~= "none" then
                        print("^3["..resourceName.."] Alteração de licença detectada (Mudando para " .. targetFolder .. ")^7")
                    end
                    print("^2["..resourceName.."] Baixando atualizações...^7")
                    
                    updateResource(remoteHash, targetFolder)
                else
                    print("^2["..resourceName.."] Você está utilizando a última versão.^7")
                end
            end
        else
            print("^1["..resourceName.."] Erro ao obter informações do servidor de atualizações: " .. errorCode .. "^7")
        end
    end, "GET", "", { ["User-Agent"] = "FiveM-AutoUpdater" })
end

local function fetchDynamicFiles(targetFolder, cb)
    local apiUrl = "https://api.github.com/repos/" .. githubRepo .. "/git/trees/" .. githubBranch .. "?recursive=1"
    PerformHttpRequest(apiUrl, function(errorCode, resultData)
        local streamFiles = {}
        if errorCode == 200 and resultData then
            local data = json.decode(resultData)
            if data and data.tree then
                for _, file in ipairs(data.tree) do
                    if file.type == "blob" and file.path:sub(1, #targetFolder + 7) == targetFolder .. "stream/" then
                        local relativePath = file.path:sub(#targetFolder + 1)
                        table.insert(streamFiles, relativePath)
                    end
                end
            end
        end
        cb(streamFiles)
    end, "GET", "", { ["User-Agent"] = "FiveM-AutoUpdater" })
end

function updateResource(newHash, targetFolder)
    fetchDynamicFiles(targetFolder, function(dynamicFiles)
        local finalUpdateList = {}
        for _, file in ipairs(updateFiles) do table.insert(finalUpdateList, file) end
        for _, file in ipairs(dynamicFiles) do table.insert(finalUpdateList, file) end
        
        local downloadedData = {}
        local filesFinished = 0

        for _, fileName in ipairs(finalUpdateList) do
            PerformHttpRequest(githubRawUrl .. targetFolder .. fileName, function(errorCode, resultData)
                if errorCode == 200 then
                    downloadedData[fileName] = resultData
                else
                    print("^1["..resourceName.."] Erro ao baixar " .. fileName .. "^7")
                end
                
                filesFinished = filesFinished + 1
                
                if filesFinished == #finalUpdateList then
                    for file, content in pairs(downloadedData) do
                        local savePath = file
                        if savePath:sub(1, 7) == "stream/" then
                            local baseName = savePath:match("([^/]+)$") or savePath
                            savePath = "stream/" .. baseName
                        end
                        SaveResourceFile(resourceName, savePath, content, -1)
                        print("^5["..resourceName.."] Atualizado: " .. savePath .. "^7")
                    end

                    local newVersionJson = json.encode({ version = "1.1.0", hash = newHash, folder = targetFolder })
                    SaveResourceFile(resourceName, "updater/_version.json", newVersionJson, -1)
                    
                    print("^2["..resourceName.."] Atualização concluída com sucesso!^7")
                    
                    CreateThread(function()
                        for i = 1, 5 do
                            print("^1["..resourceName.."] Novas atualizações aplicadas, reinicie o servidor...^7")
                            Wait(1000)
                        end
                    end)
                end
            end, "GET")
        end
    end)
end

CreateThread(function()
    Wait(15000)
    determineFolder(function(folder)
        if folder then
            checkVersion(folder)
        end
    end)
end)
