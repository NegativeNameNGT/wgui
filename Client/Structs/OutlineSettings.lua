-- Creates a new outline settings table.
---@param tCornerRadius? Quat
---@param cOutlineColor? Color
---@param fOutlineWidth? number
---@param iRoundingType? RoundingType
---@param bUseBrushTransparency? boolean
function OutlineSettings(tCornerRadius, cOutlineColor, fOutlineWidth, iRoundingType, bUseBrushTransparency)
    ---@class OutlineSettings
    local oOutlineSettings = {}
    oOutlineSettings.OutlineCorners = tCornerRadius
    oOutlineSettings.OutlineColor = cOutlineColor
    oOutlineSettings.OutlineWidth = fOutlineWidth
    oOutlineSettings.OutlineType = iRoundingType
    oOutlineSettings.UseBrushTransparency = bUseBrushTransparency

    return oOutlineSettings
end

Package.Export("OutlineSettings", OutlineSettings)
