-- A widget that allows you to specify the size it reports to have and desire.
---@class SizeBox : PanelWidget
SizeBox = PanelWidget.Inherit("SizeBox", {
    -- The size box can only have one child widget.
    ChildrenLimit = 1,

    Slot = SizeBoxSlot
})

---@param tMinDesiredSize Vector2D | nil
---@param tMaxDesiredSize Vector2D | nil
function SizeBox:Constructor(tMinDesiredSize, tMaxDesiredSize)
    self.Super:Constructor("wgui-assets::WBP_WGUI_SizeBox")

    if tMinDesiredSize then
        self:SetMinDesiredSize(tMinDesiredSize)
    end

    if tMaxDesiredSize then
        self:SetMaxDesiredSize(tMaxDesiredSize)
    end
    return self
end

-- Sets the width override of the widget.
---@generic T
---@param self T
---@param fWidth number
---@return T
function SizeBox:SetWidthOverride(fWidth)
    self:CallBlueprintEvent("SetWidthOverride", fWidth)

    return self
end

-- Sets the height override of the widget.
---@generic T
---@param self T
---@param fHeight number
---@return T
function SizeBox:SetHeightOverride(fHeight)
    self:CallBlueprintEvent("SetHeightOverride", fHeight)

    return self
end

-- Sets the size override of the widget.
---@generic T
---@param self T
---@param tSize Vector2D
---@return T
function SizeBox:SetSizeOverride(tSize)
    self:CallBlueprintEvent("SetSizeOverride", tSize)

    return self
end

-- When specified, will report the MinDesiredWidth if larger than the content's desired width.
---@generic T
---@param self T
---@param fMinWidth number
---@return T
function SizeBox:SetMinDesiredWidth(fMinWidth)
    self:CallBlueprintEvent("SetMinDesiredWidth", fMinWidth)

    return self
end

-- When specified, will report the MinDesiredHeight if larger than the content's desired height.
---@generic T
---@param self T
---@param fMinHeight number
---@return T
function SizeBox:SetMinDesiredHeight(fMinHeight)
    self:CallBlueprintEvent("SetMinDesiredHeight", fMinHeight)

    return self
end

-- When specified, will report the MinDesiredSize (width and height) if larger than the content's desired size.
---@generic T
---@param self T
---@param tMinSize Vector2D
---@return T
function SizeBox:SetMinDesiredSize(tMinSize)
    self:CallBlueprintEvent("SetMinDesiredSize", tMinSize)

    return self
end

-- When specified, will report the MaxDesiredWidth if smaller than the content's desired width.
---@generic T
---@param self T
---@param fMaxWidth number
---@return T
function SizeBox:SetMaxDesiredWidth(fMaxWidth)
    self:CallBlueprintEvent("SetMaxDesiredWidth", fMaxWidth)

    return self
end

-- When specified, will report the MaxDesiredHeight if smaller than the content's desired height.
---@generic T
---@param self T
---@param fMaxHeight number
---@return T
function SizeBox:SetMaxDesiredHeight(fMaxHeight)
    self:CallBlueprintEvent("SetMaxDesiredHeight", fMaxHeight)

    return self
end

-- When specified, will report the MaxDesiredSize (width and height) if smaller than the content's desired size.
---@generic T
---@param self T
---@param tMaxSize Vector2D
---@return T
function SizeBox:SetMaxDesiredSize(tMaxSize)
    self:CallBlueprintEvent("SetMaxDesiredSize", tMaxSize)

    return self
end

-- Sets the minimum aspect ratio allowed for this slot.
---@generic T
---@param self T
---@param fMinAspectRatio number
---@return T
function SizeBox:SetMinAspectRatio(fMinAspectRatio)
    self:CallBlueprintEvent("SetMinAspectRatio", fMinAspectRatio)

    return self
end

-- Sets the maximum aspect ratio allowed for this slot.
---@generic T
---@param self T
---@param fMaxAspectRatio number
---@return T
function SizeBox:SetMaxAspectRatio(fMaxAspectRatio)
    self:CallBlueprintEvent("SetMaxAspectRatio", fMaxAspectRatio)

    return self
end