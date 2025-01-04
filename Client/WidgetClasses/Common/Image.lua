-- The image widget allows you to display a Brush, or texture or material in the UI.
---@class Image : BaseWidget
Image = BaseWidget.Inherit("Image", {
    Icon = "package://wgui/Client/Textures/Icons/Image.png"
})

function Image:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_Image")
    return self
end

-- Sets the brush to display.
---@generic T
---@param self T
---@param oBrush Brush
---@return T
function Image:SetBrush(oBrush)
    self:CallBlueprintEvent("SetBrush", oBrush)

    ---@private
    self.__Brush = oBrush

    return self
end

-- Gets the brush of the border.
---@return Brush
function Image:GetBrush()
    local oBrush = self.__Brush
    if not oBrush then
        oBrush = Brush(DrawMode.Image)
    end
    return oBrush
end

-- Sets the Brush to the specified Texture.
---@generic T
---@param self T
---@param sSrc string
---@param tSrcSize Vector2D | nil
---@return T
function Image:SetBrushFromSrc(sSrc, tSrcSize)
    local oCurrentBrush = self:GetBrush()
    oCurrentBrush.SetDrawMode(DrawMode.Image)
    oCurrentBrush.SetSrc(sSrc)
    oCurrentBrush.SetSrcSize(tSrcSize or oCurrentBrush.SrcSize)

    self:SetBrush(oCurrentBrush)

    return self
end

-- Sets the Brush to the specified Material.
---@generic T
---@param self T
---@param Material MaterialInstance | WebUI | Canvas | SceneCapture
---@param Size Vector2D | nil
---@return T
function Image:SetBrushFromMaterial(Material, Size)
    local oCurrentBrush = self:GetBrush()
    oCurrentBrush.SetDrawMode(DrawMode.Image)
    oCurrentBrush.SetSrcSize(Size or oCurrentBrush.Size)
    oCurrentBrush.SetMaterial(Material)

    self:SetBrush(oCurrentBrush)

    return self
end