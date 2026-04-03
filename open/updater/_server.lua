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
    local localVersionJson = LoadResourceFile(resourceName, "updater/_version.json")
    local localData = localVersionJson and json.decode(localVersionJson) or { hash = "none" }
    
    -- Consulta o último commit da branch principal para essa pasta específica
    local commitApiUrl = "https://api.github.com/repos/" .. githubRepo .. "/commits?sha=" .. githubBranch .. "&path=" .. targetFolder .. "&per_page=1"
    
    PerformHttpRequest(commitApiUrl, function(errorCode, resultData)
        if errorCode == 200 and resultData then
            local commits = json.decode(resultData)
            if commits and commits[1] then
                local remoteHash = commits[1].sha
                
                if localData.hash ~= remoteHash then
                    print("^2["..resourceName.."] Atualização encontrada^7")
                    --[[ print("^3["..resourceName.."] Hash: " .. remoteHash:sub(1,7) .. "^7") ]]
                    
                    updateResource(remoteHash, targetFolder)
                else
                    print("^2["..resourceName.."] O script está atualizado.^7")
                end
            end
        else
            print("^1["..resourceName.."] Erro ao verificar commits no GitHub: " .. errorCode .. "^7")
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

                    -- Salva o novo hash no arquivo local
                    local newVersionJson = json.encode({ version = "1.1.0", hash = newHash })
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

-- Inicia a verificação ao carregar o servidor
CreateThread(function()
    Wait(10000)
    determineFolder(function(folder)
        checkVersion(folder)
    end)
end)
