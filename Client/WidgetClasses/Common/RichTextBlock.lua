---@class RichTextBlock : BaseWidget
RichTextBlock = BaseWidget.Inherit("RichTextBlock")

function RichTextBlock:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_RichText")
    return self
end

-- Sets the text to display.
---@generic T
---@param self T
---@param sText string
---@return T
function RichTextBlock:SetText(sText)
    self:CallBlueprintEvent("SetText", sText)

    self:SetValue("__CachedText", sText)
end

-- Gets the widget text
---@return string
function RichTextBlock:GetText()
    return self:GetValue("__CachedText", "Text")
end

-- Sets the style of the text (Data Table asset reference).
---@generic T
---@param self T
---@param sStylePath string
---@return T
function RichTextBlock:SetStyleSheet(sStylePath)
    sStylePath = sStylePath .. "." .. sStylePath:match(".*/(.*)")

    self:CallBlueprintEvent("SetStyleSheet", sStylePath)

    self:SetValue("__CachedStyleSheet", sStylePath)

    return self
end

-- Gets the style of the text (Data Table asset reference).
---@return string
function RichTextBlock:GetStyleSheet()
    return self:GetValue("__CachedStyleSheet", "")
end

-- Replaces the existing decorators with the list provided.
---@generic T
---@param self T
---@param tDecoratorPaths table<string>
---@return T
function RichTextBlock:SetDecoratorPaths(tDecoratorPaths)
    self:CallBlueprintEvent("SetDecoratorPaths", tDecoratorPaths)

    self:SetValue("__CachedDecoratorPaths", tDecoratorPaths)

    return self
end

-- Gets the list of decorator paths.
---@return table<string>
function RichTextBlock:GetDecoratorPaths()
    return self:GetValue("__CachedDecoratorPaths", {})
end

-- Sets the minimum desired width for the text.
---@generic T
---@param self T
---@param fMinDesiredWidth number
---@return T
function RichTextBlock:SetMinDesiredWidth(fMinDesiredWidth)
    self:CallBlueprintEvent("SetMinDesiredWidth", fMinDesiredWidth)

    self:SetValue("__MinDesiredWidth", fMinDesiredWidth)

    return self
end

-- Gets the minimum desired width for the text.
---@return number
function RichTextBlock:GetMinDesiredWidth()
    return self:GetValue("__MinDesiredWidth", 0)
end

-- Sets the auto wrap text setting of the text.
---@generic T
---@param self T
---@param bAutoWrapText boolean
---@return T
function RichTextBlock:SetAutoWrapText(bAutoWrapText)
    self:CallBlueprintEvent("SetAutoWrapText", bAutoWrapText)

    self:SetValue("__AutoWrapText", bAutoWrapText)

    return self
end

-- Gets the auto wrap text setting of the text.
---@return boolean
function RichTextBlock:GetAutoWrapText()
    return self:GetValue("__AutoWrapText", false)
end

-- Sets how the text should be aligned with the margin.
---@generic T
---@param self T
---@param iJustification TextJustify
---@return T
function RichTextBlock:SetJustification(iJustification)
    self:CallBlueprintEvent("SetJustification", iJustification)

    self:SetValue("__Justification", iJustification)

    -- Stores the justification.
    self.__Justification = iJustification

    return self
end

-- Gets how the text should be aligned with the margin.
---@return TextJustify
function RichTextBlock:GetJustification()
    return self.__Justification or TextJustify.Left
end

-- Sets the case of the text.
---@generic T
---@param self T
---@param iTextCase CaseMode
---@return T
function RichTextBlock:SetCaseMode(iTextCase)
    self:CallBlueprintEvent("SetCaseMode", iTextCase)

    self:SetValue("__TextCase", iTextCase)

    return self
end

-- Gets the case of the text.
---@return CaseMode
function RichTextBlock:GetCaseMode()
    return self:GetValue("__TextCase", CaseMode.None)
end

-- Sets the overflow mode of the text.
-- Sets what happens to text that is clipped and doesn't fit within the clip rect for this widget.
---@generic T
---@param self T
---@param iOverflowMode OverflowMode
---@return T
function RichTextBlock:SetOverflowMode(iOverflowMode)
    self:CallBlueprintEvent("SetOverflowMode", iOverflowMode)

    self:SetValue("__OverflowMode", iOverflowMode)

    return self
end

-- Gets the overflow mode of the text.
---@return OverflowMode
function RichTextBlock:GetOverflowMode()
    return self:GetValue("__OverflowMode", OverflowMode.Overflow)
end