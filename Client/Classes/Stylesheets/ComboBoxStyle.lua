-- Creates a new combo box style table.
---@param ButtonStyle ButtonStyle | nil
---@param Arrow Brush | nil
function ComboBoxStyle(ButtonStyle, Arrow)
    ---@class ComboBoxStyle
    local oComboBoxStyle = {}
    oComboBoxStyle.ButtonStyle = ButtonStyle or {}
    oComboBoxStyle.Arrow = Arrow or nil

    return oComboBoxStyle
end