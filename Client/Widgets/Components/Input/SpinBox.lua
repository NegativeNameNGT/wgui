-- A numerical entry box that allows for direct entry of the number or allows the user to click and slide the number.
---@class SpinBox : BaseWidget
SpinBox = BaseWidget.Inherit("SpinBox")

function SpinBox:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_SpinBox")
    return self
end

-- Sets the style of the spinbox.
---@param oStyle SpinBoxStyle
function SpinBox:SetStyleSheet(oStyle)
    self:CallBlueprintEvent("SetStyleSheet",
        oStyle.Background or {},
        oStyle.ActiveBackground or {},
        oStyle.HoveredBackground or {},
        oStyle.ActiveFillBrush or {},
        oStyle.HoveredFillBrush or {},
        oStyle.InactiveFillBrush or {},
        oStyle.ArrowBrush or {},
        oStyle.TextPadding or {Left = 7, Top = 2.5, Right = 7, Bottom = 2.5},
        oStyle.InsetPadding or {Left = 1, Top = 1, Right = 1, Bottom = 1}
    )

    -- Stores the style.
    self.__StyleSheet = oStyle
end

-- Gets the style of the spinbox.
---@return SpinBoxStyle
function SpinBox:GetStyleSheet()
    if not self.__StyleSheet then
        self.__StyleSheet = SpinBoxStyle(
            Brush(DrawMode.RoundedBox, Color.FromHSV(0, 0, 0.0047), nil, Vector2D(), OutlineSettings(
                Quat(4), Color.FromHSV(0, 0, 0.033), 1
            )),
            Brush(DrawMode.RoundedBox, Color.FromHSV(0, 0, 0.0047), nil, Vector2D(), OutlineSettings(
                Quat(4), Color.FromHSV(0, 0, 0.074), 1
            )),
            nil,
            nil,
            nil,
            nil,
            nil,
            Margin(7, 2.5, 7, 2.5),
            Margin(1, 1, 1, 1)
        )
    end
    return self.__StyleSheet
end

-- Sets the font of the text.
---@param sFontName string
---@param sFontTypeface string | nil
---@param fFontSize number | nil
function SpinBox:SetFont(sFontName, sFontTypeface, fFontSize)
    -- Checks if the font is
    local sFontPath = WGUI.Fonts[sFontName]
    if not sFontPath then
        assert(false, "WGUI.Text:SetFont: Font '" .. sFontName .. "' is not registered.")
        return
    end

    -- Gets the current font data.
    local tFontData = self:GetFont()

    -- Gets the new font size.
    local fNewFontSize = fFontSize or tFontData.Size or 16

    if sFontPath:find("package://") then
        self:CallBlueprintEvent("SetFont", sFontPath, "", sFontTypeface or "", fNewFontSize)
    else
        self:CallBlueprintEvent("SetFont", nil, sFontPath, sFontTypeface or "", fNewFontSize)
    end

    -- Updates the font data.
    tFontData.Size = fNewFontSize

    -- Sets the new font data.
    self:SetValue("__Font", tFontData)
end

-- Gets the font of the text.
---@return table
function SpinBox:GetFont()
    return self:GetValue("__Font", {})
end

-- Sets the color of the text.
---@param Color Color
function SpinBox:SetTextColor(Color)
    self:SetForegroundColor(Color, ColorMode.SpecifiedColor)
end

-- Sets the spacing of the letters of the text.
---@param fLetterSpacing number
function SpinBox:SetLetterSpacing(fLetterSpacing)
    self:CallBlueprintEvent("SetLetterSpacing", fLetterSpacing)

    self:SetValue("__LetterSpacing", fLetterSpacing)
end

-- Gets the spacing of the letters of the text.
---@return number
function SpinBox:GetLetterSpacing()
    return self:GetValue("__LetterSpacing", 0)
end

-- Sets the font outline settings of the text.
---@param tOutlineSettings FontOutlineSettings
function SpinBox:SetFontOutlineSettings(tOutlineSettings)
    self:CallBlueprintEvent("SetFontOutlineSettings", tOutlineSettings)

    self.__FontOutlineSettings = tOutlineSettings
end

-- Gets the font outline settings of the text.
---@return FontOutlineSettings
function SpinBox:GetFontOutlineSettings()
    return self.__FontOutlineSettings or {}
end

-- Sets how the text should be aligned with the margin.
---@param iJustification TextJustify
function SpinBox:SetJustification(iJustification)
    self:CallBlueprintEvent("SetJustification", iJustification)

    self:SetValue("__Justification", iJustification)

    -- Stores the justification.
    self.__Justification = iJustification
end

-- Gets how the text should be aligned with the margin.
---@return TextJustify
function SpinBox:GetJustification()
    return self.__Justification or TextJustify.Left
end

-- Sets the new value of the spinbox.
---@param fValue number
function SpinBox:SetSpinBoxValue(fValue)
    self:CallBlueprintEvent("SetValue", fValue)

    -- Stores the value.
    self:SetValue("__Value", fValue)
end

-- Gets the current value of the spinbox.
---@return number
function SpinBox:GetSpinBoxValue()
    return self:GetValue("__Value", 0)
end

-- Sets the minimum value of the spinbox.
---@param fValue number
function SpinBox:SetMinValue(fValue)
    self:CallBlueprintEvent("SetMinValue", fValue)

    -- Stores the value.
    self:SetValue("__MinValue", fValue)
end

-- Gets the minimum value of the spinbox.
---@return number
function SpinBox:GetMinValue()
    return self:GetValue("__MinValue", 0)
end

-- Sets the maximum value of the spinbox.
---@param fValue number
function SpinBox:SetMaxValue(fValue)
    self:CallBlueprintEvent("SetMaxValue", fValue)

    -- Stores the value.
    self:SetValue("__MaxValue", fValue)
end

-- Gets the maximum value of the spinbox.
---@return number
function SpinBox:GetMaxValue()
    return self:GetValue("__MaxValue", 0)
end

-- Sets the slider minimum value of the spinbox.
---@param fValue number
function SpinBox:SetSliderMinValue(fValue)
    self:CallBlueprintEvent("SetSliderMinValue", fValue)

    -- Stores the value.
    self:SetValue("__SliderMinValue", fValue)
end

-- Gets the slider minimum value of the spinbox.
---@return number
function SpinBox:GetSliderMinValue()
    return self:GetValue("__SliderMinValue", 0)
end

-- Sets the slider maximum value of the spinbox.
---@param fValue number
function SpinBox:SetSliderMaxValue(fValue)
    self:CallBlueprintEvent("SetSliderMaxValue", fValue)

    -- Stores the value.
    self:SetValue("__SliderMaxValue", fValue)
end

-- Gets the slider maximum value of the spinbox.
---@return number
function SpinBox:GetSliderMaxValue()
    return self:GetValue("__SliderMaxValue", 0)
end

-- Sets the minimum required fractional digits of the spinbox.
---@param iValue integer
function SpinBox:SetMinFractionalDigits(iValue)
    self:CallBlueprintEvent("SetMinFractionalDigits", iValue)

    -- Stores the value.
    self:SetValue("__MinFractionalDigits", iValue)
end

-- Gets the minimum required fractional digits of the spinbox.
---@return integer
function SpinBox:GetMinFractionalDigits()
    return self:GetValue("__MinFractionalDigits", 0)
end

-- Sets the maximum required fractional digits of the spinbox.
---@param iValue integer
function SpinBox:SetMaxFractionalDigits(iValue)
    self:CallBlueprintEvent("SetMaxFractionalDigits", iValue)

    -- Stores the value.
    self:SetValue("__MaxFractionalDigits", iValue)
end

-- Gets the maximum required fractional digits of the spinbox.
---@return integer
function SpinBox:GetMaxFractionalDigits()
    return self:GetValue("__MaxFractionalDigits", 0)
end

-- Sets whether this spin box should use delta snapping for typed values.
---@param bValue boolean
function SpinBox:SetAlwaysUseDeltaSnap(bValue)
    self:CallBlueprintEvent("SetAlwaysUsesDeltaSnap", bValue)

    -- Stores the value.
    self:SetValue("__DeltaSnap", bValue)
end

-- Gets whether this spin box should use delta snapping for typed values.
---@return boolean
function SpinBox:GetAlwaysUseDeltaSnap()
    return self:GetValue("__DeltaSnap", false)
end

-- Sets whether this spin box should have slider feature enabled.
---@param bValue boolean
function SpinBox:SetIsSliderEnabled(bValue)
    self:CallBlueprintEvent("SetIsSliderEnabled", bValue)
end

-- Sets the amount by which the spin box value changes.
---@param fValue number
function SpinBox:SetDelta(fValue)
    self:CallBlueprintEvent("SetDelta", fValue)

    -- Stores the value.
    self:SetValue("__Delta", fValue)
end

-- Gets the amount by which the spin box value changes.
---@return number
function SpinBox:GetDelta()
    return self:GetValue("__Delta", 0)
end