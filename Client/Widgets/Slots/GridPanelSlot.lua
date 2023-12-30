---@class GridPanelSlot
GridPanelSlot = {}

-- Sets the column index of the slot, this determines what cell the slot is in the panel.
---@param self BaseWidget
---@param iColumnIndex integer
function GridPanelSlot.SetColumnIndex(self, iColumnIndex)
    if not (self and self:IsChildOfParent(GridPanel)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetColumn", self, iColumnIndex)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.ColumnIndex = iColumnIndex
    self:SetValue("__Slot", tSlot)

    return GridPanelSlot
end

-- Gets the column index of the slot.
---@param self BaseWidget
---@return integer
function GridPanelSlot.GetColumnIndex(self)
    if not (self and self:IsChildOfParent(GridPanel)) then
        return -1
    end

    return self:GetSlotData().ColumnIndex or 0
end

-- Sets the row index of the slot, this determines what cell the slot is in the panel.
---@param self BaseWidget
---@param iRowIndex integer
function GridPanelSlot.SetRowIndex(self, iRowIndex)
    if not (self and self:IsChildOfParent(GridPanel)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetRow", self, iRowIndex)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.RowIndex = iRowIndex
    self:SetValue("__Slot", tSlot)

    return GridPanelSlot
end

-- Gets the row index of the slot.
---@param self BaseWidget
---@return integer
function GridPanelSlot.GetRowIndex(self)
    if not (self and self:IsChildOfParent(GridPanel)) then
        return -1
    end

    return self:GetSlotData().RowIndex or 0
end

-- Sets how many columns the slot spans.
---@param self BaseWidget
---@param iColumnSpan integer
function GridPanelSlot.SetColumnSpan(self, iColumnSpan)
    if not (self and self:IsChildOfParent(GridPanel)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetColumnSpan", self, iColumnSpan)

    return GridPanelSlot
end

-- Sets how many rows the slot spans.
---@param self BaseWidget
---@param iRowSpan integer
function GridPanelSlot.SetRowSpan(self, iRowSpan)
    if not (self and self:IsChildOfParent(GridPanel)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetRowSpan", self, iRowSpan)

    return GridPanelSlot
end

-- Sets the horizontal alignment of the slot.
---@param self BaseWidget
---@param Alignment HAlign
function GridPanelSlot.SetHAlign(self, Alignment)
    if not (self and self:IsChildOfParent(GridPanel)) then
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
function GridPanelSlot.GetHAlign(self)
    if not (self and self:IsChildOfParent(GridPanel)) then
        return
    end

    return self:GetSlotData().HorizontalAlignment or HAlign.Fill
end

-- Sets the vertical alignment of the slot.
---@param self BaseWidget
---@param Alignment VAlign
function GridPanelSlot.SetVAlign(self, Alignment)
    if not (self and self:IsChildOfParent(GridPanel)) then
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
function GridPanelSlot.GetVAlign(self)
    if not (self and self:IsChildOfParent(GridPanel)) then
        return
    end

    return self:GetSlotData().VerticalAlignment or VAlign.Fill
end

-- Sets positive values offset this cell to be hit-tested and drawn on top of others.
---@param self BaseWidget
---@param iLayer integer
function GridPanelSlot.SetLayer(self, iLayer)
    if not (self and self:IsChildOfParent(GridPanel)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetLayer", self, iLayer)

    return GridPanelSlot
end

-- Sets the offset for this slot's content by some amount, positive values offset to lower right.
---@param self BaseWidget
---@param Nudge Vector2D
function GridPanelSlot.SetNudge(self, Nudge)
    if not (self and self:IsChildOfParent(GridPanel)) then
        return
    end

    self:GetParent():CallBlueprintEvent("_SetNudge", self, Nudge)

    return GridPanelSlot
end