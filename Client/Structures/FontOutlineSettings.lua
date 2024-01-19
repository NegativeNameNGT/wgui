-- Creates a new font outline settings table.
---@param fOutlineSize number
---@param cColor Color
function FontOutlineSettings(fOutlineSize, cColor)
    ---@class FontOutlineSettings
    local oFontOutlineSettings = {}

    oFontOutlineSettings.OutlineSize = fOutlineSize or 0
    oFontOutlineSettings.OutlineColor = cColor or Color.BLACK

    -- Sets the outline size.
    ---@param fNewOutlineSize number
    ---@return table
    function oFontOutlineSettings.SetOutlineSize(fNewOutlineSize)
        oFontOutlineSettings.OutlineSize = fNewOutlineSize
        return oFontOutlineSettings
    end

    -- Sets the outline color.
    ---@param cNewColor Color
    ---@return table
    function oFontOutlineSettings.SetOutlineColor(cNewColor)
        oFontOutlineSettings.OutlineColor = cNewColor
        return oFontOutlineSettings
    end

    return oFontOutlineSettings
end

Package.Export("FontOutlineSettings", FontOutlineSettings)
