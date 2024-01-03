-- Creates a new outline settings table.
---@param tCornerRadius Quat | nil
---@param cOutlineColor Color | nil
---@param fOutlineWidth number | nil
---@param iRoundingType RoundingType | nil
---@param bUseBrushTransparency boolean | nil
function OutlineSettings(tCornerRadius, cOutlineColor, fOutlineWidth, iRoundingType, bUseBrushTransparency)
    ---@class OutlineSettings
    local oOutlineSettings = {}
    oOutlineSettings.OutlineCorners = tCornerRadius or nil
    oOutlineSettings.OutlineColor = cOutlineColor or nil
    oOutlineSettings.OutlineWidth = fOutlineWidth or nil
    oOutlineSettings.OutlineType = iRoundingType or nil
    oOutlineSettings.UseBrushTransparency = bUseBrushTransparency or nil

    return oOutlineSettings
end

Package.Export("OutlineSettings", OutlineSettings)
