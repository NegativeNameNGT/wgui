-- UStyle is a CSS-type styling for widgets (TOML-based).

UStyle = {}

local bIsAutoReloadEnabled = false
local tAutoReloadFiles = {}
local iAutoReloadTimer = -1

local tStyles = {
    Class = {},
    Tag = {}
}

local tWidgetClasses = {}

local function MergeStyles(tOriginal, tNew)
    for sKey, xValue in pairs(tNew) do
        if type(xValue) == "table" then
            if not tOriginal[sKey] then
                tOriginal[sKey] = {}
            end

            MergeStyles(tOriginal[sKey], xValue)
        else
            tOriginal[sKey] = xValue
        end
    end
end

---@param sFileData string
---@return table
local function HandleStyleData(sFileData)
    local tFileStyleData = TOML.Parse(sFileData)

    for sKey, tValue in pairs(tFileStyleData) do
        if sKey:sub(1, 1) == "." then
            local sClassName = sKey:sub(2) .. " Class"

            if not tWidgetClasses[sClassName] then
                assert(false, "[WGUI, UStyle] A style class must be a valid widget class.")
            end

            if not tStyles.Class[sClassName] then
                tStyles.Class[sClassName] = {}
            end

            tStyles.Class[sClassName] = tValue
        elseif sKey:sub(1, 1) == "#" then
            local sIdentifierName = sKey:sub(2)
            tStyles.Tag[sIdentifierName] = tValue
        else
            assert(false, "[WGUI, UStyle] A style key must be a class or identifier.")
        end
    end

    return tStyles
end

-- Load a style file
---@param sFilePath string
---@param bAsynchronous boolean | nil
---@return boolean
function WGUI.LoadStyleFile(sFilePath, bAsynchronous)
    if not sFilePath or type(sFilePath) ~= "string" then
        return false
    end

    sFilePath = "../" .. sFilePath

    local oFile = File(sFilePath)
    if not oFile:IsGood() then
        return false
    end

    local function OnFileRead(sFileData)
        oFile:Close()
        oFile = nil

        HandleStyleData(sFileData)
    end

    if bAsynchronous then
        oFile:ReadAsync(0, OnFileRead)
    else
        OnFileRead(oFile:Read())
    end

    return true
end

-- Load a style from a string
---@param sStyle string
---@return boolean
function WGUI.LoadStyle(sStyle)
    if not sStyle or type(sStyle) ~= "string" then
        return false
    end

    HandleStyleData(sStyle)

    return true
end

---@param cWidgetClass table
---@return table
function UStyle.GetWidgetStyleSheet(cWidgetClass)
    local tStyleSheet = tStyles.Class[tostring(cWidgetClass)]
    if not tStyleSheet then
        if cWidgetClass.GetParentClass() then
            return UStyle.GetWidgetStyleSheet(cWidgetClass.GetParentClass())
        end
        return {}
    end
    return tStyleSheet
end

---@return boolean
function UStyle.HasWidgetStyleSheet(cWidgetClass)
    return UStyle.GetWidgetStyleSheet(cWidgetClass) ~= nil
end

---@param sTag string
---@return table
function UStyle.GetTagStyleSheet(sTag)
    return tStyles.Tag[sTag]
end

---@param sTag string
---@return boolean
function UStyle.HasTagStyleSheet(sTag)
    return tStyles.Tag[sTag] ~= nil
end

---@param WidgetClass BaseWidget
---@param tFields table
function UStyle.AddWidgetFields(WidgetClass, tFields)
    if not WidgetClass.__Fields then
        WidgetClass.__Fields = {}
    end

    for sKey, xValue in pairs(tFields) do
        WidgetClass.__Fields[sKey] = xValue
    end
end

---@return table
function UStyle.GetWidgetFields(oWidget)
    return oWidget.__Fields
end

---@param cClass BaseWidget
local function OnWidgetClassRegister(cClass)
    tWidgetClasses[tostring(cClass)] = cClass
end
BaseWidget.Subscribe("ClassRegister", OnWidgetClassRegister)

local function DeepCopy(tOriginal)
    if type(tOriginal) ~= 'table' then return tOriginal end

    local tCopy = {}
    for k, v in pairs(tOriginal) do
        if type(v) == 'table' then
            tCopy[k] = DeepCopy(v)
        else
            tCopy[k] = v
        end
    end
    return tCopy
end

---@param tOldData table
---@param tNewData table
---@return table
local function CheckStyleDataChanges(tOldData, tNewData)
    local tChanges = {}

    local function CompareStyles(tOld, tNew, tChange, iDepth)
        -- Check for new or changed fields
        for sKey, xNewValue in pairs(tNew) do
            local xOldValue = tOld[sKey]

            -- If the key exists in both, but they are different
            if xOldValue and type(xNewValue) == "table" and type(xOldValue) == "table" then
                local tSubChanges = {}
                CompareStyles(xOldValue, xNewValue, tSubChanges, iDepth + 1)

                if next(tSubChanges) ~= nil then
                    if iDepth >= 2 then
                        tChange[sKey] = xNewValue
                    else
                        tChange[sKey] = tSubChanges
                    end
                end
            elseif xOldValue ~= xNewValue then
                tChange[sKey] = xNewValue
            end
        end

        -- Check for deleted fields
        for sKey, _ in pairs(tOld) do
            if not tNew[sKey] then
                tChange[sKey] = "_DELETED_"
            end
        end

    end

    CompareStyles(tOldData, tNewData, tChanges, 0)

    return tChanges
end

-- Called by the server to reload the style data.
---@param sFileData string
local function ReloadStyleData(sFileData)
    local tOldData = DeepCopy(tStyles)

    local tChanges = CheckStyleDataChanges(tOldData, HandleStyleData(sFileData))
    tChanges.Class = tChanges.Class or {}
    tChanges.Tag = tChanges.Tag or {}

    local function HasWidgetStyleSheet(cWidgetClass)
        return tChanges.Class[tostring(cWidgetClass)] ~= nil
    end

    local function GetWidgetStyleSheet(cWidgetClass)
        return tChanges.Class[tostring(cWidgetClass)]
    end

    local function HasTagStyleSheet(sTag)
        return tChanges.Tag[sTag] ~= nil
    end

    local function GetTagStyleSheet(sTag)
        return tChanges.Tag[sTag]
    end

    for _,v in pairs(Widget.GetAll()) do
        if not v:IsA(BaseWidget) then
            return
        end

        if HasWidgetStyleSheet(v:GetClass()) then
            UStyle.ApplyWidgetStyle(v, GetWidgetStyleSheet(v:GetClass()), true)
        end

        local sTag = v:GetValue("__StyleTag")

        if not sTag or sTag == "" then
            goto continue
        end

        if HasTagStyleSheet(sTag) then
            UStyle.ApplyWidgetStyle(v, GetTagStyleSheet(sTag), false)
        end

        ::continue::
    end
end
Events.SubscribeRemote("WGUI::ReloadStyleData", ReloadStyleData)
