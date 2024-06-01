-- An arbitrary scrollable collection of widgets.
---@class ScrollBox : PanelWidget
ScrollBox = PanelWidget.Inherit("ScrollBox", {
    Slot = ScrollBoxSlot,
    Icon = "package://wgui/Client/Textures/Icons/ScrollBox.png"
})

function ScrollBox:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_ScrollBox")
    return self
end

-- Sets the style of the scroll box.
---@generic T
---@param self T
---@param oStyle ScrollBoxStyle
---@return T
function ScrollBox:SetBoxStyleSheet(oStyle)
    self:CallBlueprintEvent("SetStyleSheet",
        oStyle.BarThickness or 9,
        oStyle.TopShadow or {},
        oStyle.BottomShadow or {},
        oStyle.LeftShadow or {},
        oStyle.RightShadow or {},
        oStyle.HorizontalScrolledContentPadding or Margin(0, 0, 1, 0),
        oStyle.VerticalScrolledContentPadding or Margin(0, 0, 0, 1)
    )

    -- Stores the style.
    self.__StyleSheet = oStyle

    return self
end

-- Gets the style of the scroll box.
---@return ScrollBoxStyle
function ScrollBox:GetBoxStyleSheet()
    if not self.__StyleSheet then
        self.__StyleSheet = ScrollBoxStyle(
            9,
            Brush(DrawMode.Box, nil, "/WGui/Textures/ScrollBox/ScrollBoxShadowTop", Vector2D(16, 8), Margin(0.5, 1, 0.5, 0)),
            Brush(DrawMode.Box, nil, "/WGui/Textures/ScrollBox/ScrollBoxShadowBottom", Vector2D(16, 8), Margin(0.5, 0, 0.5, 1)),
            Brush(DrawMode.Box, nil, "/WGui/Textures/ScrollBox/ScrollBoxShadowLeft", Vector2D(8, 16), Margin(1, 0.5, 0, 0.5)),
            Brush(DrawMode.Box, nil, "/WGui/Textures/ScrollBox/ScrollBoxShadowRight", Vector2D(8, 16), Margin(0, 0.5, 1, 0.5)),
            Margin(0, 0, 1, 0),
            Margin(0, 0, 1, 0)
        )
    end
    return self.__StyleSheet
end

-- Sets the style of the bar.
---@generic T
---@param self T
---@param oStyle ScrollBarStyle
---@return T
function ScrollBox:SetBarStyleSheet(oStyle)
    self:CallBlueprintEvent("SetBarStyleSheet",
        oStyle.HorizontalBackground or {},
        oStyle.VerticalBackground or {},
        oStyle.VerticalTopSlot or {},
        oStyle.HorizontalTopSlot or {},
        oStyle.VerticalBottomSlot or {},
        oStyle.HorizontalBottomSlot or {},
        oStyle.NormalThumb or {},
        oStyle.HoveredThumb or {},
        oStyle.DraggedThumb or {},
        oStyle.BarThickness or 16
    )

    -- Stores the style.
    self.__BarStyleSheet = oStyle

    return self
end

-- Gets the style of the bar.
---@return ScrollBarStyle
function ScrollBox:GetBarStyleSheet()
    if not self.__BarStyleSheet then
        self.__BarStyleSheet = ScrollBarStyle(
            16,
            Brush(DrawMode.None),
            Brush(DrawMode.None),
            Brush(DrawMode.None, nil, nil, Vector2D(8)),
            Brush(DrawMode.None, nil, nil, Vector2D(8)),
            Brush(DrawMode.None, nil, nil, Vector2D(8)),
            Brush(DrawMode.None, nil, nil, Vector2D(8)),
            Brush(DrawMode.RoundedBox, nil, nil, Vector2D(), OutlineSettings(
                Quat(4), Color.BLACK, 1
            )),
            Brush(DrawMode.RoundedBox, nil, nil, Vector2D(), OutlineSettings(
                Quat(4), Color.BLACK, 1
            )),
            Brush(DrawMode.RoundedBox, nil, nil, Vector2D(), OutlineSettings(
                Quat(4), Color.BLACK, 1
            ))
        )
    end
    return self.__BarStyleSheet
end

-- Sets the orientation of the scroll box.
---@generic T
---@param self T
---@param iOrientation Orientation
---@return T
function ScrollBox:SetOrientation(iOrientation)
    self:CallBlueprintEvent("SetOrientation", iOrientation)

    return self
end

-- Sets a multiplier to apply when wheel scrolling.
---@generic T
---@param self T
---@param fMultiplier number
---@return T
function ScrollBox:SetWheelScrollMultiplier(fMultiplier)
    self:CallBlueprintEvent("SetWheelScrollMultiplier", fMultiplier)

    return self
end

-- Sets the scroll behavior when user focus is given to a child widget.
---@generic T
---@param self T
---@param iScrollBehavior ScrollWhenFocusChanges
---@return T
function ScrollBox:SetScrollWhenFocusChanges(iScrollBehavior)
    self:CallBlueprintEvent("SetScrollWhenFocusChanges", iScrollBehavior)

    return self
end

-- Sets the scroll bar visibility.
---@generic T
---@param self T
---@param iVisibility WGUIVisibility
---@return T
function ScrollBox:SetScrollBarVisibility(iVisibility)
    self:CallBlueprintEvent("SetScrollBarVisibility", iVisibility)

    return self
end

-- Sets the scrollbar thickness.
---@generic T
---@param self T
---@param tThickness Vector2D
---@return T
function ScrollBox:SetScrollBarThickness(tThickness)
    self:CallBlueprintEvent("SetScrollBarThickness", tThickness)

    return self
end

-- Sets the scrollbar padding.
---@generic T
---@param self T
---@param tPadding table
---@return T
function ScrollBox:SetScrollBarPadding(tPadding)
    self:CallBlueprintEvent("SetScrollBarPadding", tPadding)

    return self
end

-- Sets when mouse wheel events should be consumed.
---@generic T
---@param self T
---@param iConsumeMouseWheel ConsumeMouseWheel
---@return T
function ScrollBox:SetConsumeMouseWheel(iConsumeMouseWheel)
    self:CallBlueprintEvent("SetConsumeMouseWheel", iConsumeMouseWheel)

    return self
end

-- True to lerp smoothly when wheel scrolling along the scroll box.
---@generic T
---@param self T
---@param bShouldAnimateWheelScrolling boolean
---@return T
function ScrollBox:SetAnimateWheelScrolling(bShouldAnimateWheelScrolling)
    self:CallBlueprintEvent("SetAnimateWheelScrolling", bShouldAnimateWheelScrolling)

    return self
end

---@generic T
---@param self T
---@param bAlwaysShowScrollBar boolean
---@return T
function ScrollBox:SetAlwaysShowScrollBar(bAlwaysShowScrollBar)
    self:CallBlueprintEvent("SetAlwaysShowScrollBar", bAlwaysShowScrollBar)

    return self
end

---@generic T
---@param self T
---@param bAlwaysShowScrollbarTrack boolean
---@return T
function ScrollBox:SetAlwaysShowScrollbarTrack(bAlwaysShowScrollbarTrack)
    self:CallBlueprintEvent("SetAlwaysShowScrollbarTrack", bAlwaysShowScrollbarTrack)

    return self
end

-- Disable to stop scrollbars from activating inertial overscrolling.
---@generic T
---@param self T
---@param bAllowOverscroll boolean
---@return T
function ScrollBox:SetAllowOverscroll(bAllowOverscroll)
    self:CallBlueprintEvent("SetAllowOverscroll", bAllowOverscroll)

    return self
end

---@generic T
---@param self T
---@param bAllowRightClickDragScrolling boolean
---@return T
function ScrollBox:SetAllowRightClickDragScrolling(bAllowRightClickDragScrolling)
    self:CallBlueprintEvent("SetAllowRightClickDragScrolling", bAllowRightClickDragScrolling)

    return self
end

-- Scrolls the ScrollBox to the top instantly.
---@generic T
---@param self T
---@return T
function ScrollBox:ScrollToStart()
    self:CallBlueprintEvent("ScrollToStart")

    return self
end

-- Scrolls the ScrollBox to the bottom instantly.
---@generic T
---@param self T
---@return T
function ScrollBox:ScrollToEnd()
    self:CallBlueprintEvent("ScrollToEnd")

    return self
end

-- Instantly stops any inertial scrolling that is currently occurring.
---@generic T
---@param self T
---@return T
function ScrollBox:EndInertialScrolling()
    self:CallBlueprintEvent("EndInertialScrolling")

    return self
end