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
---@param fFalloff number
function DiamondGradientBox:SetFalloff(fFalloff)
    self:CallBlueprintEvent("SetFalloff", fFalloff)
end

-- Sets the density of the radial gradient.
---@param fDensity number
function DiamondGradientBox:SetDensity(fDensity)
    self:CallBlueprintEvent("SetDensity", fDensity)
end

-- Sets the inner color of the diamond gradient.
---@param oColor Color
function DiamondGradientBox:SetInnerColor(oColor)
    self:CallBlueprintEvent("SetInnerColor", oColor)
end

-- Sets the center color of the diamond gradient.
---@param oColor Color
function DiamondGradientBox:SetCenterColor(oColor)
    self:CallBlueprintEvent("SetCenterCircleColor", oColor)
end

-- Sets the flag for if we retain the render or pass-trough.
---@param bRetainRender boolean
function DiamondGradientBox:SetRetainRender(bRetainRender)
    self:CallBlueprintEvent("SetRetainRender", bRetainRender)

    -- Stores the value
    self:SetValue("__RetainRender", bRetainRender)
end

-- Gets the flag for if we retain the render or pass-trough.
---@return boolean
function DiamondGradientBox:GetRetainRender()
    return self:GetValue("__RetainRender", false)
end

---@param iRenderPhase integer
---@param iTotalCount integer
function DiamondGradientBox:SetRenderingPhase(iRenderPhase, iTotalCount)
    self:CallBlueprintEvent("SetRenderingPhase", iRenderPhase, iTotalCount)
end

-- Requests the retainer redrawn the contents it has.
function DiamondGradientBox:RequestRender()
    self:CallBlueprintEvent("RequestRender")
end