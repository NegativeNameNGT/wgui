---@class FlexBoxSlot
FlexBoxSlot = {}

-- Sets the size of the slot.
---@param self BaseWidget
---@param Value number
---@param Rule SizeRule
function FlexBoxSlot.SetSize(self, Value, Rule)
    if not (self and self:IsChildOfParent(FlexBox)) then
        assert(false, "Widget is not a child of a FlexBox.")
        return
    end

    Rule = Rule or SizeRule.Fill

    self:GetParent():CallBlueprintEvent("_SetSize", self, Value, Rule)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.SizeValue = Value
    tSlot.SizeRule = Rule
    self:SetValue("__Slot", tSlot)

    return FlexBoxSlot
end

-- Gets the size of the slot.
---@param self BaseWidget
---@return number, SizeRule
function FlexBoxSlot.GetSize(self)
    if not (self and self:IsChildOfParent(FlexBox)) then
        assert(false, "Widget is not a child of a FlexBox.")
        return 0, SizeRule.Auto
    end

    return self:GetSlotData().SizeValue or 0, self:GetSlotData().SizeRule or SizeRule.Auto
end

-- Sets the horizontal alignment of the slot.
---@param self BaseWidget
---@param Alignment HAlign
function FlexBoxSlot.SetHAlign(self, Alignment)
    if not (self and self:IsChildOfParent(FlexBox)) then
        assert(false, "Widget is not a child of a FlexBox.")
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
        assert(false, "Widget is not a child of a FlexBox.")
        return HAlign.Fill
    end

    return self:GetSlotData().HorizontalAlignment or HAlign.Auto
end

-- Sets the vertical alignment of the slot.
---@param self BaseWidget
---@param Alignment VAlign
function FlexBoxSlot.SetVAlign(self, Alignment)
    if not (self and self:IsChildOfParent(FlexBox)) then
        assert(false, "Widget is not a child of a FlexBox.")
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
        assert(false, "Widget is not a child of a FlexBox.")
        return VAlign.Fill
    end

    return self:GetSlotData().VerticalAlignment or VAlign.Auto
end

-- Sets the alignments of the slot.
---@param self BaseWidget
---@param HorizontalAlignment HAlign
---@param VerticalAlignment VAlign
function FlexBoxSlot.SetAlign(self, HorizontalAlignment, VerticalAlignment)
    if not (self and self:IsChildOfParent(FlexBox)) then
        assert(false, "Widget is not a child of a FlexBox.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetAlign", self, HorizontalAlignment, VerticalAlignment)

    local tSlot = self:GetSlotData()
    tSlot.HorizontalAlignment = HorizontalAlignment
    tSlot.VerticalAlignment = VerticalAlignment
    self:SetValue("__Slot", tSlot)

    return FlexBoxSlot
end