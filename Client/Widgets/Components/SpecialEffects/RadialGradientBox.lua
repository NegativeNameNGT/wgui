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
---@generic T
---@param self T
---@param tCenter Vector2D
---@return T
function RadialGradientBox:SetCenterPosition(tCenter)
    self:CallBlueprintEvent("SetCenterPosition", tCenter)

    return self
end

-- Sets the radius of the radial gradient.
---@generic T
---@param self T
---@param fRadius number
---@return T
function RadialGradientBox:SetRadius(fRadius)
    self:CallBlueprintEvent("SetRadius", fRadius)

    return self
end

-- Sets the density of the radial gradient.
---@generic T
---@param self T
---@param fDensity number
---@return T
function RadialGradientBox:SetDensity(fDensity)
    self:CallBlueprintEvent("SetDensity", fDensity)

    return self
end

-- Sets the inner color of the radial gradient.
---@generic T
---@param self T
---@param oColor Color
---@return T
function RadialGradientBox:SetInnerColor(oColor)
    self:CallBlueprintEvent("SetInnerColor", oColor)

    return self
end

-- Sets the center color of the radial gradient.
---@generic T
---@param self T
---@param oColor Color
---@return T
function RadialGradientBox:SetCenterColor(oColor)
    self:CallBlueprintEvent("SetCenterCircleColor", oColor)

    return self
end

-- Sets the flag for if we retain the render or pass-through.
---@generic T
---@param self T
---@param bRetainRender boolean
---@return T
function RadialGradientBox:SetRetainRender(bRetainRender)
    self:CallBlueprintEvent("SetRetainRender", bRetainRender)

    -- Stores the value
    self:SetValue("__RetainRender", bRetainRender)

    return self
end

-- Gets the flag for if we retain the render or pass-trough.
---@return boolean
function RadialGradientBox:GetRetainRender()
    return self:GetValue("__RetainRender", false)
end

---@generic T
---@param self T
---@param iRenderPhase integer
---@param iTotalCount integer
---@return T
function RadialGradientBox:SetRenderingPhase(iRenderPhase, iTotalCount)
    self:CallBlueprintEvent("SetRenderingPhase", iRenderPhase, iTotalCount)

    return self
end

-- Requests the retainer redrawn the contents it has.
---@generic T
---@param self T
---@return T
function RadialGradientBox:RequestRender()
    self:CallBlueprintEvent("RequestRender")

    return self
end