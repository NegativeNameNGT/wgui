-- Creates a new scroll bar style table.
---@param fBarThickness number | nil
---@param tHorizontalBackground Brush | nil
---@param tVerticalBackground Brush | nil
---@param tVerticalTopSlot Brush | nil
---@param tHorizontalTopSlot Brush | nil
---@param tVerticalBottomSlot Brush | nil
---@param tHorizontalBottomSlot Brush | nil
---@param tNormalThumb Brush | nil
---@param tHoveredThumb Brush | nil
---@param tDraggedThumb Brush | nil
function ScrollBarStyle(fBarThickness, tHorizontalBackground, tVerticalBackground, tVerticalTopSlot, tHorizontalTopSlot, tVerticalBottomSlot, tHorizontalBottomSlot, tNormalThumb, tHoveredThumb, tDraggedThumb)
    ---@class ScrollBarStyle
    local oScrollBarStyle = {}
    oScrollBarStyle.BarThickness = fBarThickness or 16
    oScrollBarStyle.HorizontalBackground = tHorizontalBackground or nil
    oScrollBarStyle.VerticalBackground = tVerticalBackground or nil
    oScrollBarStyle.VerticalTopSlot = tVerticalTopSlot or nil
    oScrollBarStyle.HorizontalTopSlot = tHorizontalTopSlot or nil
    oScrollBarStyle.VerticalBottomSlot = tVerticalBottomSlot or nil
    oScrollBarStyle.HorizontalBottomSlot = tHorizontalBottomSlot or nil
    oScrollBarStyle.NormalThumb = tNormalThumb or nil
    oScrollBarStyle.HoveredThumb = tHoveredThumb or nil
    oScrollBarStyle.DraggedThumb = tDraggedThumb or nil

    return oScrollBarStyle
end