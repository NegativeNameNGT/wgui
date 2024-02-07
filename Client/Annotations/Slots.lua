-- Sets the horizontal alignment of the slot.
---@param Alignment HAlign
function BaseWidget:SetHAlign(Alignment) end

-- Gets the horizontal alignment of the slot.
---@return HAlign
function BaseWidget:GetHAlign() end

-- Sets the vertical alignment of the slot.
---@param Alignment VAlign
function BaseWidget:SetVAlign(Alignment) end

-- Gets the vertical alignment of the slot.
---@return VAlign
function BaseWidget:GetVAlign() end

-- Sets the alignments of the slot.
---@param HorizontalAlignment HAlign
---@param VerticalAlignment VAlign
function BaseWidget:SetAlign(HorizontalAlignment, VerticalAlignment) end

-- Sets the position of the slot.
---@param Position Vector2D
function BaseWidget:SetPos(Position) end

-- Gets the position of the slot.
---@return Vector2D
function BaseWidget:GetPos() end

-- Sets the ZPosition of the slot.
---@param ZPosition integer
function BaseWidget:SetZPosition(ZPosition) end

-- Gets the ZPosition of the slot.
---@return integer
function BaseWidget:GetZPosition() end

-- Sets the size of the slot.
---@param Size Vector2D
---@overload fun(SizeValue: number, SizeRule: SizeRule)
function BaseWidget:SetSize(Size) end

-- Gets the size of the slot.
---@return Vector2D | number, SizeRule
function BaseWidget:GetSize() end

-- Sets the alignment of the slot.
---@param Alignment Vector2D
function BaseWidget:SetAlignment(Alignment) end

-- Gets the alignment of the slot.
---@return Vector2D
function BaseWidget:GetAlignment() end

-- Sets the anchor of the slot.
---@param Anchor Anchor
function BaseWidget:SetAnchor(Anchor) end

-- Gets the anchor of the slot.
---@return Anchor
function BaseWidget:GetAnchor() end

-- Sizes the slot to fit the content.
function BaseWidget:SizeToContent() end

-- Sizes the slot within its bounds.
function BaseWidget:SizeWithinBounds() end

-- Sets the column index of the slot, this determines what cell the slot is in the panel.
---@param ColumnIndex integer
function BaseWidget:SetColumnIndex(ColumnIndex) end

-- Gets the column index of the slot.
---@return integer
function BaseWidget:GetColumnIndex() end

-- Sets the row index of the slot, this determines what cell the slot is in the panel.
---@param RowIndex integer
function BaseWidget:SetRowIndex(RowIndex) end

-- Gets the row index of the slot.
---@return integer
function BaseWidget:GetRowIndex() end

-- Sets how many columns the slot spans.
---@param ColumnSpan integer
function BaseWidget:SetColumnSpan(ColumnSpan) end

-- Sets how many rows the slot spans.
---@param RowSpan integer
function BaseWidget:SetRowSpan(RowSpan) end

-- Sets positive values offset this cell to be hit-tested and drawn on top of others.
---@param Layer integer
function BaseWidget:SetLayer(Layer) end

-- Sets the offset for this slot's content by some amount, positive values offset to lower right.
---@param Nudge Vector2D
function BaseWidget:SetNudge(Nudge) end

-- Sets whether or not the slot should fill empty space.
---@param bFillEmptySpace boolean
function BaseWidget:SetFillEmptySpace(bFillEmptySpace) end

---@param FillSpanWhenLessThan boolean
function BaseWidget:SetFillSpanWhenLessThan(FillSpanWhenLessThan) end

---@param bNewLine boolean
function BaseWidget:SetNewLine(bNewLine) end