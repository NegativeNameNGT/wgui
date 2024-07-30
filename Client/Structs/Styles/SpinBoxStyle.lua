-- Creates a new spinbox style table.
---@param tBackground Brush | nil
---@param tHoveredBackground Brush | nil
---@param tActiveBackground Brush | nil
---@param tActiveFillBrush Brush | nil
---@param tHoveredFillBrush Brush | nil
---@param tInactiveFillBrush Brush | nil
---@param tArrowBrush Brush | nil
---@param tTextPadding Margin | nil
---@param tInsetPadding Margin | nil
function SpinBoxStyle(tBackground, tHoveredBackground, tActiveBackground, tActiveFillBrush, tHoveredFillBrush, tInactiveFillBrush, tArrowBrush, tTextPadding, tInsetPadding)
    ---@class SpinBoxStyle
    local oSpinBoxStyle = {}
    oSpinBoxStyle.Background = tBackground or nil
    oSpinBoxStyle.HoveredBackground = tHoveredBackground or nil
    oSpinBoxStyle.ActiveBackground = tActiveBackground or nil
    oSpinBoxStyle.ActiveFillBrush = tActiveFillBrush or nil
    oSpinBoxStyle.HoveredFillBrush = tHoveredFillBrush or nil
    oSpinBoxStyle.InactiveFillBrush = tInactiveFillBrush or nil
    oSpinBoxStyle.ArrowBrush = tArrowBrush or nil
    oSpinBoxStyle.TextPadding = tTextPadding or nil
    oSpinBoxStyle.InsetPadding = tInsetPadding or nil

    return oSpinBoxStyle
end