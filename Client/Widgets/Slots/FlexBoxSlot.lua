---@class FlexBoxSlot
FlexBoxSlot = {}

-- Sets the size of the slot.
---@param self BaseWidget
---@param SizeValue number
---@param SizeRule SizeRule
function FlexBoxSlot.SetSize(self, SizeValue, SizeRule)
    if not (self and self:IsChildOfParent(FlexBox)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetSize", self, SizeValue, SizeRule)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.SizeValue = SizeValue
    tSlot.SizeRule = SizeRule
    self:SetValue("__Slot", tSlot)

    return FlexBoxSlot
end

-- Gets the size of the slot.
---@param self BaseWidget
---@return number, SizeRule
function FlexBoxSlot.GetSize(self)
    if not (self and self:IsChildOfParent(FlexBox)) then
        return
    end

    return self:GetSlotData().SizeValue or 0, self:GetSlotData().SizeRule or SizeRule.Auto
end

-- Sets the horizontal alignment of the slot.
---@param self BaseWidget
---@param Alignment HAlign
function FlexBoxSlot.SetHAlign(self, Alignment)
    if not (self and self:IsChildOfParent(FlexBox)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetHAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.HorizontalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return FlexBoxSlot
end

-- Gets the horizontal alignment of the slot.
---@param self BaseWidget
---@return HAlign
function FlexBoxSlot.GetHAlign(self)
    if not (self and self:IsChildOfParent(FlexBox)) then
        return
    end

    return self:GetSlotData().HorizontalAlignment or HAlign.Auto
end

-- Sets the vertical alignment of the slot.
---@param self BaseWidget
---@param Alignment VAlign
function FlexBoxSlot.SetVAlign(self, Alignment)
    if not (self and self:IsChildOfParent(FlexBox)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetVAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.VerticalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return FlexBoxSlot
end

-- Gets the vertical alignment of the slot.
---@param self BaseWidget
---@return VAlign
function FlexBoxSlot.GetVAlign(self)
    if not (self and self:IsChildOfParent(FlexBox)) then
        return
    end

    return self:GetSlotData().VerticalAlignment or VAlign.Auto
end