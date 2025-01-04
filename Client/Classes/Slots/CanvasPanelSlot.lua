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

local tAnchorData = {
    [Anchor.TopLeft] = { Vector2D(0, 0), Vector2D(0, 0), Vector2D(0, 0) },
    [Anchor.TopCenter] = { Vector2D(0.5, 0), Vector2D(0.5, 0), Vector2D(0.5, 0) },
    [Anchor.TopRight] = { Vector2D(1, 0), Vector2D(1, 0), Vector2D(1, 0) },
    [Anchor.CenterLeft] = { Vector2D(0, 0.5), Vector2D(0, 0.5), Vector2D(0, 0.5) },
    [Anchor.Center] = { Vector2D(0.5, 0.5), Vector2D(0.5, 0.5), Vector2D(0.5, 0.5) },
    [Anchor.CenterRight] = { Vector2D(1, 0.5), Vector2D(1, 0.5), Vector2D(1, 0.5) },
    [Anchor.BottomLeft] = { Vector2D(0, 1), Vector2D(0, 1), Vector2D(0, 1) },
    [Anchor.BottomCenter] = { Vector2D(0.5, 1), Vector2D(0.5, 1), Vector2D(0.5, 1) },
    [Anchor.BottomRight] = { Vector2D(1, 1), Vector2D(1, 1), Vector2D(1, 1) },
    [Anchor.StretchTop] = { Vector2D(0, 0), Vector2D(1, 0), Vector2D(0.5, 0), true, false },
    [Anchor.StretchHorizontalCenter] = { Vector2D(0, 0.5), Vector2D(1, 0.5), Vector2D(0.5, 0.5), true, false },
    [Anchor.StretchVerticalCenter] = { Vector2D(0.5, 0), Vector2D(0.5, 1), Vector2D(0.5, 0.5), false, true },
    [Anchor.StretchBottom] = { Vector2D(0, 1), Vector2D(1, 1), Vector2D(0.5, 1), true, false },
    [Anchor.StretchRight] = { Vector2D(1, 0), Vector2D(1, 1), Vector2D(1, 0.5), false, true },
    [Anchor.StretchLeft] = { Vector2D(0, 0), Vector2D(0, 1), Vector2D(0, 0.5), false, true },
    [Anchor.Filled] = { Vector2D(0, 0), Vector2D(1, 1), Vector2D(0.5, 0.5), true, true }
}

-- Sets the anchor of the slot.
---@param self BaseWidget
---@param nAnchor Anchor
function CanvasPanelSlot.SetAnchor(self, nAnchor)
    if not (self and self:IsChildOfParent(CanvasPanel)) then
        assert(false, "Widget is not a child of a CanvasPanel.")
        return
    end

    local tAnchor = tAnchorData[nAnchor]

    local tAnchorMin = tAnchor[1]
    local tAnchorMax = tAnchor[2]
    local tAlignment = tAnchor[3]
    local bResetOffsetX = tAnchor[4]
    local bResetOffsetY = tAnchor[5]

    local tSize = self:GetSize()

    if bResetOffsetX then
        tSize.X = 0
    end

    if bResetOffsetY then
        tSize.Y = 0
    end

    self:SetCanvasLayout(Vector2D(), tSize, tAnchorMin, tAnchorMax, tAlignment)

    local tSlotData = self:GetSlotData()
    tSlotData.Anchor = nAnchor
    tSlotData.Size = tSize
    tSlotData.Alignment = tAlignment
    self:SetValue("__Slot", tSlotData)

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
