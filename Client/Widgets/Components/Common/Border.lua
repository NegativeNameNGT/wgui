-- A border is a container widget that can contain one child widget, providing an opportunity to surround it with a background image.
---@class Border : PanelWidget
Border = PanelWidget.Inherit("Border", {
    -- The border can only have one child widget.
    ChildrenLimit = 1,

    Slot = BorderSlot,

    Icon = "package://wgui/Client/Textures/Icons/Border.png"
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

-- Scales the computed desired size of the border.
---@param tSizeScale Vector2D
function Border:SetDesiredSizeScale(tSizeScale)
    self:CallBlueprintEvent("SetDesiredSizeScale", tSizeScale)

    return self
end

-- Gets the computed desired size scale of the border.
---@return Vector2D
function Border:GetDesiredSizeScale()
    return self:CallBlueprintFunction("GetDesiredSizeScale", Vector2D(1, 1))
end