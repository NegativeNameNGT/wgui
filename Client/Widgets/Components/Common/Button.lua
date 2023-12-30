-- The button is a click-able widget to enable basic interation, you can place any other widget inside a button to make a more complex and interesting click-able element in your UI.
---@class Button : PanelWidget
Button = PanelWidget.Inherit("Button", {
    -- The button can only have one child widget.
    ChildrenLimit = 1,
})

function Button:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_Button")

    return self
end

-- Sets the style of the button.
---@param oStyle ButtonStyle
function Button:SetStyleSheet(oStyle)
    self:CallBlueprintEvent("SetStyleSheet", oStyle.Normal or {}, oStyle.Hovered or {}, oStyle.Pressed or {}, oStyle.NormalPadding or Margin(12, 1.5, 12, 1.5), oStyle.PressedPadding or Margin(12, 2.5, 12, 0.5))

    self.__StyleSheet = oStyle
end

-- Gets the style of the button.
---@return ButtonStyle
function Button:GetStyleSheet()
    if not self.__StyleSheet then
        self.__StyleSheet = ButtonStyle(
            Brush(DrawMode.RoundedBox, Color.FromHSV(0, 0, 0.0395), nil, nil, OutlineSettings(
                Quat(4), Color.BLACK, 1
            )),
            Brush(DrawMode.RoundedBox, Color.FromHSV(0, 0, 0.0953), nil, nil, OutlineSettings(
                Quat(4), Color.BLACK, 1
            )),
            Brush(DrawMode.RoundedBox, Color.FromHSV(0, 0, 0.0284), nil, nil, OutlineSettings(
                Quat(4), Color.BLACK, 1
            ))
        )
    end
    return self.__StyleSheet
end

-- Sets the type of mouse action required by the user to trigger the button.
---@param iClickMethod ClickMethod
function Button:SetClickMethod(iClickMethod)
    self:CallBlueprintEvent("SetClickMethod", iClickMethod)
end

-- Sets the type of touch action required by the user to trigger the button.
---@param iTouchMethod TouchMethod
function Button:SetTouchMethod(iTouchMethod)
    self:CallBlueprintEvent("SetTouchMethod", iTouchMethod)
end

-- Sets the type of keyboard/gamepad action required by the user to trigger the button.
---@param iPressMethod PressMethod
function Button:SetPressMethod(iPressMethod)
    self:CallBlueprintEvent("SetPressMethod", iPressMethod)
end