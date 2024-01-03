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
---@param oColor Color
function LinearGradientBox:SetStartColor(oColor)
    self:CallBlueprintEvent("SetFromColor", oColor)
end

-- Sets the end color of the linear gradient.
---@param oColor Color
function LinearGradientBox:SetEndColor(oColor)
    self:CallBlueprintEvent("SetToColor", oColor)
end

-- Sets the direction (0-1) of the linear gradient.
---@param fDirection number
function LinearGradientBox:SetDirection(fDirection)
    self:CallBlueprintEvent("SetDirection", fDirection)
end

-- Sets the flag for if we retain the render or pass-trough.
---@param bRetainRender boolean
function LinearGradientBox:SetRetainRender(bRetainRender)
    self:CallBlueprintEvent("SetRetainRender", bRetainRender)

    -- Stores the value
    self:SetValue("__RetainRender", bRetainRender)
end

-- Gets the flag for if we retain the render or pass-trough.
---@return boolean
function LinearGradientBox:GetRetainRender()
    return self:GetValue("__RetainRender", false)
end

---@param iRenderPhase integer
---@param iTotalCount integer
function LinearGradientBox:SetRenderingPhase(iRenderPhase, iTotalCount)
    self:CallBlueprintEvent("SetRenderingPhase", iRenderPhase, iTotalCount)
end

-- Requests the retainer redrawn the contents it has.
function LinearGradientBox:RequestRender()
    self:CallBlueprintEvent("RequestRender")
end