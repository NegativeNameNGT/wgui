---@class UniformGridPanelSlot
UniformGridPanelSlot = {}

-- Sets the column index of the slot, this determines what cell the slot is in the panel.
---@param self BaseWidget
---@param iColumnIndex integer
function UniformGridPanelSlot.SetColumnIndex(self, iColumnIndex)
    if not (self and self:IsChildOfParent(UniformGridPanel)) then
        assert(false, "Widget is not a child of a UniformGridPanel.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetColumn", self, iColumnIndex)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.ColumnIndex = iColumnIndex
    self:SetValue("__Slot", tSlot)

    return UniformGridPanelSlot
end

-- Gets the column index of the slot.
---@param self BaseWidget
---@return integer
function UniformGridPanelSlot.GetColumnIndex(self)
    if not (self and self:IsChildOfParent(UniformGridPanel)) then
        assert(false, "Widget is not a child of a UniformGridPanel.")
        return -1
    end

    return self:GetSlotData().ColumnIndex or 0
end

-- Sets the row index of the slot, this determines what cell the slot is in the panel.
---@param self BaseWidget
---@param iRowIndex integer
function UniformGridPanelSlot.SetRowIndex(self, iRowIndex)
    if not (self and self:IsChildOfParent(UniformGridPanel)) then
        assert(false, "Widget is not a child of a UniformGridPanel.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetRow", self, iRowIndex)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.RowIndex = iRowIndex
    self:SetValue("__Slot", tSlot)

    return UniformGridPanelSlot
end

-- Gets the row index of the slot.
---@param self BaseWidget
---@return integer
function UniformGridPanelSlot.GetRowIndex(self)
    if not (self and self:IsChildOfParent(UniformGridPanel)) then
        assert(false, "Widget is not a child of a UniformGridPanel.")
        return -1
    end

    return self:GetSlotData().RowIndex or 0
end

-- Sets the horizontal alignment of the slot.
---@param self BaseWidget
---@param Alignment HAlign
function UniformGridPanelSlot.SetHAlign(self, Alignment)
    if not (self and self:IsChildOfParent(UniformGridPanel)) then
        assert(false, "Widget is not a child of a UniformGridPanel.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetHAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.HorizontalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return GridPanelSlot
end

-- Gets the horizontal alignment of the slot.
---@param self BaseWidget
---@return HAlign
function UniformGridPanelSlot.GetHAlign(self)
    if not (self and self:IsChildOfParent(UniformGridPanel)) then
        assert(false, "Widget is not a child of a UniformGridPanel.")
        return HAlign.Fill
    end

    return self:GetSlotData().HorizontalAlignment or HAlign.Fill
end

-- Sets the vertical alignment of the slot.
---@param self BaseWidget
---@param Alignment VAlign
function UniformGridPanelSlot.SetVAlign(self, Alignment)
    if not (self and self:IsChildOfParent(UniformGridPanel)) then
        assert(false, "Widget is not a child of a UniformGridPanel.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetVAlign", self, Alignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.VerticalAlignment = Alignment
    self:SetValue("__Slot", tSlot)

    return GridPanelSlot
end

-- Gets the vertical alignment of the slot.
---@param self BaseWidget
---@return VAlign
function UniformGridPanelSlot.GetVAlign(self)
    if not (self and self:IsChildOfParent(UniformGridPanel)) then
        assert(false, "Widget is not a child of a UniformGridPanel.")
        return VAlign.Fill
    end

    return self:GetSlotData().VerticalAlignment or VAlign.Fill
end