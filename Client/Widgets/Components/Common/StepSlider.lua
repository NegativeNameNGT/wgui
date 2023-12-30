---@class StepSlider : Slider
StepSlider = Slider.Inherit("StepSlider")

function StepSlider:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_SliderWithStep")
    return self
end

-- Sets the amount to adjust the value by when the slider is moved.
---@param fStep number
function StepSlider:SetStepSize(fStep)
    self:CallBlueprintEvent("SetStep", fStep)

    self:SetValue("__CachedStep", fStep)
end

-- Gets the amount to adjust the value by when the slider is moved.
---@return number
function StepSlider:GetStepSize()
    return self:GetValue("__CachedStep", 0)
end