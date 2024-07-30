-- Creates a new expandable area style table.
---@param tCollapsed Brush | nil
---@param tExpanded Brush | nil
---@param fRolloutAnimationSeconds number | nil
---@return ExpandableAreaStyle
function ExpandableAreaStyle(tCollapsed, tExpanded, fRolloutAnimationSeconds)
    ---@class ExpandableAreaStyle
    local oExpandableAreaStyle = {}

    oExpandableAreaStyle.StyleCollapsed = tCollapsed or nil
    oExpandableAreaStyle.StyleExpanded = tExpanded or nil
    oExpandableAreaStyle.RolloutAnimationSeconds = fRolloutAnimationSeconds or nil

    return oExpandableAreaStyle
end