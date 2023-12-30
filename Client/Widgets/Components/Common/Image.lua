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