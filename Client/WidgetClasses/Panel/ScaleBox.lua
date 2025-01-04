-- Allows you to place content with a desired size and have it scale to meet the constraints placed on this box's allocated area.
---@class ScaleBox : ContentWidget
ScaleBox = PanelWidget.Inherit("ScaleBox", {
    Slot = ScaleBoxSlot
})

-- Sets the stretching rule to apply when content is stretched.
---@generic T
---@param self T
---@param iStretch Stretch
---@return T
function ScaleBox:SetStretch(iStretch)
    self:CallBlueprintEvent("SetStretch", iStretch)

    return self
end

-- Sets in which direction the content should be stretched.
---@generic T
---@param self T
---@param iStretchDirection StretchDirection
---@return T
function ScaleBox:SetStretchDirection(iStretchDirection)
    self:CallBlueprintEvent("SetStretchDirection", iStretchDirection)

    return self
end

-- Sets the scale that can be specified by the User. Used only for UserSpecified stretching.
---@generic T
---@param self T
---@param fUserSpecifiedScale number
---@return T
function ScaleBox:SetUserSpecifiedScale(fUserSpecifiedScale)
    self:CallBlueprintEvent("SetSpecifiedScale", fUserSpecifiedScale)

    return self
end

-- Optional bool to ignore the inherited scale. Applies inverse scaling to counteract parents before applying the local scale operation.
---@generic T
---@param self T
---@param bIgnoreInheritedScale boolean
---@return T
function ScaleBox:SetIgnoreInheritedScale(bIgnoreInheritedScale)
    self:CallBlueprintEvent("SetIgnoreInheritedScale", bIgnoreInheritedScale)

    return self
end