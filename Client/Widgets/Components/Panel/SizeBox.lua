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
---@param fWidth number
function SizeBox:SetWidthOverride(fWidth)
    self:CallBlueprintEvent("SetWidthOverride", fWidth)
end

-- Sets the height override of the widget.
---@param fHeight number
function SizeBox:SetHeightOverride(fHeight)
    self:CallBlueprintEvent("SetHeightOverride", fHeight)
end

-- Sets the size override of the widget.
---@param tSize Vector2D
function SizeBox:SetSizeOverride(tSize)
    self:CallBlueprintEvent("SetSizeOverride", tSize)
end

-- When specified, will report the MinDesiredWidth if larger than the content's desired width.
---@param fMinWidth number
function SizeBox:SetMinDesiredWidth(fMinWidth)
    self:CallBlueprintEvent("SetMinDesiredWidth", fMinWidth)
end

-- When specified, will report the MinDesiredHeight if larger than the content's desired height.
---@param fMinHeight number
function SizeBox:SetMinDesiredHeight(fMinHeight)
    self:CallBlueprintEvent("SetMinDesiredHeight", fMinHeight)
end

-- When specified, will report the MinDesiredSize (width and height) if larger than the content's desired size.
---@param tMinSize Vector2D
function SizeBox:SetMinDesiredSize(tMinSize)
    self:CallBlueprintEvent("SetMinDesiredSize", tMinSize)
end

-- When specified, will report the MaxDesiredWidth if smaller than the content's desired width.
---@param fMaxWidth number
function SizeBox:SetMaxDesiredWidth(fMaxWidth)
    self:CallBlueprintEvent("SetMaxDesiredWidth", fMaxWidth)
end

-- When specified, will report the MaxDesiredHeight if smaller than the content's desired height.
---@param fMaxHeight number
function SizeBox:SetMaxDesiredHeight(fMaxHeight)
    self:CallBlueprintEvent("SetMaxDesiredHeight", fMaxHeight)
end

-- When specified, will report the MaxDesiredSize (width and height) if smaller than the content's desired size.
---@param tMaxSize Vector2D
function SizeBox:SetMaxDesiredSize(tMaxSize)
    self:CallBlueprintEvent("SetMaxDesiredSize", tMaxSize)
end

-- Sets the minimum aspect ratio allowed for this slot.
---@param fMinAspectRatio number
function SizeBox:SetMinAspectRatio(fMinAspectRatio)
    self:CallBlueprintEvent("SetMinAspectRatio", fMinAspectRatio)
end

-- Sets the maximum aspect ratio allowed for this slot.
---@param fMaxAspectRatio number
function SizeBox:SetMaxAspectRatio(fMaxAspectRatio)
    self:CallBlueprintEvent("SetMaxAspectRatio", fMaxAspectRatio)
end