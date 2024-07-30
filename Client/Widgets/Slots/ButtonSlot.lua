---@class ButtonSlot
ButtonSlot = {}

-- Sets the horizontal alignment of the slot.
---@param self BaseWidget
---@param Alignment HAlign
function ButtonSlot.SetHAlign(self, Alignment)
    if not (self and self:IsChildOfParent(Button)) then
        assert(false, "Widget is not a child of a Button.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetHAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.HorizontalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return ButtonSlot
end

-- Gets the horizontal alignment of the slot.
---@param self BaseWidget
---@return HAlign
function ButtonSlot.GetHAlign(self)
    if not (self and self:IsChildOfParent(Button)) then
        assert(false, "Widget is not a child of a Button.")
        return HAlign.Center
    end

    return self:GetSlotData().HorizontalAlignment or HAlign.Center
end

-- Sets the vertical alignment of the slot.
---@param self BaseWidget
---@param Alignment VAlign
function ButtonSlot.SetVAlign(self, Alignment)
    if not (self and self:IsChildOfParent(Button)) then
        assert(false, "Widget is not a child of a Button.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetVAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.VerticalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return ButtonSlot
end

-- Gets the vertical alignment of the slot.
---@param self BaseWidget
---@return VAlign
function ButtonSlot.GetVAlign(self)
    if not (self and self:IsChildOfParent(Button)) then
        assert(false, "Widget is not a child of a Button.")
        return VAlign.Center
    end

    return self:GetSlotData().VerticalAlignment or VAlign.Center
end