---@class DiamondGradientBox : PanelWidget
DiamondGradientBox = PanelWidget.Inherit("DiamondGradientBox", {
    -- The diamond gradient box can only have one child widget.
    ChildrenLimit = 1,
})

function DiamondGradientBox:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_RadialGradientBox")

    return self
end

-- Sets the falloff of the radial gradient.
---@generic T
---@param self T
---@param fFalloff number
---@return T
function DiamondGradientBox:SetFalloff(fFalloff)
    self:CallBlueprintEvent("SetFalloff", fFalloff)

    return self
end

-- Sets the density of the radial gradient.
---@generic T
---@param self T
---@param fDensity number
---@return T
function DiamondGradientBox:SetDensity(fDensity)
    self:CallBlueprintEvent("SetDensity", fDensity)

    return self
end

-- Sets the inner color of the diamond gradient.
---@generic T
---@param self T
---@param oColor Color
---@return T
function DiamondGradientBox:SetInnerColor(oColor)
    self:CallBlueprintEvent("SetInnerColor", oColor)

    return self
end

-- Sets the center color of the diamond gradient.
---@generic T
---@param self T
---@param oColor Color
---@return T
function DiamondGradientBox:SetCenterColor(oColor)
    self:CallBlueprintEvent("SetCenterCircleColor", oColor)

    return self
end

-- Sets the flag for if we retain the render or pass-trough.
---@generic T
---@param self T
---@param bRetainRender boolean
---@return T
function DiamondGradientBox:SetRetainRender(bRetainRender)
    self:CallBlueprintEvent("SetRetainRender", bRetainRender)

    -- Stores the value
    self:SetValue("__RetainRender", bRetainRender)

    return self
end

-- Gets the flag for if we retain the render or pass-trough.
---@return boolean
function DiamondGradientBox:GetRetainRender()
    return self:GetValue("__RetainRender", false)
end

---@generic T
---@param self T
---@param iRenderPhase integer
---@param iTotalCount integer
---@return T
function DiamondGradientBox:SetRenderingPhase(iRenderPhase, iTotalCount)
    self:CallBlueprintEvent("SetRenderingPhase", iRenderPhase, iTotalCount)

    return self
end

-- Requests the retainer redrawn the contents it has.
---@generic T
---@param self T
---@return T
function DiamondGradientBox:RequestRender()
    self:CallBlueprintEvent("RequestRender")

    return self
end