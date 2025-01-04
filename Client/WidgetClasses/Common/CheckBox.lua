-- The checkbox widget allows you to display a toggled state of 'unchecked' and 'checked'.
---@class CheckBox : PanelWidget
CheckBox = ContentWidget.Inherit("CheckBox", {})

function CheckBox:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_CheckBox")
    return self
end

-- Sets the style of the checkbox.
---@generic T
---@param self T
---@param oStyle CheckBoxStyle
---@return T
function CheckBox:SetStyleSheet(oStyle)
    self:CallBlueprintEvent("SetStyleSheet",
        oStyle.Background or {},
        oStyle.HoveredBackground or {},
        oStyle.PressedBackground or {},
        oStyle.Unchecked or {},
        oStyle.HoveredUnchecked or {},
        oStyle.PressedUnchecked or {},
        oStyle.Checked or {},
        oStyle.HoveredChecked or {},
        oStyle.PressedChecked or {}
    )

    ---@private
    self.__StyleSheet = oStyle

    return self
end

-- Gets the style of the checkbox.
---@return CheckBoxStyle
function CheckBox:GetStyleSheet()
    if not self.__StyleSheet then
        self.__StyleSheet = CheckBoxStyle(
            -- Background
            Brush(DrawMode.RoundedBox, Color.FromHSV(0, 0, 0.0047), nil, Vector2D(18), OutlineSettings(
                Quat(3), Color.TRANSPARENT, 1
            )),
            Brush(DrawMode.RoundedBox, Color.FromHSV(0, 0, 0.0047), nil, Vector2D(18), OutlineSettings(
                Quat(3), Color.FromHSV(0, 0, 0.074), 1
            )),
            Brush(DrawMode.RoundedBox, Color.FromHSV(0, 0, 0.0047), nil, Vector2D(18), OutlineSettings(
                Quat(3), Color.TRANSPARENT, 1
            )),
            -- Unchecked
            Brush(DrawMode.None, nil, nil, Vector2D()),
            Brush(DrawMode.None, nil, nil, Vector2D()),
            Brush(DrawMode.None, nil, nil, Vector2D()),
            -- Checked
            Brush(DrawMode.Image, Color.FromHSV(225.897, 0.995, 1), "/WGui/Textures/Check", Vector2D(16)),
            Brush(DrawMode.Image, Color.FromHSV(225.897, 0.995, 1), "/WGui/Textures/Check", Vector2D(16)),
            Brush(DrawMode.Image, Color.FromHSV(225.897, 0.995, 1), "/WGui/Textures/Check", Vector2D(16))
        )
    end
    return self.__StyleSheet
end

-- Sets the checked state of the checkbox.
---@generic T
---@param self T
---@param bChecked boolean
---@return T
function CheckBox:SetChecked(bChecked)
    self:CallBlueprintEvent("SetChecked", bChecked)

    self:SetValue("__CachedChecked", bChecked)

    return self
end

-- Gets the checked state of the checkbox.
---@return boolean
function CheckBox:GetChecked()
    return self:GetValue("__CachedChecked", false)
end