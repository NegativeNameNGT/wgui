---@class ProgressBar : BaseWidget
ProgressBar = BaseWidget.Inherit("ProgressBar")

function ProgressBar:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_ProgressBar")
    return self
end

-- Sets the style of the progress bar.
---@param oStyle ProgressBarStyle
function ProgressBar:SetStyleSheet(oStyle)
    self:CallBlueprintEvent("SetStyleSheet", oStyle.Background or {}, oStyle.Fill or {}, oStyle.Marquee or {}, oStyle.EnableFillAnimation or false)

    self.__StyleSheet = oStyle
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
---@param fPercent number
function ProgressBar:SetPercent(fPercent)
    self:CallBlueprintEvent("SetPercent", fPercent)
end

-- Sets whether or not the spin box uses the marquee feature.
---@param bIsMarquee boolean
function ProgressBar:SetIsMarquee(bIsMarquee)
    self:CallBlueprintEvent("SetIsMarquee", bIsMarquee)

    self:SetValue("__IsMarquee", bIsMarquee)
end

-- Gets whether or not the spin box uses the marquee feature.
---@return boolean
function ProgressBar:GetIsMarquee()
    return self:GetValue("__IsMarquee", false)
end
