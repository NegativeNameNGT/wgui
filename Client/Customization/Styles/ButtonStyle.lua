-- Creates a new button style table.
---@param tNormal Brush | nil
---@param tHovered Brush | nil
---@param tPressed Brush | nil
---@param tNormalPadding Margin | nil
---@param tPressedPadding Margin | nil
function ButtonStyle(tNormal, tHovered, tPressed, tNormalPadding, tPressedPadding)
    ---@class ButtonStyle
    local oButtonStyle = {}
    oButtonStyle.Normal = tNormal or nil
    oButtonStyle.Hovered = tHovered or nil
    oButtonStyle.Pressed = tPressed or nil
    oButtonStyle.NormalPadding = tNormalPadding or nil
    oButtonStyle.PressedPadding = tPressedPadding or nil

    return oButtonStyle
end