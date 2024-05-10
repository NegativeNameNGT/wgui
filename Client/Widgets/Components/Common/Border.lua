-- A border is a container widget that can contain one child widget, providing an opportunity to surround it with a background image.
---@class Border : PanelWidget
Border = PanelWidget.Inherit("Border", {
    -- The border can only have one child widget.
    ChildrenLimit = 1,

    Slot = BorderSlot
})

function Border:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_Border")

    return self
end

-- Sets the brush of the border.
---@generic T
---@param self T
---@param oBrush Brush
---@return T
function Border:SetBrush(oBrush)
    self:CallBlueprintEvent("SetBrush", oBrush or {})

    ---@private
    self.__Brush = oBrush

    return self
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