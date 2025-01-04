-- The LinearGradientBox introduces a linear gradient effect to the children widget it is associated with.
---@class LinearGradientBox : PanelWidget
LinearGradientBox = PanelWidget.Inherit("LinearGradientBox", {
    -- The linear gradient box can only have one child widget.
    ChildrenLimit = 1,
})

function LinearGradientBox:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_LinearGradientBox")

    return self
end

-- Sets the start color of the linear gradient.
---@generic T
---@param self T
---@param oColor Color
---@return T
function LinearGradientBox:SetStartColor(oColor)
    self:CallBlueprintEvent("SetFromColor", oColor)

    return self
end

-- Sets the end color of the linear gradient.
---@generic T
---@param self T
---@param oColor Color
---@return T
function LinearGradientBox:SetEndColor(oColor)
    self:CallBlueprintEvent("SetToColor", oColor)

    return self
end

-- Sets the direction (0-1) of the linear gradient.
---@generic T
---@param self T
---@param fDirection number
---@return T
function LinearGradientBox:SetDirection(fDirection)
    self:CallBlueprintEvent("SetDirection", fDirection)

    return self
end

-- Sets the flag for if we retain the render or pass-trough.
---@generic T
---@param self T
---@param bRetainRender boolean
---@return T
function LinearGradientBox:SetRetainRender(bRetainRender)
    self:CallBlueprintEvent("SetRetainRender", bRetainRender)

    -- Stores the value
    self:SetValue("__RetainRender", bRetainRender)

    return self
end

-- Gets the flag for if we retain the render or pass-trough.
---@return boolean
function LinearGradientBox:GetRetainRender()
    return self:GetValue("__RetainRender", false)
end

---@generic T
---@param self T
---@param iRenderPhase integer
---@param iTotalCount integer
---@return T
function LinearGradientBox:SetRenderingPhase(iRenderPhase, iTotalCount)
    self:CallBlueprintEvent("SetRenderingPhase", iRenderPhase, iTotalCount)

    return self
end

-- Requests the retainer redrawn the contents it has.
---@generic T
---@param self T
---@return T
function LinearGradientBox:RequestRender()
    self:CallBlueprintEvent("RequestRender")

    return self
end