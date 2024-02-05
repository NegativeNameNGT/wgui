---@enum LayerType
LayerType = {
    Invalid = 0,
    Class = 1,
    Tag = 2,
    Dynamic = 3
}

-- Gets the layer type from the layer name.
---@param sLayerName string
---@return LayerType
local function GetLayerType(sLayerName)
    local sFirstChar = sLayerName:sub(1, 1)
    if sFirstChar == "." then
        return LayerType.Class
    elseif sFirstChar == "#" then
        return LayerType.Tag
    elseif sFirstChar == "@" then
        return LayerType.Dynamic
    end

    return LayerType.Invalid
end

-- Utility function to split a string by a delimiter
function SplitString(str, delimiter)
    local result = {}
    local pattern = "(.-)" .. delimiter
    for match in (str..delimiter):gmatch(pattern) do
        table.insert(result, match)
    end
    return result
end

-- Parses a style sheet string into a table of styles.
---@param sStyleSheet string
local function ParseStyleSheetData(sStyleSheet)
    -- Convert the style sheet string into a table.
    local tStyleSheetData = TOML.Parse(sStyleSheet)

    for sLayer, tLayerFields in pairs(tStyleSheetData) do
        -- Get the layer type.
        local iLayerType = GetLayerType(sLayer)
        if iLayerType == LayerType.Null then
            Console.Warn("[WSS] Invalid layer type for layer '" .. sLayer .. "'")
            goto continue
        end

        -- Remove the first character from the layer name.
        sLayer = sLayer:sub(2)

        -- Check if the layer is a class.
        if iLayerType == LayerType.Class then
            WSS.StyleSheets.Class[sLayer] = tLayerFields
        end

        -- Check if the layer is a tag.
        if iLayerType == LayerType.Tag then
            WSS.StyleSheets.Tag[sLayer] = tLayerFields
        end

        -- Check if the layer is a dynamic style.
        if iLayerType == LayerType.Dynamic then
            local tDynamicSplitted = SplitString(sLayer, "::")

            local sDynamicLayer = tDynamicSplitted[1]
            local sDynamicEvent = tDynamicSplitted[2]

            if not sDynamicLayer or not sDynamicEvent then
                Console.Warn("[WSS] Invalid dynamic layer name for layer '" .. sLayer .. "'")
                goto continue
            end

            if not WSS.StyleSheets.Dynamic[sDynamicLayer] then
                WSS.StyleSheets.Dynamic[sDynamicLayer] = {}
            end

            WSS.StyleSheets.Dynamic[sDynamicLayer][sDynamicEvent] = tLayerFields
        end

        ::continue::

        -- Process the layer fields for efficent use.
        for sField, xFieldValue in pairs(tLayerFields) do
            if WSS.Fields[sField] then
                local iFieldType = WSS.Fields[sField][2]

                tLayerFields[sField] = WSS.GetParser(iFieldType)(xFieldValue)
            end
        end
    end

    print(NanosTable.Dump(WSS.StyleSheets))
end

-- Load a style file.
---@param sFilePath string
function WSS.LoadFile(sFilePath)
    if not sFilePath or type(sFilePath) ~= "string" then
        return
    end

    sFilePath = "../" .. sFilePath

    local oFile = File(sFilePath)
    if not oFile:IsGood() then
        return
    end

    local sStyleSheet = oFile:Read()
    oFile:Close()
    oFile = nil

    if not sStyleSheet or sStyleSheet == "" then
        Console.Warn("[WSS] Style sheet file located at '" .. sFilePath .. "' is empty.")
        return
    end

    -- Parse the style sheet data with the file string data.
    ParseStyleSheetData(sStyleSheet)
end

-- Load a style from a string.
---@param sStyle string
---@return boolean
function WSS.LoadString(sStyle)
    if not sStyle or type(sStyle) ~= "string" then
        return false
    end

    ParseStyleSheetData(sStyle)

    return true
end

-- Returns the stylesheet data of the specified layer.
---@param sLayer string
---@param Type LayerType
---@return table | nil
function WSS.GetStyleSheet(sLayer, Type)
    if Type == LayerType.Class then
        return WSS.StyleSheets.Class[sLayer]
    elseif Type == LayerType.Tag then
        return WSS.StyleSheets.Tag[sLayer]
    elseif Type == LayerType.Dynamic then
        return WSS.StyleSheets.Dynamic[sLayer]
    end

    return nil
end

--- Updates the style sheet by applying new fields and removing obsolete ones.
---@param sNewStyleSheet string
function WSS.RefreshStyle(sNewStyleSheet)
    print("Refreshing")
end
Events.SubscribeRemote("WSS::RefreshStyle", WSS.RefreshStyle)