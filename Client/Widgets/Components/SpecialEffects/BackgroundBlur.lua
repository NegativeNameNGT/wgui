---@class BackgroundBlur : PanelWidget
BackgroundBlur = PanelWidget.Inherit("BackgroundBlur", {
    -- The background blur can only have one child widget.
    ChildrenLimit = 1,
})

function BackgroundBlur:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_BackgroundBlur")

    return self
end

-- Sets the content horizontal alignment.
---@param Alignment HAlign
function BackgroundBlur:SetHAlign(Alignment)
    self:CallBlueprintEvent("SetContentHAlign", Alignment)

    -- Stores the alignment.
    self:SetValue("__HAlign", Alignment)
end

-- Sets the content vertical alignment.
---@param Alignment VAlign
function BackgroundBlur:SetVAlign(Alignment)
    self:CallBlueprintEvent("SetContentVAlign", Alignment)

    -- Stores the alignment.
    self:SetValue("__VAlign", Alignment)
end

-- Gets the content horizontal alignment.
---@return HAlign
function BackgroundBlur:GetHAlign()
    return self:GetValue("__HAlign", HAlign.Fill)
end

-- Gets the content vertical alignment.
---@return VAlign
function BackgroundBlur:GetVAlign()
    return self:GetValue("__VAlign", VAlign.Fill)
end

-- True to modulate the strength of the blur based on the widget alpha.
---@param bModulateAlpha boolean
function BackgroundBlur:SetBlurStrengthFromAlpha(bModulateAlpha)
    self:CallBlueprintEvent("SetApplyAlphaToBlur", bModulateAlpha)
end

-- Sets how blurry the background is.
---@param BlurStrength number
function BackgroundBlur:SetBlurStrength(BlurStrength)
    self:CallBlueprintEvent("SetBlurStrength", BlurStrength)
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
