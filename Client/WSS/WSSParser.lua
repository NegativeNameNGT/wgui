---@enum WSSParserType
WSSParserType = {
    Boolean = 0,
    Number = 1,
    String = 2,
    Color = 3,
}

local tColorProperties = {
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
local function ParseColor(sColorStr)
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

local function ParsePrimitiveValue(xValue)
    return xValue
end

local tTypeParser = {
    [WSSParserType.Color] = ParseColor,
    [WSSParserType.String] = ParsePrimitiveValue,
}

-- Gets the parser for a style type.
---@param iType UStyleType
---@return function
function WSS.GetParser(iType)
    return tTypeParser[iType]
end