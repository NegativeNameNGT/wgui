-- The combobox allows you to display a list of options to the user in a dropdown menu for them to select one.
---@class ComboBox : BaseWidget
ComboBox = BaseWidget.Inherit("ComboBox")

function ComboBox:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_ComboBox")
    return self
end

-- Sets the style of the combo box.
---@param oStyle ComboBoxStyle
function ComboBox:SetStyleSheet(oStyle)
    self:CallBlueprintEvent("SetStyleSheet",
        oStyle.ButtonStyle.Normal or {},
        oStyle.ButtonStyle.Hovered or {},
        oStyle.ButtonStyle.Pressed or {},
        oStyle.ButtonStyle.NormalPadding or Margin(12, 1.5, 12, 1.5),
        oStyle.ButtonStyle.PressedPadding or Margin(12, 2.5, 12, 0.5),
        oStyle.Arrow or {}
    )

    self.__StyleSheet = oStyle
end

-- Gets the style of the combo box.
---@return ComboBoxStyle
function ComboBox:GetStyleSheet()
    if not self.__StyleSheet then
        self.__StyleSheet = ComboBoxStyle(
            ButtonStyle(
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
            ),
            Brush(DrawMode.Image, Color.FromHSV(0, 0, 0.527), "/WGui/Textures/ComboBox/Arrow", Vector2D(16))
        )
    end
    return self.__StyleSheet
end

-- Sets the menu widget of the combo box.
---@param oMenu BaseWidget
function ComboBox:SetCustomMenu(oMenu)
    self:SetBlueprintPropertyValue("MenuWidget", oMenu)

    self:SetValue("__MenuWidget", oMenu)
end

-- Gets the menu widget of the combo box.
---@return BaseWidget
function ComboBox:GetCustomMenu()
    return self:GetValue("__MenuWidget", nil)
end

-- Adds an option to the combo box.
---@param sOption string
function ComboBox:AddOption(sOption)
    self:CallBlueprintEvent("AddOption", sOption)

    -- Stores the option
    local tOptions = self:GetValue("__Options", {})
    tOptions[sOption] = true
    self:SetValue("__Options", tOptions)
end

-- Removes an option from the combo box.
---@param sOption string
---@return boolean
function ComboBox:RemoveOption(sOption)
    local bSuccess = self:CallBlueprintEvent("RemoveOption", sOption)

    if bSuccess then
        -- Removes the option
        local tOptions = self:GetValue("__Options", {})
        tOptions[sOption] = nil
        self:SetValue("__Options", tOptions)
    end

    return bSuccess
end

-- Sets the options of the combo box.
---@param tOptions table<integer, string>
function ComboBox:SetOptions(tOptions)
    self:SetBlueprintPropertyValue("DefaultOptions", tOptions)

    local tTempOptions = {}
    for _, sOption in ipairs(tOptions) do
        tTempOptions[sOption] = true
    end
    self:SetValue("__Options", tTempOptions)
end

-- Gets the options of the combo box.
---@return table<integer, string>
function ComboBox:GetOptions()
    local tOptions = self:GetValue("__Options", {})
    local tTempOptions = {}
    for sOption, _ in pairs(tOptions) do
        table.insert(tTempOptions, sOption)
    end
    return tTempOptions
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

    for i, sSelectedOption in ipairs(tSelectedOptions) do
        if sSelectedOption == sOption then
            table.remove(tSelectedOptions, i)
            break
        end
    end
    self:SetValue("__SelectedOptions", tSelectedOptions)

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

-- Sets the color of the text.
---@param Color Color
function ComboBox:SetTextColor(Color)
    self:SetForegroundColor(Color, ColorMode.SpecifiedColor)
end