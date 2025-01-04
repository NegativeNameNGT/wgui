---@class WidgetSwitcherSlot
WidgetSwitcherSlot = {}

-- Sets the horizontal alignment of the slot.
---@param self BaseWidget
---@param Alignment HAlign
function WidgetSwitcherSlot.SetHAlign(self, Alignment)
    if not (self and self:IsChildOfParent(WidgetSwitcher)) then
        assert(false, "Widget is not a child of a WidgetSwitcher.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetHAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.HorizontalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return WidgetSwitcherSlot
end

-- Gets the horizontal alignment of the slot.
---@param self BaseWidget
---@return HAlign
function WidgetSwitcherSlot.GetHAlign(self)
    if not (self and self:IsChildOfParent(WidgetSwitcher)) then
        assert(false, "Widget is not a child of a WidgetSwitcher.")
        return HAlign.Fill
    end

    return self:GetSlotData().HorizontalAlignment or HAlign.Fill
end

-- Sets the vertical alignment of the slot.
---@param self BaseWidget
---@param Alignment VAlign
function WidgetSwitcherSlot.SetVAlign(self, Alignment)
    if not (self and self:IsChildOfParent(WidgetSwitcher)) then
        assert(false, "Widget is not a child of a WidgetSwitcher.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetVAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.VerticalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return WidgetSwitcherSlot
end

-- Gets the vertical alignment of the slot.
---@param self BaseWidget
---@return VAlign
function WidgetSwitcherSlot.GetVAlign(self)
    if not (self and self:IsChildOfParent(WidgetSwitcher)) then
        assert(false, "Widget is not a child of a WidgetSwitcher.")
        return VAlign.Fill
    end

    return self:GetSlotData().VerticalAlignment or VAlign.Fill
end