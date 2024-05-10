-- The progress bar widget is a simple bar that fills up that can be restyled to fit any number of uses.
---@class ProgressBar : BaseWidget
ProgressBar = BaseWidget.Inherit("ProgressBar")

function ProgressBar:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_ProgressBar")
    return self
end

-- Sets the style of the progress bar.
---@generic T
---@param self T
---@param oStyle ProgressBarStyle
---@return T
function ProgressBar:SetStyleSheet(oStyle)
    self:CallBlueprintEvent("SetStyleSheet", oStyle.Background or {}, oStyle.Fill or {}, oStyle.Marquee or {}, oStyle.EnableFillAnimation or false)

    ---@private
    self.__StyleSheet = oStyle

    return self
end

-- Gets the style of the progress bar.
---@return ProgressBarStyle
function ProgressBar:GetStyleSheet()
    if not self.__StyleSheet then
        self.__StyleSheet = ProgressBarStyle(
            Brush(DrawMode.Image, Color.FromHSV(0, 0, 0.0047), nil, Vector2D()),
            Brush(DrawMode.Image, nil, nil, Vector2D() )
        )
    end
    return self.__StyleSheet
end

-- Sets the percent fill of the progress bar.
---@generic T
---@param self T
---@param fPercent number
---@return T
function ProgressBar:SetPercent(fPercent)
    self:CallBlueprintEvent("SetPercent", fPercent)

    self:SetValue("__Percent", fPercent)

    return self
end

-- Gets the percent fill of the progress bar.
---@return number
function ProgressBar:GetPercent()
    return self:GetValue("__Percent", 0)
end

-- Sets whether or not the spin box uses the marquee feature.
---@generic T
---@param self T
---@param bIsMarquee boolean
---@return T
function ProgressBar:SetIsMarquee(bIsMarquee)
    self:CallBlueprintEvent("SetIsMarquee", bIsMarquee)

    self:SetValue("__IsMarquee", bIsMarquee)

    return self
end

-- Gets whether or not the spin box uses the marquee feature.
---@return boolean
function ProgressBar:GetIsMarquee()
    return self:GetValue("__IsMarquee", false)
end

-- Sets the fill color of the progress bar.
---@generic T
---@param self T
---@param oColor Color
---@return T
function ProgressBar:SetFillColor(oColor)
    self:CallBlueprintEvent("SetFillColor", oColor)

    self:SetValue("__FillColor", oColor)

    return self
end

-- Gets the fill color of the progress bar.
---@return Color
function ProgressBar:GetFillColor()
    return self:GetValue("__FillColor", Color.FromHSV(232.827, 1, 1))
end

-- Sets the visual style of the progress bar fill - scale or mask.
---@generic T
---@param self T
---@param iFillStyle BarFillStyle
---@return T
function ProgressBar:SetFillStyle(iFillStyle)
    self:CallBlueprintEvent("SetFillStyle", iFillStyle)

    self:SetValue("__FillStyle", iFillStyle)

    return self
end

-- Gets the visual style of the progress bar fill - scale or mask.
---@return BarFillStyle
function ProgressBar:GetFillStyle()
    return self:GetValue("__FillStyle", BarFillStyle.Mask)
end

-- Sets the direction in which the progress bar fills.
---@generic T
---@param self T
---@param iFillDirection BarFillDirection
---@return T
function ProgressBar:SetFillDirection(iFillDirection)
    self:CallBlueprintEvent("SetFillDirection", iFillDirection)

    self:SetValue("__FillDirection", iFillDirection)

    return self
end

-- Gets the direction in which the progress bar fills.
---@return BarFillDirection
function ProgressBar:GetFillDirection()
    return self:GetValue("__FillDirection", BarFillDirection.LeftToRight)
end

