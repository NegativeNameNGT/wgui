-- Sets the horizontal alignment of the slot.
---@generic T
---@param self T
---@param Alignment HAlign
---@return T
function BaseWidget:SetHAlign(Alignment) end

-- Gets the horizontal alignment of the slot.
---@return HAlign
function BaseWidget:GetHAlign() end

-- Sets the vertical alignment of the slot.
---@generic T
---@param self T
---@param Alignment VAlign
---@return T
function BaseWidget:SetVAlign(Alignment) end

-- Gets the vertical alignment of the slot.
---@return VAlign
function BaseWidget:GetVAlign() end

-- Sets the alignments of the slot.
---@generic T
---@param self T
---@param HorizontalAlignment HAlign
---@param VerticalAlignment VAlign
---@return T
function BaseWidget:SetAlign(HorizontalAlignment, VerticalAlignment) end

-- Sets the position of the slot.
---@generic T
---@param self T
---@param Position Vector2D
---@return T
function BaseWidget:SetPos(Position) end

-- Gets the position of the slot.
---@return Vector2D
function BaseWidget:GetPos() end

-- Sets the ZPosition of the slot.
---@generic T
---@param self T
---@param ZPosition integer
---@return T
function BaseWidget:SetZPosition(ZPosition) end

-- Gets the ZPosition of the slot.
---@return integer
function BaseWidget:GetZPosition() end

-- Sets the size of the slot.
---@generic T
---@param self T
---@param Size Vector2D
---@overload fun(SizeValue: number, SizeRule: SizeRule)
---@return T
function BaseWidget:SetSize(Size) end

-- Gets the size of the slot.
---@return Vector2D | number, SizeRule
function BaseWidget:GetSize() end

-- Sets the alignment of the slot.
---@generic T
---@param self T
---@param Alignment Vector2D
---@return T
function BaseWidget:SetAlignment(Alignment) end

-- Gets the alignment of the slot.
---@return Vector2D
function BaseWidget:GetAlignment() end

-- Sets the anchor of the slot.
---@generic T
---@param self T
---@param Anchor Anchor
---@return T
function BaseWidget:SetAnchor(Anchor) end

-- Gets the anchor of the slot.
---@return Anchor
function BaseWidget:GetAnchor() end

-- Sizes the slot to fit the content.
---@generic T
---@param self T
---@return T
function BaseWidget:SizeToContent() end

-- Sizes the slot within its bounds.
---@generic T
---@param self T
---@return T
function BaseWidget:SizeWithinBounds() end

-- Sets the column index of the slot, this determines what cell the slot is in the panel.
---@generic T
---@param self T
---@param ColumnIndex integer
---@return T
function BaseWidget:SetColumnIndex(ColumnIndex) end

-- Gets the column index of the slot.
---@return integer
function BaseWidget:GetColumnIndex() end

-- Sets the row index of the slot, this determines what cell the slot is in the panel.
---@generic T
---@param self T
---@param RowIndex integer
---@return T
function BaseWidget:SetRowIndex(RowIndex) end

-- Gets the row index of the slot.
---@return integer
function BaseWidget:GetRowIndex() end

-- Sets how many columns the slot spans.
---@generic T
---@param self T
---@param ColumnSpan integer
---@return T
function BaseWidget:SetColumnSpan(ColumnSpan) end

-- Sets how many rows the slot spans.
---@generic T
---@param self T
---@param RowSpan integer
---@return T
function BaseWidget:SetRowSpan(RowSpan) end

-- Sets positive values offset this cell to be hit-tested and drawn on top of others.
---@generic T
---@param self T
---@param Layer integer
---@return T
function BaseWidget:SetLayer(Layer) end

-- Sets the offset for this slot's content by some amount, positive values offset to lower right.
---@generic T
---@param self T
---@param Nudge Vector2D
---@return T
function BaseWidget:SetNudge(Nudge) end

-- Sets whether or not the slot should fill empty space.
---@generic T
---@param self T
---@param bFillEmptySpace boolean
---@return T
function BaseWidget:SetFillEmptySpace(bFillEmptySpace) end

---@generic T
---@param self T
---@param FillSpanWhenLessThan boolean
---@return T
function BaseWidget:SetFillSpanWhenLessThan(FillSpanWhenLessThan) end

---@generic T
---@param self T
---@param bNewLine boolean
---@return T
function BaseWidget:SetNewLine(bNewLine) end