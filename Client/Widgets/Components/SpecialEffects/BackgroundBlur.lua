-- A Background Blur is a container widget that can contain one child widget, providing an opportunity to apply a post-process Gaussian blur to all content beneath the widget.
---@class BackgroundBlur : PanelWidget
BackgroundBlur = PanelWidget.Inherit("BackgroundBlur", {
    -- The background blur can only have one child widget.
    ChildrenLimit = 1,
})

function BackgroundBlur:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_BackgroundBlur")

    return self
end

-- Sets how blurry the background is.
---@generic T
---@param self T
---@param BlurStrength number
---@return T
function BackgroundBlur:SetBlurStrength(BlurStrength)
    self:CallBlueprintEvent("SetBlurStrength", BlurStrength)

    return self
end

-- True to modulate the strength of the blur based on the widget alpha.
---@generic T
---@param self T
---@param bModulateAlpha boolean
---@return T
function BackgroundBlur:SetBlurStrengthFromAlpha(bModulateAlpha)
    self:CallBlueprintEvent("SetApplyAlphaToBlur", bModulateAlpha)

    return self
end

-- Sets the number of pixels which will be weighted in each direction from any given pixel when computing the blur. A larger value is more costly but allows for stronger blurs.
---@generic T
---@param self T
---@param BlurRadius integer
---@return T
function BackgroundBlur:SetBlurRadius(BlurRadius)
    self:CallBlueprintEvent("SetBlurRadius", BlurRadius)

    return self
end

-- Sets the corner radius of the background.
---@generic T
---@param self T
---@param CornerRadius Quat
---@return T
function BackgroundBlur:SetCornerRadius(CornerRadius)
    self:CallBlueprintEvent("SetCornerRadius", CornerRadius)

    return self
end
