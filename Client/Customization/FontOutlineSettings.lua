-- Creates a new font outline settings table.
---@param fOutlineSize number
---@param cColor Color
function FontOutlineSettings(fOutlineSize, cColor)
    ---@class FontOutlineSettings
    local oFontOutlineSettings = {}

    oFontOutlineSettings.OutlineSize = fOutlineSize or 0
    oFontOutlineSettings.OutlineColor = cColor or Color.BLACK

    -- Sets the outline size.
    ---@param fOutlineSize number
    ---@return table
    function oFontOutlineSettings.SetOutlineSize(fOutlineSize)
        oFontOutlineSettings.OutlineSize = fOutlineSize
        return oFontOutlineSettings
    end

    -- Sets the outline color.
    ---@param cColor Color
    ---@return table
    function oFontOutlineSettings.SetOutlineColor(cColor)
        oFontOutlineSettings.OutlineColor = cColor
        return oFontOutlineSettings
    end

    return oFontOutlineSettings
end
Package.Export("FontOutlineSettings", FontOutlineSettings)