---@class CanvasPanelSlot
CanvasPanelSlot = {}

-- Sets the position of the slot.
---@param self BaseWidget
---@param tPos Vector2D
function CanvasPanelSlot.SetPos(self, tPos)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetPos", self, tPos)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.Pos = tPos
    self:SetValue("__Slot", tSlot)

    return CanvasPanelSlot
end

-- Gets the position of the slot.
---@param self BaseWidget
---@return Vector2D
function CanvasPanelSlot.GetPos(self)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return Vector2D()
    end

    return self:GetSlotData().Pos or Vector2D()
end

-- Sets the ZPosition of the slot.
---@param self BaseWidget
---@param iZPosition integer
function CanvasPanelSlot.SetZPosition(self, iZPosition)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetZPos", self, iZPosition)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.ZPosition = iZPosition
    self:SetValue("__Slot", tSlot)

    return CanvasPanelSlot
end

-- Gets the ZPosition of the slot.
---@param self BaseWidget
---@return integer
function CanvasPanelSlot.GetZPosition(self)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return -1
    end

    return self:GetSlotData().ZPosition or 0
end

-- Sets the size of the slot.
---@param self BaseWidget
---@param tSize Vector2D
function CanvasPanelSlot.SetSize(self, tSize)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetSize", self, tSize)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.Size = tSize
    self:SetValue("__Slot", tSlot)

    return CanvasPanelSlot
end

-- Gets the size of the slot.
---@param self BaseWidget
---@return Vector2D
function CanvasPanelSlot.GetSize(self)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return Vector2D()
    end

    return self:GetSlotData().Size or Vector2D(100, 40)
end

-- Sets the alignment of the slot.
---@param self BaseWidget
---@param tAlignment Vector2D
function CanvasPanelSlot.SetAlignment(self, tAlignment)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetAlignment", self, tAlignment)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.Alignment = tAlignment
    self:SetValue("__Slot", tSlot)

    return CanvasPanelSlot
end

-- Gets the alignment of the slot.
---@param self BaseWidget
---@return Vector2D
function CanvasPanelSlot.GetAlignment(self)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return Vector2D()
    end

    return self:GetSlotData().Alignment or Vector2D()
end

-- Sets the anchor of the slot.
---@param self BaseWidget
---@param tAnchor AnchorData
function CanvasPanelSlot.SetAnchor(self, tAnchor)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return
    end

    tAnchor = tAnchor or Anchor.TopLeft

    local tNewSize = CanvasPanelSlot.GetSize(self)

    if tAnchor.bResetOffsetRight then
        tNewSize = Vector2D(0, tNewSize.Y)
    end

    if tAnchor.bResetOffsetBottom then
        tNewSize = Vector2D(tNewSize.X, 0)
    end

    -- Pass parameters and call the blueprint function.
    self:GetParent():CallBlueprintEvent("_SetAnchor", self, tAnchor.Min, tAnchor.Max, tAnchor.Alignment, tNewSize)

    -- Sets the slot data.
    local tSlot = self:GetSlotData()
    tSlot.Anchor = tAnchor
    tSlot.Size = tNewSize
    tSlot.Alignment = tAnchor.Alignment
    self:SetValue("__Slot", tSlot)

    if tSlot.Pos then
        -- To do: add it in the SetAnchor function instead of recalling it here.
        CanvasPanelSlot.SetPos(self, tSlot.Pos)
    end

    return CanvasPanelSlot
end

-- Gets the anchor of the slot.
---@param self BaseWidget
---@return Anchor
function CanvasPanelSlot.GetAnchor(self)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return Anchor.Filled
    end

    return self:GetSlotData().Anchor or Anchor.TopLeft
end

-- Sizes the slot to fit the content.
---@param self BaseWidget
function CanvasPanelSlot.SizeToContent(self)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetAutoSize", self, true)

    return CanvasPanelSlot
end

-- Sizes the slot within its boundaries.
---@param self BaseWidget
function CanvasPanelSlot.SizeWithinBounds(self)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return
    end

    self:GetParent():CallBlueprintEvent("_SetAutoSize", self, false)

    return CanvasPanelSlot
end
