---@enum WSSParserType
WSSParserType = {
    Boolean = 0,
    Number = 1,
    String = 2,
    Color = 3,
    Vector2D = 4,
    Margin = 5,
    Enum = 6,
    Quat = 7,
    FontData = 8,
    FlexSize = 9
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