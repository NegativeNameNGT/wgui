-- A simple static text widget.
---@class TextBlock : BaseWidget
TextBlock = BaseWidget.Inherit("TextBlock", {
    Icon = "package://wgui/Client/Textures/Icons/TextBlock.png"
})

function TextBlock:Constructor(sDefaultText)
    self.Super:Constructor("wgui-assets::WBP_WGUI_Text")

    if sDefaultText then
        self:SetText(sDefaultText)
    end
    return self
end

-- Sets the text to display.
---@generic T
---@param self T
---@param sText string
---@return T
function TextBlock:SetText(sText)
    self:CallBlueprintEvent("SetText", sText)

    self:SetValue("__CachedText", sText)

    return self
end

-- Gets the widget text
---@return string
function TextBlock:GetText()
    return self:GetValue("__CachedText", "Text")
end

-- Sets the minimum desired width for the text.
---@generic T
---@param self T
---@param fMinDesiredWidth number
---@return T
function TextBlock:SetMinDesiredWidth(fMinDesiredWidth)
    self:CallBlueprintEvent("SetMinDesiredWidth", fMinDesiredWidth)

    self:SetValue("__MinDesiredWidth", fMinDesiredWidth)

    return self
end

-- Gets the minimum desired width for the text.
---@return number
function TextBlock:GetMinDesiredWidth()
    return self:GetValue("__MinDesiredWidth", 0)
end

-- Sets the auto wrap text setting of the text.
---@generic T
---@param self T
---@param bAutoWrapText boolean
---@return T
function TextBlock:SetAutoWrapText(bAutoWrapText)
    self:CallBlueprintEvent("SetAutoWrapText", bAutoWrapText)

    self:SetValue("__AutoWrapText", bAutoWrapText)

    return self
end

-- Gets the auto wrap text setting of the text.
---@return boolean
function TextBlock:GetAutoWrapText()
    return self:GetValue("__AutoWrapText", false)
end

-- Sets the font of the text.
---@generic T
---@param self T
---@param sFontName FontName
---@param sFontTypeface string | nil
---@param fFontSize number | nil
---@return T
function TextBlock:SetFont(sFontName, sFontTypeface, fFontSize)
    sFontName = sFontName or "Roboto"

    local sFontPath = WGUI.GetFontPath(sFontName)
    if not sFontPath then
        assert(false, "WGUI.Text:SetFont: Font '" .. sFontName .. "' is not registered.")
        return self
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

    return self
end

-- Gets the font of the text.
---@return table
function TextBlock:GetFont()
    return self:GetValue("__Font", {})
end

-- Sets the spacing of the letters of the text.
---@generic T
---@param self T
---@param fLetterSpacing number
---@return T
function TextBlock:SetLetterSpacing(fLetterSpacing)
    self:CallBlueprintEvent("SetLetterSpacing", fLetterSpacing)

    self:SetValue("__LetterSpacing", fLetterSpacing)

    return self
end

-- Gets the spacing of the letters of the text.
---@return number
function TextBlock:GetLetterSpacing()
    return self:GetValue("__LetterSpacing", 0)
end

-- Sets the font outline settings of the text.
---@generic T
---@param self T
---@param tOutlineSettings FontOutlineSettings
---@return T
function TextBlock:SetFontOutlineSettings(tOutlineSettings)
    self:CallBlueprintEvent("SetFontOutlineSettings", tOutlineSettings)

    self.__FontOutlineSettings = tOutlineSettings

    return self
end

-- Gets the font outline settings of the text.
---@return FontOutlineSettings
function TextBlock:GetFontOutlineSettings()
    return self.__FontOutlineSettings or {}
end

-- Sets how the text should be aligned with the margin.
---@generic T
---@param self T
---@param iJustification TextJustify
---@return T
function TextBlock:SetJustification(iJustification)
    self:CallBlueprintEvent("SetJustification", iJustification)

    self:SetValue("__Justification", iJustification)

    -- Stores the justification.
    self.__Justification = iJustification

    return self
end

-- Gets how the text should be aligned with the margin.
---@return TextJustify
function TextBlock:GetJustification()
    return self.__Justification or TextJustify.Left
end

-- Sets the case of the text.
---@generic T
---@param self T
---@param iTextCase CaseMode
---@return T
function TextBlock:SetCaseMode(iTextCase)
    self:CallBlueprintEvent("SetCaseMode", iTextCase)

    self:SetValue("__TextCase", iTextCase)

    return self
end

-- Gets the case of the text.
---@return CaseMode
function TextBlock:GetCaseMode()
    return self:GetValue("__TextCase", CaseMode.None)
end

-- Sets the overflow mode of the text.
-- Sets what happens to text that is clipped and doesn't fit within the clip rect for this widget.
---@generic T
---@param self T
---@param iOverflowMode OverflowMode
---@return T
function TextBlock:SetOverflowMode(iOverflowMode)
    self:CallBlueprintEvent("SetOverflowMode", iOverflowMode)

    self:SetValue("__OverflowMode", iOverflowMode)

    return self
end

-- Gets the overflow mode of the text.
---@return OverflowMode
function TextBlock:GetOverflowMode()
    return self:GetValue("__OverflowMode", OverflowMode.Overflow)
end

-- Sets the shadow settings (Color and Offset) of the text.
---@generic T
---@param self T
---@param Color Color | nil
---@param Offset Vector2D | nil
---@return T
function TextBlock:SetShadowSettings(Color, Offset)
    local CurrentColor, CurrentOffset = self:GetShadowSettings()

    self:CallBlueprintEvent("SetShadowSettings", Color or CurrentColor or Color.TRANSPARENT, Offset or CurrentOffset or Vector2D())

    self:SetValue("__ShadowSettings", {Color = Color, Offset = Offset})

    return self
end

-- Gets the shadow settings (Color and Offset) of the text.
---@return Color, Vector2D
function TextBlock:GetShadowSettings()
    local tShadowSettings = self:GetValue("__ShadowSettings", {Color = Color(), Offset = Vector2D()})
    return tShadowSettings.Color, tShadowSettings.Offset
end

-- Sets the text color.
---@generic T
---@param self T
---@param tColor Color
---@return T
function TextBlock:SetColor(tColor)
    tColor = tColor or Color.WHITE

    self:CallBlueprintEvent("SetTextColor", tColor)

    self:SetValue("__Color", tColor)

    return self
end