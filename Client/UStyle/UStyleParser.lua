---@enum UStyleType
UStyleType = {
    Color = 1,
    Margin = 2,
    Vector2D = 3,
    Number = 4,
    Boolean = 5,
    String = 6,
    Cursor = 7,
    HAlign = 8,
    VAlign = 9,
    Anchor = 10
}

local tColorVoidFunctions = {
    ["Random"] = Color.Random(),
    ["White"] = Color.WHITE,
    ["Black"] = Color.BLACK,
    ["Transparent"] = Color.TRANSPARENT,
    ["Red"] = Color.RED,
    ["Green"] = Color.GREEN,
    ["Blue"] = Color.BLUE,
    ["Yellow"] = Color.YELLOW,
    ["Cyan"] = Color.CYAN,
    ["Magenta"] = Color.MAGENTA,
    ["Orange"]= Color.ORANGE,
    ["Chartreuse"] = Color.CHARTREUSE,
    ["Aquamarine"] = Color.AQUAMARINE,
    ["Azure"] = Color.AZURE,
    ["Violet"] = Color.VIOLET,
    ["Rose"] = Color.ROSE
}

-- Utility function to split a string by a delimiter
local function SplitString(str, delimiter)
    local result = {}
    local pattern = "(.-)" .. delimiter
    for match in (str..delimiter):gmatch(pattern) do
        table.insert(result, match)
    end
    return result
end

-- Parses a function string and returns the function name and parameters.
---@param sFunctionStr string
---@return string, table
local function ParseFunction(sFunctionStr)
    local tFunctionData = SplitString(sFunctionStr, ":")

    local sFunctionName = tFunctionData[1]:match("^%s*(.-)%s*$") -- Trim whitespace from function name
    local tFunctionParameters = {}

    -- Check if parameters exist
    if #tFunctionData > 1 and tFunctionData[2] ~= nil and tFunctionData[2]:match("%S") then
        tFunctionParameters = SplitString(tFunctionData[2], ",%s*")
        for i, param in ipairs(tFunctionParameters) do
            tFunctionParameters[i] = param:match("^%s*(.-)%s*$") -- Trim whitespace from parameters
        end
    end

    return sFunctionName, tFunctionParameters
end

-- Parses a color string into a Color object.
---@param sColorStr string
---@return Color
function UStyle.ParseColor(sColorStr)
    -- Hex color
    if sColorStr:sub(1,1) == "#" then
        return Color.FromHEX(sColorStr)
    end

    -- Function color
    local sFunctionName, tFunctionParameters = ParseFunction(sColorStr)

    if #tFunctionParameters == 0 then
        local xColor = tColorVoidFunctions[sFunctionName]
        if type(xColor) == "function" then
            return xColor()
        end
        return xColor
    end

    local tNumberParameters = {}
    for _,v in pairs(tFunctionParameters) do
        table.insert(tNumberParameters, tonumber(v))
    end

    if sFunctionName == "rgba" then
        return Color.FromRGBA(table.unpack(tNumberParameters))
    end

    if sFunctionName == "rgb" then
        tNumberParameters[4] = 1
        return Color.FromRGBA(table.unpack(tNumberParameters))
    end

    if sFunctionName == "cymk" then
        return Color.FromCYMK(table.unpack(tNumberParameters))
    end

    if sFunctionName == "hsl" then
        return Color.FromHSL(table.unpack(tNumberParameters))
    end

    if sFunctionName == "hsv" then
        return Color.FromHSV(table.unpack(tNumberParameters))
    end

    return Color()
end

-- Parses a margin string into a Margin object.
---@param MarginValue string | number
---@return Margin
function UStyle.ParseMargin(MarginValue)
    if type(MarginValue) == "number" then
        return Margin(MarginValue)
    end

    local tMarginData = SplitString(MarginValue, ",")

    local fLeft = tonumber(tMarginData[1])
    local fTop = tonumber(tMarginData[2])
    local fRight = tonumber(tMarginData[3])
    local fBottom = tonumber(tMarginData[4])

    return Margin(fLeft, fTop, fRight, fBottom)
end

-- Parses a Vector2D string into a Vector2D object.
---@param VectorValue table
---@return Vector2D
function UStyle.ParseVector2D(VectorValue)
    return Vector2D(VectorValue[1], VectorValue[2])
end

-- Parses a Cursor enum string into a CursorType enum.
---@param CursorValue string
---@return CursorType
function UStyle.ParseCursor(CursorValue)
    return CursorType[CursorValue]
end

-- Parses a HAlign enum string into a HAlign enum.
---@param HAlignValue string
---@return HAlign
function UStyle.ParseHAlign(HAlignValue)
    local iHAlign = HAlign[HAlignValue]
    if iHAlign then
        return iHAlign
    end

    return HAlign.Fill
end

-- Parses a VAlign enum string into a VAlign enum.
---@param VAlignValue string
---@return VAlign
function UStyle.ParseVAlign(VAlignValue)
    local iVAlign = VAlign[VAlignValue]
    if iVAlign then
        return iVAlign
    end

    return VAlign.Fill
end

-- Parses a Anchor enum string into a Anchor enum.
---@param AnchorValue string
---@return Anchor
function UStyle.ParseAnchor(AnchorValue)
    local iAnchor = Anchor[AnchorValue]
    if iAnchor then
        return iAnchor
    end

    return Anchor.TopLeft
end

local tTypeParser = {
    [UStyleType.Color] = UStyle.ParseColor,
    [UStyleType.Margin] = UStyle.ParseMargin,
    [UStyleType.Vector2D] = UStyle.ParseVector2D,
    [UStyleType.Number] = tonumber,
    [UStyleType.Boolean] = function(x) return x end,
    [UStyleType.String] = function(x) return x end,
    [UStyleType.Cursor] = UStyle.ParseCursor,
    [UStyleType.HAlign] = UStyle.ParseHAlign,
    [UStyleType.VAlign] = UStyle.ParseVAlign,
    [UStyleType.Anchor] = UStyle.ParseAnchor
}

-- Gets the parser for a style type.
---@param iType UStyleType
---@return function
function UStyle.GetParser(iType)
    return tTypeParser[iType]
end
