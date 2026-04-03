local resourceName = GetCurrentResourceName()
local githubRepo = "dylakkj/ayx-animations"
local githubBranch = "main"
local githubRawUrl = "https://raw.githubusercontent.com/" .. githubRepo .. "/" .. githubBranch .. "/"
local licenseUrl = "https://raw.githubusercontent.com/dylakkj/license/refs/heads/main/license.json"

local updateFiles = {
    "fxmanifest.lua",
    "updater/_version.lua",
    "updater/_server.lua",
    "custom.lua",
    "adapter/config.shared.lua",
    "adapter/animations.client.lua",
    "adapter/core.client.lua",
    "adapter/core.server.lua",
    "adapter/locale.client.lua"
}

local function determineFolder(cb)
    local convarKey = GetConvar("ayx_license_key", "")
    PerformHttpRequest(licenseUrl .. "?t=" .. os.time(), function(code, body)
        local isDev = false
        if code == 200 and body then
            local licenses = json.decode(body)
            -- check license key
            if convarKey ~= "" and licenses and licenses.authorized_licenses then
                for _, entry in ipairs(licenses.authorized_licenses) do
                    if type(entry) == "table" and entry.key == convarKey then
                        if entry.dev then isDev = true end
                        break
                    end
                end
            end
            
            -- check IP if not dev yet
            if not isDev and licenses and licenses.authorized_ips then
                PerformHttpRequest("https://api.ipify.org", function(ipCode, ipBody)
                    if ipCode == 200 and ipBody then
                        local ip = ipBody:gsub("%s+", "")
                        for _, entry in ipairs(licenses.authorized_ips) do
                            if type(entry) == "table" and entry.ip == ip then
                                if entry.dev then isDev = true end
                                break
                            end
                        end
                    end
                    cb(isDev and "open/" or "obfuscated/")
                end, "GET")
                return
            end
        end
        cb(isDev and "open/" or "obfuscated/")
    end, "GET", "", { ["Content-Type"] = "application/json", ["Cache-Control"] = "no-cache" })
end

local function checkVersion(targetFolder)
    --[[ print("^3["..resourceName.."] Verificando atualizações no GitHub...^7") ]]
    
    local localVersionFile = LoadResourceFile(resourceName, "updater/_version.lua")
    if not localVersionFile then return end
    
    local localVersion = localVersionFile:match('AyxAnimationsUpdater.Version = "(.-)"')
    
    PerformHttpRequest(githubRawUrl .. targetFolder .. "updater/_version.lua", function(errorCode, resultData, resultHeaders)
        if errorCode == 200 then
            local remoteVersion = resultData:match('AyxAnimationsUpdater.Version = "(.-)"')
            
            -- Normaliza as quebras de linha para evitar falsos positivos
            local safeLocal = localVersionFile:gsub("\r\n", "\n")
            local safeRemote = resultData:gsub("\r\n", "\n")
            
            -- Compara o conteúdo completo do _version.lua (para detectar diferenças de branchs com a mesma versão)
            if safeRemote ~= safeLocal then
                print("^2["..resourceName.."] Atualização ou mudança de ambiente detectada (" .. targetFolder .. "): " .. (remoteVersion or "N/A") .. " (Local: " .. (localVersion or "N/A") .. ")^7")
                updateResource(remoteVersion or "N/A", targetFolder)
            else
                print("^2["..resourceName.."] O script está utilizando a última versão.^7")
            end
        else
            print("^1["..resourceName.."] Erro ao verificar versão no GitHub: " .. errorCode .. "^7")
        end
    end, "GET")
end

local function fetchDynamicFiles(targetFolder, cb)
    -- Consulta a Tree recursiva da branch
    local apiUrl = "https://api.github.com/repos/" .. githubRepo .. "/git/trees/" .. githubBranch .. "?recursive=1"
    PerformHttpRequest(apiUrl, function(errorCode, resultData, resultHeaders)
        local streamFiles = {}
        if errorCode == 200 and resultData then
            local data = json.decode(resultData)
            if data and data.tree then
                for _, file in ipairs(data.tree) do
                    -- Verifica se o path é um arquivo e se está dentro da pasta stream do targetFolder
                    if file.type == "blob" and file.path:sub(1, #targetFolder + 7) == targetFolder .. "stream/" then
                        -- Remove o targetFolder do incio para encaixar na estrutura atual do updateFiles ("stream/arquivo.ydr")
                        local relativePath = file.path:sub(#targetFolder + 1)
                        table.insert(streamFiles, relativePath)
                    end
                end
            end
        else
            print("^1["..resourceName.."] Aviso: Nao foi possivel carregar lista dinamica de stream (Erro API: " .. errorCode .. ").^7")
        end
        cb(streamFiles)
    end, "GET", "", { ["User-Agent"] = "FiveM-AutoUpdater" })
end

function updateResource(newVersion, targetFolder)
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
                    print("^1["..resourceName.."] Erro critico ao baixar " .. fileName .. " (Pode ser ignorado se for placeholder)^7")
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
                        print("^5["..resourceName.."] Arquivo atualizado: " .. savePath .. "^7")
                    end
                    
                    print("^2["..resourceName.."] Arquivos atualizados com sucesso ("..#finalUpdateList.." arquivos avaliados)!^7")
                    
                    -- Thread para enviar 5 alertas no console CMD
                    CreateThread(function()
                        for i = 1, 5 do
                            print("^1["..resourceName.."] Novas atualizacoes aplicadas, reinicie o servidor...^7")
                            
                            if i < 5 then Wait(1000) end
                        end
                    end)
                end
            end, "GET")
        end
    end)
end

-- Inicia a verificação ao carregar o servidor
CreateThread(function()
    Wait(10000)
    determineFolder(function(folder)
        checkVersion(folder)
    end)
end)
