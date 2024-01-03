-- The Retainer Box renders children widgets to a render target first before later rendering that render target to the screen.
---@class RetainerBox : PanelWidget
RetainerBox = PanelWidget.Inherit("RetainerBox", {
    -- The background blur can only have one child widget.
    ChildrenLimit = 1,
})

function RetainerBox:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_RetainerBox")

    return self
end

-- Sets the dynamic material instance to use for rendering.
---@param oMaterial MaterialInstance
function RetainerBox:SetMaterial(oMaterial)
    self:CallBlueprintEvent("SetEffectMaterial", oMaterial.__ID)

    -- Stores the value
    self.WeakData = self.WeakData or setmetatable({}, {__mode = "v"})
    self.WeakData.Material = oMaterial
end

-- Gets the dynamic material instance to use for rendering.
---@return MaterialInstance
function RetainerBox:GetMaterial()
    return self.WeakData and self.WeakData.Material
end

-- Sets the name of the texture parameter to set the render target to on the material.
---@param sTextureParameterName string
function RetainerBox:SetTextureParameter(sTextureParameterName)
    self:CallBlueprintEvent("SetTextureParameter", sTextureParameterName)

    -- Stores the value
    self:SetValue("__TextureParameterName", sTextureParameterName)
end

-- Gets the name of the texture parameter to set the render target to on the material.
---@return string
function RetainerBox:GetTextureParameter()
    return self:GetValue("__TextureParameterName", "")
end

-- Sets the flag for if we retain the render or pass-trough.
---@param bRetainRender boolean
function RetainerBox:SetRetainRender(bRetainRender)
    self:CallBlueprintEvent("SetRetainRender", bRetainRender)

    -- Stores the value
    self:SetValue("__RetainRender", bRetainRender)
end

-- Gets the flag for if we retain the render or pass-trough.
---@return boolean
function RetainerBox:GetRetainRender()
    return self:GetValue("__RetainRender", false)
end

---@param iRenderPhase integer
---@param iTotalCount integer
function RetainerBox:SetRenderingPhase(iRenderPhase, iTotalCount)
    self:CallBlueprintEvent("SetRenderingPhase", iRenderPhase, iTotalCount)
end

-- Requests the retainer redrawn the contents it has.
function RetainerBox:RequestRender()
    self:CallBlueprintEvent("RequestRender")
end