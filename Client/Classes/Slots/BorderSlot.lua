---@class BorderSlot
BorderSlot = {}

-- Sets the horizontal alignment of the slot.
---@param self BaseWidget
---@param Alignment HAlign
function BorderSlot.SetHAlign(self, Alignment)
    if not (self and self:IsChildOfParent(Border)) then
        assert(false, "Widget is not a child of a Border.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetHAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.HorizontalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return BorderSlot
end

-- Gets the horizontal alignment of the slot.
---@param self BaseWidget
---@return HAlign
function BorderSlot.GetHAlign(self)
    if not (self and self:IsChildOfParent(Border)) then
        assert(false, "Widget is not a child of a Border.")
        return HAlign.Fill
    end

    return self:GetSlotData().HorizontalAlignment or HAlign.Fill
end

-- Sets the vertical alignment of the slot.
---@param self BaseWidget
---@param Alignment VAlign
function BorderSlot.SetVAlign(self, Alignment)
    if not (self and self:IsChildOfParent(Border)) then
        assert(false, "Widget is not a child of a Border.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetVAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.VerticalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return BorderSlot
end

-- Gets the vertical alignment of the slot.
---@param self BaseWidget
---@return VAlign
function BorderSlot.GetVAlign(self)
    if not (self and self:IsChildOfParent(Border)) then
        assert(false, "Widget is not a child of a Border.")
        return VAlign.Fill
    end

    return self:GetSlotData().VerticalAlignment or VAlign.Fill
end