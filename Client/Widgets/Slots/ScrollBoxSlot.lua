---@class ScrollBoxSlot
ScrollBoxSlot = {}

-- Sets the horizontal alignment of the slot.
---@param self BaseWidget
---@param Alignment HAlign
function ScrollBoxSlot.SetHAlign(self, Alignment)
    if not (self and self:IsChildOfParent(ScrollBox)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetHAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.HorizontalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return ScrollBoxSlot
end

-- Gets the horizontal alignment of the slot.
---@param self BaseWidget
---@return HAlign
function ScrollBoxSlot.GetHAlign(self)
    if not (self and self:IsChildOfParent(ScrollBox)) then
        return
    end

    return self:GetSlotData().HorizontalAlignment or HAlign.Fill
end

-- Sets the vertical alignment of the slot.
---@param self BaseWidget
---@param Alignment VAlign
function ScrollBoxSlot.SetVAlign(self, Alignment)
    if not (self and self:IsChildOfParent(ScrollBox)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetVAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.VerticalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return ScrollBoxSlot
end

-- Gets the vertical alignment of the slot.
---@param self BaseWidget
---@return VAlign
function ScrollBoxSlot.GetVAlign(self)
    if not (self and self:IsChildOfParent(ScrollBox)) then
        return
    end

    return self:GetSlotData().VerticalAlignment or VAlign.Fill
end