---@class RadialGradientBox : PanelWidget
RadialGradientBox = PanelWidget.Inherit("RadialGradientBox", {
    -- The radial gradient box can only have one child widget.
    ChildrenLimit = 1,
})

function RadialGradientBox:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_RadialGradientBox")

    return self
end

-- Sets the center position of the radial gradient.
---@param tCenter Vector2D
function RadialGradientBox:SetCenterPosition(tCenter)
    self:CallBlueprintEvent("SetCenterPosition", tCenter)
end

-- Sets the radius of the radial gradient.
---@param fRadius number
function RadialGradientBox:SetRadius(fRadius)
    self:CallBlueprintEvent("SetRadius", fRadius)
end

-- Sets the density of the radial gradient.
---@param fDensity number
function RadialGradientBox:SetDensity(fDensity)
    self:CallBlueprintEvent("SetDensity", fDensity)
end

-- Sets the inner color of the radial gradient.
---@param oColor Color
function RadialGradientBox:SetInnerColor(oColor)
    self:CallBlueprintEvent("SetInnerColor", oColor)
end

-- Sets the center color of the radial gradient.
---@param oColor Color
function RadialGradientBox:SetCenterColor(oColor)
    self:CallBlueprintEvent("SetCenterCircleColor", oColor)
end

-- Sets the flag for if we retain the render or pass-trough.
---@param bRetainRender boolean
function RadialGradientBox:SetRetainRender(bRetainRender)
    self:CallBlueprintEvent("SetRetainRender", bRetainRender)

    -- Stores the value
    self:SetValue("__RetainRender", bRetainRender)
end

-- Gets the flag for if we retain the render or pass-trough.
---@return boolean
function RadialGradientBox:GetRetainRender()
    return self:GetValue("__RetainRender", false)
end

---@param iRenderPhase integer
---@param iTotalCount integer
function RadialGradientBox:SetRenderingPhase(iRenderPhase, iTotalCount)
    self:CallBlueprintEvent("SetRenderingPhase", iRenderPhase, iTotalCount)
end

-- Requests the retainer redrawn the contents it has.
function RadialGradientBox:RequestRender()
    self:CallBlueprintEvent("RequestRender")
end