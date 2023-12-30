---@class ScrollBox : PanelWidget
ScrollBox = PanelWidget.Inherit("ScrollBox")

function ScrollBox:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_ScrollBox")
    return self
end

-- Sets the style of the scroll box.
---@param oStyle ScrollBoxStyle
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
---@param oStyle ScrollBarStyle
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
---@param iOrientation Orientation
function ScrollBox:SetOrientation(iOrientation)
    self:CallBlueprintEvent("SetOrientation", iOrientation)
end

-- Sets a multiplier to apply when wheel scrolling.
---@param fMultiplier number
function ScrollBox:SetWheelScrollMultiplier(fMultiplier)
    self:CallBlueprintEvent("SetWheelScrollMultiplier", fMultiplier)
end

-- Sets the scroll behavior when user focus is given to a child widget.
---@param iScrollBehavior ScrollWhenFocusChanges
function ScrollBox:SetScrollWhenFocusChanges(iScrollBehavior)
    self:CallBlueprintEvent("SetScrollWhenFocusChanges", iScrollBehavior)
end

-- Sets the scroll bar visibility.
---@param iVisibility WGUIVisibility
function ScrollBox:SetScrollBarVisibility(iVisibility)
    self:CallBlueprintEvent("SetScrollBarVisibility", iVisibility)
end

-- Sets the scrollbar thickness.
---@param tThickness Vector2D
function ScrollBox:SetScrollBarThickness(tThickness)
    self:CallBlueprintEvent("SetScrollBarThickness", tThickness)
end

-- Sets the scrollbar padding.
---@param tPadding table
function ScrollBox:SetScrollBarPadding(tPadding)
    self:CallBlueprintEvent("SetScrollBarPadding", tPadding)
end

-- Sets when mouse wheel events should be consumed.
---@param iConsumeMouseWheel ConsumeMouseWheel
function ScrollBox:SetConsumeMouseWheel(iConsumeMouseWheel)
    self:CallBlueprintEvent("SetConsumeMouseWheel", iConsumeMouseWheel)
end

-- True to lerp smoothly when wheel scrolling along the scroll box.
---@param bShouldAnimateWheelScrolling boolean
function ScrollBox:SetAnimateWheelScrolling(bShouldAnimateWheelScrolling)
    self:CallBlueprintEvent("SetAnimateWheelScrolling", bShouldAnimateWheelScrolling)
end

---@param bAlwaysShowScrollBar boolean
function ScrollBox:SetAlwaysShowScrollBar(bAlwaysShowScrollBar)
    self:CallBlueprintEvent("SetAlwaysShowScrollBar", bAlwaysShowScrollBar)
end

---@param bAlwaysShowScrollbarTrack boolean
function ScrollBox:SetAlwaysShowScrollbarTrack(bAlwaysShowScrollbarTrack)
    self:CallBlueprintEvent("SetAlwaysShowScrollbarTrack", bAlwaysShowScrollbarTrack)
end

-- Disable to stop scrollbars from activating inertial overscrolling.
---@param bAllowOverscroll boolean
function ScrollBox:SetAllowOverscroll(bAllowOverscroll)
    self:CallBlueprintEvent("SetAllowOverscroll", bAllowOverscroll)
end

---@param bAllowRightClickDragScrolling boolean
function ScrollBox:SetAllowRightClickDragScrolling(bAllowRightClickDragScrolling)
    self:CallBlueprintEvent("SetAllowRightClickDragScrolling", bAllowRightClickDragScrolling)
end

-- Scrolls the ScrollBox to the top instantly.
function ScrollBox:ScrollToStart()
    self:CallBlueprintEvent("ScrollToStart")
end

-- Scrolls the ScrollBox to the bottom instantly.
function ScrollBox:ScrollToEnd()
    self:CallBlueprintEvent("ScrollToEnd")
end