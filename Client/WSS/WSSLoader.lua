---@enum LayerType
LayerType = {
    Invalid = 0,
    Class = 1,
    Tag = 2,
    Dynamic = 3
}

--- A Stylesheet configuration where the first element is the ID and the second element is the Fields.
--- @class Stylesheet
--- @field [1] string | BaseWidget @The identifier of the stylesheet, either a string or a BaseWidget.
--- @field [2] StylesheetFields @The fields of the stylesheet.

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
    -- Escape the delimiter if it's a dot
    local pattern = "(.-)" .. (delimiter == "." and "%." or delimiter)
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
            _WSS.StyleSheets.Class[sLayer .. " Class"] = tLayerFields
        end

        -- Check if the layer is a tag.
        if iLayerType == LayerType.Tag then
            _WSS.StyleSheets.Tag[sLayer] = tLayerFields
        end

        -- Check if the layer is a dynamic style.
        if iLayerType == LayerType.Dynamic then
            local tDynamicSplitted = SplitString(sLayer, "->")

            local sDynamicLayer = tDynamicSplitted[1]
            local sDynamicEvent = tDynamicSplitted[2]

            if not sDynamicLayer or not sDynamicEvent then
                Console.Warn("[WSS] Invalid dynamic layer name for layer '" .. sLayer .. "'")
                goto continue
            end

            -- Checks if the layer is a class.
            if _WSS.WidgetClasses[sDynamicLayer .. " Class"] then
                sDynamicLayer = sDynamicLayer .. " Class"
            end

            if not _WSS.StyleSheets.Dynamic[sDynamicLayer] then
                _WSS.StyleSheets.Dynamic[sDynamicLayer] = {}
            end

            _WSS.StyleSheets.Dynamic[sDynamicLayer][sDynamicEvent] = tLayerFields
        end

        ::continue::

        -- Process the layer fields for efficent use.
        for sField, xFieldValue in pairs(tLayerFields) do
            if _WSS.Fields[sField] then
                local iFieldType = _WSS.Fields[sField][2]

                -- Checks whether or not the field is a dynamic attribute.
                if not (type(xFieldValue) == "string" and xFieldValue:sub(1, 1) == "$") then
                    tLayerFields[sField] = _WSS.GetParser(iFieldType)(xFieldValue)
                end
            end
        end
    end
end

-- Processes a stylesheet.
---@param xIdentifierOrClass string
---@param tFields StylesheetFields
local function ProcessStylesheet(xIdentifierOrClass, tFields)
    -- Get the layer type.
    local iLayerType = GetLayerType(xIdentifierOrClass)
    if iLayerType == LayerType.Null then
        Console.Warn("[WSS] Invalid layer type for layer '" .. xIdentifierOrClass .. "'")
        return
    end

    -- Remove the first character from the layer name.
    xIdentifierOrClass = xIdentifierOrClass:sub(2)

    -- Check if the layer is a class.
    if iLayerType == LayerType.Class then
        _WSS.StyleSheets.Class[xIdentifierOrClass .. " Class"] = tFields
    end

    -- Check if the layer is a tag.
    if iLayerType == LayerType.Tag then
        _WSS.StyleSheets.Tag[xIdentifierOrClass] = tFields
    end

    -- Check if the layer is a dynamic style.
    if iLayerType == LayerType.Dynamic then
        local tDynamicSplitted = SplitString(xIdentifierOrClass, "->")

        local sDynamicLayer = tDynamicSplitted[1]
        local sDynamicEvent = tDynamicSplitted[2]

        if not sDynamicLayer or not sDynamicEvent then
            Console.Warn("[WSS] Invalid dynamic layer name for layer '" .. xIdentifierOrClass .. "'")
            return
        end

        -- Checks if the layer is a class.
        if _WSS.WidgetClasses[sDynamicLayer .. " Class"] then
            sDynamicLayer = sDynamicLayer .. " Class"
        end
        
        if not _WSS.StyleSheets.Dynamic[sDynamicLayer] then
            _WSS.StyleSheets.Dynamic[sDynamicLayer] = {}
        end

        _WSS.StyleSheets.Dynamic[sDynamicLayer][sDynamicEvent] = tFields
    end
end

--- Processes a list of Stylesheets.
--- @vararg string | StylesheetFields
function ExtendStylesheets(...)
    local tStylesheets = {...}
    if not tStylesheets or type(tStylesheets) ~= "table" or next(tStylesheets) == nil then
        Console.Warn("[WSS] Invalid or empty style sheet data.")
        return
    end

    local i = 1
    while i <= #tStylesheets do
        local xIdentifier = tStylesheets[i]
        local tFields = nil

        -- Checking if the value is a string (pair of identifier and fields)
        if type(xIdentifier) == "string" or (type(xIdentifier == "table") and getmetatable(xIdentifier) ~= nil and NanosUtils.IsEntityValid(xIdentifier)) then
            xIdentifier = tStylesheets[i]

            -- Checking if the next value is a table (fields)
            if type(tStylesheets[i + 1]) == "table" then
                tFields = tStylesheets[i + 1]
            else
                if type(tStylesheets[i + 1]) == "string" then
                    if type(tStylesheets[i + 2]) == "table" then
                        tFields = tStylesheets[i + 2]

                        i = i - 1
                        goto continue
                    end
                end
                Console.Error("[WSS] The fields for the identifier '" .. xIdentifier .. "' should be a table.")
                break
            end
        else
            Console.Error("[WSS] The identifier should be a string or a BaseWidget.")
            break
        end

        ::continue::

        ProcessStylesheet(xIdentifier, tFields)

        i = i + 2
    end
end
Package.Export("ExtendStylesheets", ExtendStylesheets)

--- Makes a table of stylesheet fields.
--- @param tStylesheet StylesheetFields
--- @return table
function MakeStylesheet(tStylesheet)
    return tStylesheet
end
Package.Export("MakeStylesheet", MakeStylesheet)

-- Returns the stylesheet data of the specified layer.
---@param sLayer string
---@param Type LayerType
---@return table | nil
function _WSS.GetStyleSheet(sLayer, Type)
    if Type == LayerType.Class then
        return _WSS.StyleSheets.Class[sLayer]
    elseif Type == LayerType.Tag then
        return _WSS.StyleSheets.Tag[sLayer]
    elseif Type == LayerType.Dynamic then
        return _WSS.StyleSheets.Dynamic[sLayer]
    end

    return nil
end