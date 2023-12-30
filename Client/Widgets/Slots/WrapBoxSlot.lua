---@class WrapBoxSlot
WrapBoxSlot = {}


-- Sets the horizontal alignment of the slot.
---@param self BaseWidget
---@param Alignment HAlign
function WrapBoxSlot.SetHAlign(self, Alignment)
    if not (self and self:IsChildOfParent(WrapBox)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetHAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.HorizontalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return WrapBoxSlot
end

-- Gets the horizontal alignment of the slot.
---@param self BaseWidget
---@return HAlign
function WrapBoxSlot.GetHAlign(self)
    if not (self and self:IsChildOfParent(WrapBox)) then
        return
    end

    return self:GetSlotData().HorizontalAlignment or HAlign.Fill
end

-- Sets the vertical alignment of the slot.
---@param self BaseWidget
---@param Alignment VAlign
function WrapBoxSlot.SetVAlign(self, Alignment)
    if not (self and self:IsChildOfParent(WrapBox)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetVAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.VerticalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return WrapBoxSlot
end

-- Gets the vertical alignment of the slot.
---@param self BaseWidget
---@return VAlign
function WrapBoxSlot.GetVAlign(self)
    if not (self and self:IsChildOfParent(WrapBox)) then
        return
    end

    return self:GetSlotData().VerticalAlignment or VAlign.Fill
end

-- Sets whether or not the slot should fill empty space.
---@param self BaseWidget
---@param bFillEmptySpace boolean
function WrapBoxSlot.SetFillEmptySpace(self, bFillEmptySpace)
    if not (self and self:IsChildOfParent(WrapBox)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetFillEmptySpace", self, bFillEmptySpace)

    return WrapBoxSlot
end

---@param self BaseWidget
---@param FillSpanWhenLessThan boolean
function WrapBoxSlot.SetFillSpanWhenLessThan(self, FillSpanWhenLessThan)
    if not (self and self:IsChildOfParent(WrapBox)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetFillSpanWhenLessThan", self, FillSpanWhenLessThan)

    return WrapBoxSlot
end

---@param self BaseWidget
---@param bNewLine boolean
function WrapBoxSlot.SetNewLine(self, bNewLine)
    if not (self and self:IsChildOfParent(WrapBox)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetNewLine", self, bNewLine)

    return WrapBoxSlot
end