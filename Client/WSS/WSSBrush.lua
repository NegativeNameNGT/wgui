-- Handles the brush property of a widget.
---@param oWidget BaseWidget
---@param sProperty string
---@param xValue any
function _WSS.HandleBrushProperty(oWidget, sProperty, xValue)
    local oBrush = oWidget:GetBrush() ---@type Brush

    local tBrushPropertyData = _WSS.BrushExtension[sProperty]
    if not tBrushPropertyData then
        return
    end

    local sFunction = tBrushPropertyData[1]
    oBrush[sFunction](xValue)

    oWidget.__Brush = oBrush
end