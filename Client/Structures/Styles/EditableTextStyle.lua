-- UNUSED: Creates a new editable text style table.
---@param tSelectedBackground Brush | nil
---@param tComposingBackground Brush | nil
---@param tCaret Brush | nil
function EditableTextStyle(tSelectedBackground, tComposingBackground, tCaret)
    ---@class EditableTextStyle
    local oEditableTextStyle = {}
    oEditableTextStyle.SelectedBackground = tSelectedBackground
    oEditableTextStyle.ComposingBackground = tComposingBackground
    oEditableTextStyle.Caret = tCaret

    return oEditableTextStyle
end