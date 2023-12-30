-- Creates a new button style table.
---@param tNormal Brush | nil
---@param tHovered Brush | nil
---@param tThumb Brush | nil
---@param tHoveredThumb Brush | nil
---@param fBarThickness number | nil
function SliderStyle(tNormal, tHovered, tThumb, tHoveredThumb, fBarThickness)
    ---@class SliderStyle
    local oSliderStyle = {}
    oSliderStyle.Normal = tNormal
    oSliderStyle.Hovered = tHovered
    oSliderStyle.Thumb = tThumb
    oSliderStyle.HoveredThumb = tHoveredThumb
    oSliderStyle.BarThickness = fBarThickness

    return oSliderStyle
end