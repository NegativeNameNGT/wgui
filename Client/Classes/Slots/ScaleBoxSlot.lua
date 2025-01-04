---@class ScaleBoxSlot
ScaleBoxSlot = {}

-- Sets the horizontal alignment of the slot.
---@param self BaseWidget
---@param Alignment HAlign
function ScaleBoxSlot.SetHAlign(self, Alignment)
    if not (self and self:IsChildOfParent(ScaleBox)) then
        assert(false, "Widget is not a child of a ScaleBox.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetHAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.HorizontalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return ScaleBoxSlot
end

-- Gets the horizontal alignment of the slot.
---@param self BaseWidget
---@return HAlign
function ScaleBoxSlot.GetHAlign(self)
    if not (self and self:IsChildOfParent(ScaleBox)) then
        assert(false, "Widget is not a child of a ScaleBox.")
        return HAlign.Fill
    end

    return self:GetSlotData().HorizontalAlignment or HAlign.Fill
end

-- Sets the vertical alignment of the slot.
---@param self BaseWidget
---@param Alignment VAlign
function ScaleBoxSlot.SetVAlign(self, Alignment)
    if not (self and self:IsChildOfParent(ScaleBox)) then
        assert(false, "Widget is not a child of a ScaleBox.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetVAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.VerticalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return ScaleBoxSlot
end

-- Gets the vertical alignment of the slot.
---@param self BaseWidget
---@return VAlign
function ScaleBoxSlot.GetVAlign(self)
    if not (self and self:IsChildOfParent(ScaleBox)) then
        assert(false, "Widget is not a child of a ScaleBox.")
        return VAlign.Fill
    end

    return self:GetSlotData().VerticalAlignment or VAlign.Fill
end