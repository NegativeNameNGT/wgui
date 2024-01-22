---@class EditableText : BaseWidget
EditableText = BaseWidget.Inherit("EditableText")

function EditableText:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_EditableText")

    self:BindDispatcher("OnTextChanged", function (_, sText)
        self:SetValue("__CachedText", sText)
    end)
    return self
end

-- Sets the style of the text box.
---@param oStyle TextBlockStyle
function EditableText:SetStyleSheet(oStyle)
    self:CallBlueprintEvent("SetStyleSheet", oStyle.HighlightShape, oStyle.StrikeBrush, oStyle.UnderlineBrush)

    self.__StyleSheet = oStyle
end

-- Gets the style of the text box.
---@return TextBlockStyle
function EditableText:GetStyleSheet()
    if not self.__StyleSheet then
        self.__StyleSheet = TextBlockStyle(
            Brush(DrawMode.Box, nil, nil, Vector2D(), Margin(0.375, 0.375, 0.375, 0.375)),
            Brush(DrawMode.Image),
            Brush(DrawMode.Image)
        )
    end
    return self.__StyleSheet
end

-- Sets whether or not the text should be multi-line.
---@param bIsMultiLine boolean
function EditableText:SetIsMultiLine(bIsMultiLine)
    self:CallBlueprintEvent("SetIsMultiLine", bIsMultiLine)

    self:SetValue("__IsMultiLine", bIsMultiLine)
end

-- Gets whether or not the text should be multi-line.
---@return boolean
function EditableText:GetIsMultiLine()
    return self:GetValue("__IsMultiLine", false)
end

-- Sets the text to display.
---@param sText string
function EditableText:SetText(sText)
    self:CallBlueprintEvent("SetText", sText)

    self:SetValue("__CachedText", sText)
end

-- Gets the widget text
---@return string
function EditableText:GetText()
    return self:GetValue("__CachedText", "")
end

-- Sets the color of the text.
---@param Color Color
function EditableText:SetTextColor(Color)
    self:SetForegroundColor(Color, ColorMode.SpecifiedColor)
end

-- Sets the selected background color of the text.
---@param Color Color
function EditableText:SetSelectedColor(Color)
    self:CallBlueprintEvent("SetSelectedColor", {
        SelectedBackgroundColor = {SpecifiedColor = Color, ColorUseRule = 0}
    })
end

-- Sets the hint text to display.
---@param sHintText string
function EditableText:SetHintText(sHintText)
    self:CallBlueprintEvent("SetHintText", sHintText)

    self:SetValue("__CachedHintText", sHintText)
end

-- Gets the hint text to display.
---@return string
function EditableText:GetHintText()
    return self:GetValue("__CachedHintText", "")
end

-- Sets whether this text box can actually be modfied interactively by the user.
---@param bIsReadOnly boolean
function EditableText:SetIsReadOnly(bIsReadOnly)
    self:CallBlueprintEvent("SetIsReadOnly", bIsReadOnly)
end

-- Sets the minimum desired width for the text.
---@param fMinDesiredWidth number
function EditableText:SetMinDesiredWidth(fMinDesiredWidth)
    self:CallBlueprintEvent("SetMinDesiredWidth", fMinDesiredWidth)

    self:SetValue("__MinDesiredWidth", fMinDesiredWidth)
end

-- Gets the minimum desired width for the text.
---@return number
function EditableText:GetMinDesiredWidth()
    return self:GetValue("__MinDesiredWidth", 0)
end

-- Sets the font of the text.
---@param sFontName string
---@param sFontTypeface string | nil
---@param fFontSize number | nil
function EditableText:SetFont(sFontName, sFontTypeface, fFontSize)
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
function EditableText:GetFont()
    return self:GetValue("__Font", {})
end

-- Sets the spacing of the letters of the text.
---@param fLetterSpacing number
function EditableText:SetLetterSpacing(fLetterSpacing)
    self:CallBlueprintEvent("SetLetterSpacing", fLetterSpacing)

    self:SetValue("__LetterSpacing", fLetterSpacing)
end

-- Gets the spacing of the letters of the text.
---@return number
function EditableText:GetLetterSpacing()
    return self:GetValue("__LetterSpacing", 0)
end

-- Sets the font outline settings of the text.
---@param tOutlineSettings FontOutlineSettings
function EditableText:SetFontOutlineSettings(tOutlineSettings)
    self:CallBlueprintEvent("SetFontOutlineSettings", tOutlineSettings)

    self.__FontOutlineSettings = tOutlineSettings
end

-- Gets the font outline settings of the text.
---@return FontOutlineSettings
function EditableText:GetFontOutlineSettings()
    return self.__FontOutlineSettings or {}
end

-- Sets how the text should be aligned with the margin.
---@param iJustification TextJustify
function EditableText:SetJustification(iJustification)
    self:CallBlueprintEvent("SetJustification", iJustification)

    self:SetValue("__Justification", iJustification)

    -- Stores the justification.
    self.__Justification = iJustification
end

-- Gets how the text should be aligned with the margin.
---@return TextJustify
function EditableText:GetJustification()
    return self.__Justification or TextJustify.Left
end

-- Sets the overflow mode of the text.
-- Sets what happens to text that is clipped and doesn't fit within the clip rect for this widget.
---@param iOverflowMode OverflowMode
function EditableText:SetOverflowMode(iOverflowMode)
    self:CallBlueprintEvent("SetOverflowMode", iOverflowMode)

    self:SetValue("__OverflowMode", iOverflowMode)
end

-- Gets the overflow mode of the text.
---@return OverflowMode
function EditableText:GetOverflowMode()
    return self:GetValue("__OverflowMode", OverflowMode.Overflow)
end

-- Sets the case of the text .
---@param iTextCase CaseMode
function EditableText:SetCaseMode(iTextCase)
    self:CallBlueprintEvent("SetCaseMode", iTextCase)

    self:SetValue("__TextCase", iTextCase)
end

-- Gets the case of the text.
---@return CaseMode
function EditableText:GetCaseMode()
    return self:GetValue("__TextCase", CaseMode.None)
end

-- Sets the shadow settings (Color and Offset) of the text.
---@param Color Color | nil
---@param Offset Vector2D | nil
function EditableText:SetShadowSettings(Color, Offset)
    local CurrentColor, CurrentOffset = self:GetShadowSettings()

    self:CallBlueprintEvent("SetShadowSettings", Color or CurrentColor or Color.TRANSPARENT, Offset or CurrentOffset or Vector2D())

    self:SetValue("__ShadowSettings", {Color = Color, Offset = Offset})
end

-- Gets the shadow settings (Color and Offset) of the text.
---@return Color, Vector2D
function EditableText:GetShadowSettings()
    local tShadowSettings = self:GetValue("__ShadowSettings", {Color = Color(), Offset = Vector2D()})
    return tShadowSettings.Color, tShadowSettings.Offset
end

-- Sets a mask character to be replaced for each display character. Only for single-line text.
---@param sMaskCharacter string
function EditableText:ApplyMaskCharacter(sMaskCharacter)
    self:CallBlueprintEvent("ApplyMaskCharacter", sMaskCharacter)

    self:SetValue("__MaskCharacter", sMaskCharacter)
end

-- Gets the mask character to be replaced for each display character. Only for single-line text.
---@return string
function EditableText:GetMaskCharacter()
    return self:GetValue("__MaskCharacter", "")
end