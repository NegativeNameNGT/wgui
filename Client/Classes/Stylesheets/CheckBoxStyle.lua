-- Creates a new check box style table.
---@param tBackground Brush | nil
---@param tHoveredBackground Brush | nil
---@param tPressedBackground Brush | nil
---@param tUnchecked Brush | nil
---@param tHoveredUnchecked Brush | nil
---@param tPressedUnchecked Brush | nil
---@param tChecked Brush | nil
---@param tHoveredChecked Brush | nil
---@param tPressedChecked Brush | nil
function CheckBoxStyle(tBackground, tHoveredBackground, tPressedBackground, tUnchecked, tHoveredUnchecked, tPressedUnchecked, tChecked, tHoveredChecked, tPressedChecked)
    ---@class CheckBoxStyle
    local oCheckBoxStyle = {}
    oCheckBoxStyle.Background = tBackground
    oCheckBoxStyle.HoveredBackground = tHoveredBackground
    oCheckBoxStyle.PressedBackground = tPressedBackground
    oCheckBoxStyle.Unchecked = tUnchecked
    oCheckBoxStyle.HoveredUnchecked = tHoveredUnchecked
    oCheckBoxStyle.PressedUnchecked = tPressedUnchecked
    oCheckBoxStyle.Checked = tChecked
    oCheckBoxStyle.HoveredChecked = tHoveredChecked
    oCheckBoxStyle.PressedChecked = tPressedChecked
    return oCheckBoxStyle
end