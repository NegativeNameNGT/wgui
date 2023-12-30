---@class Border : PanelWidget
Border = PanelWidget.Inherit("Border", {
    -- The button can only have one child widget.
    ChildrenLimit = 1,
})

function Border:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_Border")

    return self
end

-- Sets the brush of the border.
---@param oBrush Brush
function Border:SetBrush(oBrush)
    self:CallBlueprintEvent("SetBrush", oBrush)

    self.__Brush = oBrush
end

-- Gets the brush of the border.
---@return Brush
function Border:GetBrush()
    local oBrush = self.__Brush
    if not oBrush then
        oBrush = Brush(DrawMode.Image)
    end
    return oBrush
end