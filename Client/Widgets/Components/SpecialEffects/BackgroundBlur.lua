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
---@param BlurStrength number
function BackgroundBlur:SetBlurStrength(BlurStrength)
    self:CallBlueprintEvent("SetBlurStrength", BlurStrength)
end

-- True to modulate the strength of the blur based on the widget alpha.
---@param bModulateAlpha boolean
function BackgroundBlur:SetBlurStrengthFromAlpha(bModulateAlpha)
    self:CallBlueprintEvent("SetApplyAlphaToBlur", bModulateAlpha)
end

-- Sets the number of pixels which will be weighted in each direction from any given pixel when computing the blur. A larger value is more costly but allows for stronger blurs.
---@param BlurRadius integer
function BackgroundBlur:SetBlurRadius(BlurRadius)
    self:CallBlueprintEvent("SetBlurRadius", BlurRadius)
end

-- Sets the corner radius of the background.
---@param CornerRadius Quat
function BackgroundBlur:SetCornerRadius(CornerRadius)
    self:CallBlueprintEvent("SetCornerRadius", CornerRadius)
end
