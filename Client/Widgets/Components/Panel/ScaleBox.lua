-- Allows you to place content with a desired size and have it scale to meet the constraints placed on this box's allocated area.
---@class ScaleBox : PanelWidget
ScaleBox = PanelWidget.Inherit("ScaleBox", {
    Slot = ScaleBoxSlot
})

-- Sets the stretching rule to apply when content is stretched.
---@param iStretch Stretch
function ScaleBox:SetStretch(iStretch)
    self:CallBlueprintEvent("SetStretch", iStretch)
end

-- Sets in which direction the content should be stretched.
---@param iStretchDirection StretchDirection
function ScaleBox:SetStretchDirection(iStretchDirection)
    self:CallBlueprintEvent("SetStretchDirection", iStretchDirection)
end

-- Sets the scale that can be specified by the User. Used only for UserSpecified stretching.
---@param fUserSpecifiedScale number
function ScaleBox:SetUserSpecifiedScale(fUserSpecifiedScale)
    self:CallBlueprintEvent("SetSpecifiedScale", fUserSpecifiedScale)
end

-- Optional bool to ignore the inherited scale. Applies inverse scaling to counteract parents before applying the local scale operation.
---@param bIgnoreInheritedScale boolean
function ScaleBox:SetIgnoreInheritedScale(bIgnoreInheritedScale)
    self:CallBlueprintEvent("SetIgnoreInheritedScale", bIgnoreInheritedScale)
end