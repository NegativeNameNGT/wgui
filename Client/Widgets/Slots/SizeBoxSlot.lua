---@class SizeBoxSlot
SizeBoxSlot = {}

-- Sets the horizontal alignment of the slot.
---@param self BaseWidget
---@param Alignment HAlign
function SizeBoxSlot.SetHAlign(self, Alignment)
    if not (self and self:IsChildOfParent(SizeBox)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetHAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.HorizontalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return SizeBoxSlot
end

-- Gets the horizontal alignment of the slot.
---@param self BaseWidget
---@return HAlign
function SizeBoxSlot.GetHAlign(self)
    if not (self and self:IsChildOfParent(SizeBox)) then
        return
    end

    return self:GetSlotData().HorizontalAlignment or HAlign.Fill
end

-- Sets the vertical alignment of the slot.
---@param self BaseWidget
---@param Alignment VAlign
function SizeBoxSlot.SetVAlign(self, Alignment)
    if not (self and self:IsChildOfParent(SizeBox)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetVAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.VerticalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return SizeBoxSlot
end

-- Gets the vertical alignment of the slot.
---@param self BaseWidget
---@return VAlign
function SizeBoxSlot.GetVAlign(self)
    if not (self and self:IsChildOfParent(SizeBox)) then
        return
    end

    return self:GetSlotData().VerticalAlignment or VAlign.Fill
end