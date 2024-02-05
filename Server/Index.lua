UStyle = UStyle or {}
local iReloadTimer = nil
local tAutoReloadFiles = {}

-- Called when a style file content has changed.
---@param sFileData string
local function OnFileChanged(sFileData)
    Events.BroadcastRemote("WSS::RefreshStyle", sFileData)
end

function UStyle.UpdateChanges()
    for oFile, _ in pairs(tAutoReloadFiles) do
        WatchFileData(oFile)
    end
end

-- Starts the auto-reload system for styles.
---@param fIntervalInSeconds number
function UStyle.StartInterval(fIntervalInSeconds)
    iReloadTimer = Timer.SetInterval(UStyle.UpdateChanges, (fIntervalInSeconds or 0.5) * 1000)
end

-- Stops the auto-reload system for styles.
function UStyle.StopInterval()
    if iReloadTimer then
        Timer.ClearInterval(iReloadTimer)
        iReloadTimer = nil
    end
end

-- Pauses the auto-reload system for styles.
function UStyle.PauseInterval()
    if iReloadTimer then
        Timer.Pause(iReloadTimer)
    end
end

-- Resumes the auto-reload system for styles.
function UStyle.ResumeInterval()
    if iReloadTimer then
        Timer.Resume(iReloadTimer)
    end
end

-- Add a style file to the auto-reload list.
---@param sFilePath string
function UStyle.AddFileToAutoReload(sFilePath)
    if not sFilePath or type(sFilePath) ~= "string" then
        return
    end

    sFilePath = "Packages/" .. sFilePath

    local oFile = File(sFilePath)
    if not oFile:IsGood() then
        return false
    end

    WatchFileData(oFile)
end

-- Reads a style file and checks if it has changed.
---@param oFile File
function WatchFileData(oFile)
    UStyle.PauseInterval()

    if not oFile or not oFile:IsGood() then
        return
    end

    oFile:Seek(0)
    oFile:ReadAsync(0, function(sFileData)
        if not oFile then
            return
        end

        local sOldFileData = tAutoReloadFiles[oFile]
        tAutoReloadFiles[oFile] = sFileData

        if ((sOldFileData or sFileData) ~= sFileData) then
            OnFileChanged(sFileData)
        end

        UStyle.ResumeInterval()
    end)
end

Package.Subscribe("Unload", function ()
    UStyle.StopInterval()

    for oFile, _ in pairs(tAutoReloadFiles) do
        oFile:Close()
        oFile = nil
    end
end)

UStyle.StartInterval(0.1)
UStyle.AddFileToAutoReload("wgui/Client/WSS/wss_style.toml")

Events.SubscribeRemote("test", function (_, st)
    print(NanosTable.Dump(st))
end)