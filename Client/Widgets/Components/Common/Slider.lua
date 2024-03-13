-- A simple widget that shows a sliding bar with a handle that allows you to control the value between 0-1.
---@class Slider : BaseWidget
Slider = BaseWidget.Inherit("Slider")

function Slider:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_Slider")
    return self
end

-- Sets the style of the slider.
---@generic T
---@param self T
---@param oStyle SliderStyle
---@return T
function Slider:SetStyleSheet(oStyle)
    self:CallBlueprintEvent("SetStyleSheet",
        oStyle.Normal or {},
        oStyle.Hovered or {},
        oStyle.Thumb or {},
        oStyle.HoveredThumb or {},
        oStyle.BarThickness or 4
    )

    self.__StyleSheet = oStyle
end

-- Gets the style of the slider.
---@return SliderStyle
function Slider:GetStyleSheet()
    if not self.__StyleSheet then
        self.__StyleSheet = SliderStyle(
            Brush(DrawMode.RoundedBox, nil, nil, nil, OutlineSettings(
                Quat(2), Color.BLACK, 1, RoundingType.HalfHeightRadius
            )),

            Brush(DrawMode.RoundedBox, nil, nil, nil, OutlineSettings(
                Quat(2), Color.BLACK, 1, RoundingType.HalfHeightRadius
            )),

            Brush(DrawMode.RoundedBox, Color.FromHSV(0, 0, 0.527), nil, Vector2D(8), OutlineSettings(
                Quat(0, 0, 0, 1), Color.TRANSPARENT, 0, RoundingType.HalfHeightRadius
            ))
        )
    end
    return self.__StyleSheet
end

-- Sets the value of the slider.
---@generic T
---@param self T
---@param fValue number
---@return T
function Slider:SetSliderValue(fValue)
    self:CallBlueprintEvent("SetValue", fValue)

    self:SetValue("__CachedValue", fValue)
end

-- Gets the value of the slider.
---@return number
function Slider:GetSliderValue()
    return self:GetValue("__CachedValue", 0)
end

-- Sets the minimum value of the slider.
---@generic T
---@param self T
---@param fValue number
---@return T
function Slider:SetMinValue(fValue)
    self:CallBlueprintEvent("SetMinValue", fValue)

    self:SetValue("__MinValue", fValue)

    return self
end

-- Gets the minimum value of the slider.
---@return number
function Slider:GetMinValue()
    return self:GetValue("__MinValue", 0)
end

-- Sets the maximum value of the slider.
---@generic T
---@param self T
---@param fValue number
---@return T
function Slider:SetMaxValue(fValue)
    self:CallBlueprintEvent("SetMaxValue", fValue)

    self:SetValue("__MaxValue", fValue)

    return self
end

-- Gets the maximum value of the slider.
---@return number
function Slider:GetMaxValue()
    return self:GetValue("__MaxValue", 0)
end

-- Sets the orientation of the slider.
---@generic T
---@param self T
---@param iOrientation Orientation
---@return T
function Slider:SetOrientation(iOrientation)
    self:CallBlueprintEvent("SetOrientation", iOrientation)

    self:SetValue("__Orientation", iOrientation)

    return self
end

-- Gets the orientation of the slider.
---@return Orientation
function Slider:GetOrientation()
    return self:GetValue("__Orientation", 0)
end

-- Sets if the slidable area should be indented to fit the handle.
---@generic T
---@param self T
---@param bIndentHandle boolean
---@return T
function Slider:SetIndentHandle(bIndentHandle)
    self:CallBlueprintEvent("SetIndentHandle", bIndentHandle)

    return self
end

-- Sets the handle to be interactive or fixed.
---@generic T
---@param self T
---@param bLocked boolean
---@return T
function Slider:SetIsLocked(bLocked)
    self:CallBlueprintEvent("SetIsLocked", bLocked)

    self:SetValue("__Locked", bLocked)

    return self
end

-- Gets if the handle is interactive or fixed.
---@return boolean
function Slider:GetIsLocked()
    return self:GetValue("__Locked", false)
end

-- Sets the color of the slider bar.
---@generic T
---@param self T
---@param oColor Color
---@return T
function Slider:SetBarColor(oColor)
    self:CallBlueprintEvent("SetBarColor", oColor)

    self:SetValue("__BarColor", oColor)

    return self
end

-- Gets the color of the slider bar.
---@return Color
function Slider:GetBarColor()
    return self:GetValue("__BarColor", Color.FromHSV(0, 0, 0.0047))
end

-- Sets the color of the slider handle.
---@generic T
---@param self T
---@param oColor Color
---@return T
function Slider:SetHandleColor(oColor)
    self:CallBlueprintEvent("SetHandleColor", oColor)

    self:SetValue("__HandleColor", oColor)

    return self
end

-- Gets the color of the slider handle.
---@return Color
function Slider:GetHandleColor()
    return self:GetValue("__HandleColor", Color.WHITE)
end