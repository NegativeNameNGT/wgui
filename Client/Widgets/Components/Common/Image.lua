-- The image widget allows you to display a Brush, or texture or material in the UI.
---@class Image : BaseWidget
Image = BaseWidget.Inherit("Image")

function Image:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_Image")
    return self
end

-- Sets the brush to display.
---@param oBrush Brush
function Image:SetBrush(oBrush)
    self:CallBlueprintEvent("SetBrush", oBrush)

    self.__CachedBrush = oBrush
end

-- Gets the brush of the border.
---@return Brush
function Image:GetBrush()
    local oBrush = self.__CachedBrush
    if not oBrush then
        oBrush = Brush(DrawMode.Image)
    end
    return oBrush
end