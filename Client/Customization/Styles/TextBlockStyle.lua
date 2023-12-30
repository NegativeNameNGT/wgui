-- Creates a new text block style table.
---@param tHighlightShape Brush | nil
---@param tStrikeBrush Brush | nil
---@param tUnderlineBrush Brush | nil
function TextBlockStyle(tHighlightShape, tStrikeBrush, tUnderlineBrush)
    ---@class TextBlockStyle
    local oTextBlockStyle = {}
    oTextBlockStyle.HighlightShape = tHighlightShape
    oTextBlockStyle.StrikeBrush = tStrikeBrush
    oTextBlockStyle.UnderlineBrush = tUnderlineBrush

    return oTextBlockStyle
end