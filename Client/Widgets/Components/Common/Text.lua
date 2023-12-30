-- A simple static text widget.
---@class TextBlock : BaseWidget
TextBlock = BaseWidget.Inherit("Text")

function TextBlock:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_Text")
    return self
end

-- Sets the text to display.
---@param sText string
function TextBlock:SetText(sText)
    self:CallBlueprintEvent("SetText", sText)

    self:SetValue("__CachedText", sText)
end

-- Gets the widget text
---@return string
function TextBlock:GetText()
    return self:GetValue("__CachedText", "Text")
end

-- Sets the minimum desired width for the text.
---@param fMinDesiredWidth number
function TextBlock:SetMinDesiredWidth(fMinDesiredWidth)
    self:CallBlueprintEvent("SetMinDesiredWidth", fMinDesiredWidth)

    self:SetValue("__MinDesiredWidth", fMinDesiredWidth)
end

-- Gets the minimum desired width for the text.
---@return number
function TextBlock:GetMinDesiredWidth()
    return self:GetValue("__MinDesiredWidth", 0)
end

-- Sets the auto wrap text setting of the text.
---@param bAutoWrapText boolean
function TextBlock:SetAutoWrapText(bAutoWrapText)
    self:CallBlueprintEvent("SetAutoWrapText", bAutoWrapText)

    self:SetValue("__AutoWrapText", bAutoWrapText)
end

-- Gets the auto wrap text setting of the text.
---@return boolean
function TextBlock:GetAutoWrapText()
    return self:GetValue("__AutoWrapText", false)
end

-- Sets the font of the text.
---@param sFontName string
---@param sFontTypeface string | nil
---@param fFontSize number | nil
function TextBlock:SetFont(sFontName, sFontTypeface, fFontSize)
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
function TextBlock:GetFont()
    return self:GetValue("__Font", {})
end

-- Sets the spacing of the letters of the text.
---@param fLetterSpacing number
function TextBlock:SetLetterSpacing(fLetterSpacing)
    self:CallBlueprintEvent("SetLetterSpacing", fLetterSpacing)

    self:SetValue("__LetterSpacing", fLetterSpacing)
end

-- Gets the spacing of the letters of the text.
---@return number
function TextBlock:GetLetterSpacing()
    return self:GetValue("__LetterSpacing", 0)
end

-- Sets the font outline settings of the text.
---@param tOutlineSettings OutlineSettings
function TextBlock:SetFontOutlineSettings(tOutlineSettings)
    self:CallBlueprintEvent("SetFontOutlineSettings", tOutlineSettings)

    self.__FontOutlineSettings = tOutlineSettings
end

-- Gets the font outline settings of the text.
---@return OutlineSettings
function TextBlock:GetFontOutlineSettings()
    return self.__FontOutlineSettings or {}
end

-- Sets how the text should be aligned with the margin.
---@param iJustification TextJustify
function TextBlock:SetJustification(iJustification)
    self:CallBlueprintEvent("SetJustification", iJustification)

    self:SetValue("__Justification", iJustification)

    -- Stores the justification.
    self.__Justification = iJustification
end

-- Gets how the text should be aligned with the margin.
---@return TextJustify
function TextBlock:GetJustification()
    return self.__Justification or TextJustify.Left
end

-- Sets the case of the text.
---@param iTextCase CaseMode
function TextBlock:SetCaseMode(iTextCase)
    self:CallBlueprintEvent("SetCaseMode", iTextCase)

    self:SetValue("__TextCase", iTextCase)
end

-- Gets the case of the text.
---@return CaseMode
function TextBlock:GetCaseMode()
    return self:GetValue("__TextCase", CaseMode.None)
end

-- Sets the overflow mode of the text.
-- Sets what happens to text that is clipped and doesn't fit within the clip rect for this widget.
---@param iOverflowMode OverflowMode
function TextBlock:SetOverflowMode(iOverflowMode)
    self:CallBlueprintEvent("SetOverflowMode", iOverflowMode)

    self:SetValue("__OverflowMode", iOverflowMode)
end

-- Gets the overflow mode of the text.
---@return OverflowMode
function TextBlock:GetOverflowMode()
    return self:GetValue("__OverflowMode", OverflowMode.Overflow)
end

-- Sets the shadow settings (Color and Offset) of the text.
---@param Color Color | nil
---@param Offset Vector2D | nil
function TextBlock:SetShadowSettings(Color, Offset)
    local CurrentColor, CurrentOffset = self:GetShadowSettings()

    self:CallBlueprintEvent("SetShadowSettings", Color or CurrentColor or Color.TRANSPARENT, Offset or CurrentOffset or Vector2D())

    self:SetValue("__ShadowSettings", {Color = Color, Offset = Offset})
end

-- Gets the shadow settings (Color and Offset) of the text.
---@return Color, Vector2D
function TextBlock:GetShadowSettings()
    local tShadowSettings = self:GetValue("__ShadowSettings", {Color = Color(), Offset = Vector2D()})
    return tShadowSettings.Color, tShadowSettings.Offset
end