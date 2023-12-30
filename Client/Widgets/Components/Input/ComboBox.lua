---@class ComboBox : BaseWidget
ComboBox = BaseWidget.Inherit("ComboBox")

function ComboBox:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_ComboBox")
    return self
end

-- Sets the style of the combo box.
---@param oStyle ButtonStyle
function ComboBox:SetStyleSheet(oStyle)
    self:CallBlueprintEvent("SetStyleSheet", oStyle.Normal or {}, oStyle.Hovered or {}, oStyle.Pressed or {})

    self.__StyleSheet = oStyle
end

-- Gets the style of the combo box.
---@return ButtonStyle
function ComboBox:GetStyleSheet()
    if not self.__StyleSheet then
        self.__StyleSheet = ButtonStyle(
            Brush(DrawMode.RoundedBox, Color.FromHSV(0, 0, 0.0047), nil, nil, OutlineSettings(
                Quat(4), Color.FromHSV(0, 0, 0.0356), 1
            )),
            Brush(DrawMode.RoundedBox, Color.FromHSV(0, 0, 0.0047), nil, nil, OutlineSettings(
                Quat(4), Color.FromHSV(0, 0, 0.0742), 1
            )),
            Brush(DrawMode.RoundedBox, Color.FromHSV(0, 0, 0.0047), nil, nil, OutlineSettings(
                Quat(4), Color.FromHSV(0, 0, 0.0356), 1
            )),
            Margin(),
            Margin(0, 1.5, 0, 0)
        )
    end
    return self.__StyleSheet
end

-- Sets the menu widget of the combo box.
---@param oMenu BaseWidget
function ComboBox:SetMenu(oMenu)
    self:SetBlueprintPropertyValue("MenuWidget", oMenu)
end

-- Adds an option to the combo box.
---@param sOption string
function ComboBox:AddOption(sOption)
    self:CallBlueprintEvent("AddOption", sOption)
end

-- Removes an option from the combo box.
---@param sOption string
---@return boolean
function ComboBox:RemoveOption(sOption)
    return self:CallBlueprintEvent("RemoveOption", sOption)
end

-- Sets the options of the combo box.
---@param tOptions table<string>
function ComboBox:SetOptions(tOptions)
    self:SetBlueprintPropertyValue("DefaultOptions", tOptions)
end

-- Refreshes the list of options. If you added new ones, and want to update the list even if it's currently being displayed use this.
function ComboBox:RefreshOptions()
    self:CallBlueprintEvent("RefreshOptions")
end

-- Adds a selected option to the combo box.
---@param sOption string
function ComboBox:AddSelectedOption(sOption)
    self:CallBlueprintEvent("AddSelectedOption", sOption)

    -- Stores the selected option
    local tSelectedOptions = self:GetValue("__SelectedOptions", {})
    table.insert(tSelectedOptions, sOption)
    self:SetValue("__SelectedOptions", tSelectedOptions)
end

-- Removes a selected option from the combo box.
---@param sOption string
---@return boolean
function ComboBox:RemoveSelectedOption(sOption)
    -- Removes the selected option
    local tSelectedOptions = self:GetValue("__SelectedOptions", {})
    tSelectedOptions[sOption] = nil

    return self:CallBlueprintEvent("RemoveSelectedOption", sOption)
end

-- Sets whether or not the combo box is multi-select.
---@param bMultiSelect boolean
function ComboBox:SetMultiSelect(bMultiSelect)
    self:SetBlueprintPropertyValue("MultiSelection", bMultiSelect)

    self:SetValue("__MultiSelect", bMultiSelect)
end

-- Gets whether or not the combo box is multi-select.
---@return boolean
function ComboBox:GetMultiSelect()
    return self:GetValue("__MultiSelect", false)
end

-- Gets the selected options of the combo box.
---@return table<string>
function ComboBox:GetSelectedOptions()
    return self:GetValue("__SelectedOptions", {})
end

-- Sets the text to display.
---@param sText string
function ComboBox:SetText(sText)
    self:CallBlueprintEvent("SetText", sText)
end

-- Sets the font of the text.
---@param sFontName string
---@param sFontTypeface string | nil
---@param fFontSize number | nil
function ComboBox:SetFont(sFontName, sFontTypeface, fFontSize)
    -- Checks if the font is
    local sFontPath = WGUI.Fonts[sFontName]
    if not sFontPath then
        assert(false, "WGUI.ComboBox:SetFont: Font '" .. sFontName .. "' is not registered.")
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
function ComboBox:GetFont()
    return self:GetValue("__Font", {})
end