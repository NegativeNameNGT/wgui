-- Base class for WGUI widgets
---@class BaseWidget : Entity
BaseWidget = Widget.Inherit("BaseWidget")

---@param self BaseWidget
local function OnWidgetDestroy(self)
    local iID = self:GetValue("__ID")
    if not iID then
        return
    end

    WGUI.Widgets[iID] = nil
end
BaseWidget.Subscribe("Destroy", OnWidgetDestroy)

-- Assigns and Binds a Blueprint Event Dispatcher
---@param sEventName string
---@param fnCallback function
---@overload fun(self: BaseWidget, sEventName: "MouseButtonDown", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "MouseButtonUp", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "MouseMove", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "MouseEnter", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "MouseLeave", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "MouseWheel", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "MouseDoubleClick", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "FocusReceived", fnCallback: fun(self: BaseWidget))
---@overload fun(self: BaseWidget, sEventName: "FocusLost", fnCallback: fun(self: BaseWidget))
---@overload fun(self: BaseWidget, sEventName: "DragDetected", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "Drop", fnCallback: fun(self: BaseWidget, PayloadID: integer, Tag: string))
---@overload fun(self: BaseWidget, sEventName: "DragCancelled", fnCallback: fun(self: BaseWidget, PayloadID: integer, Tag: string))
---@return function | nil
function BaseWidget:BindDispatcher(sEventName, fnCallback)
    return self:BindBlueprintEventDispatcher(sEventName, fnCallback)
end

-- Unbinds a Blueprint Event Dispatcher
---@param sEventName string
---@param fnCallback function | nil
function BaseWidget:UnbindDispatcher(sEventName, fnCallback)
    self:UnbindBlueprintEventDispatcher(sEventName, fnCallback)
end

-- Removes the widget from its parent panel.
function BaseWidget:RemoveFromParent()
    local oParent = self:GetParent()
    if (oParent) then
        oParent:RemoveChild(self)
    end
end

-- Invalidates the widget from the view of a layout caching widget that may own this widget. It will force the owning widget to redraw and cache children on the next paint pass.
function BaseWidget:InvalidateLayoutAndVolatility()
    self:CallBlueprintEvent("InvalidateLayoutAndVolatility")
end

-- Sets the forced volatility of the widget.
---@param bForce boolean
function BaseWidget:ForceVolatile(bForce)
    self:CallBlueprintEvent("ForceVolatile", bForce)
end

-- Forces a pre-pass. A pre-pass caches the desired size of the widget hierarchy owned by this widget.
function BaseWidget:ForceLayoutPrepass()
    self:CallBlueprintEvent("ForceLayoutPrepass")
end

-- Returns the parent panel of the widget.
---@return PanelWidget
function BaseWidget:GetParent()
    return self:GetValue("__Parent")
end

-- Returns a table containing all slot data.
---@return table
function BaseWidget:GetSlotData()
    return self:GetValue("__Slot", {})
end

-- Returns whether the widget is a child of the specified parent class.
---@param cParentClass PanelWidget
---@return boolean
function BaseWidget:IsChildOfParent(cParentClass)
    return self:GetParent():IsA(cParentClass)
end

-- Sets the padding of the widget, putting a larger gap between the widget border and it's root widget.
---@param Padding Margin | number
function BaseWidget:SetPadding(Padding)
    if type(Padding) == "number" then
        Padding = Margin(Padding)
    end

    self:CallBlueprintEvent("SetPadding", Padding)

    self:SetValue("__Padding", Padding)
end

-- Gets the padding of the widget.
---@return Margin
function BaseWidget:GetPadding()
    return self:GetValue("__Padding", Margin())
end

-- Sets the tooltip text of the widget.
---@param sText string
function BaseWidget:SetToolTipText(sText)
    self:CallBlueprintEvent("SetToolTipText", sText)

    self:SetValue("__ToolTipText", sText)
end

-- Gets the tooltip text of the widget.
---@return string
function BaseWidget:GetToolTipText()
    return self:GetValue("__ToolTipText", "")
end

-- Sets the tooltip widget of the widget.
---@param oWidget BaseWidget
function BaseWidget:SetToolTipWidget(oWidget)
    self:CallBlueprintEvent("SetToolTip", oWidget)

    self:SetValue("__ToolTipWidget", oWidget)
end

-- Gets the tooltip widget of the widget.
---@return BaseWidget
function BaseWidget:GetToolTipWidget()
    return self:GetValue("__ToolTipWidget")
end

-- Sets the render translation of the widget.
---@param tTranslation Vector2D
function BaseWidget:SetTranslation(tTranslation)
    self:CallBlueprintEvent("SetRenderTranslation", tTranslation)

    self:SetValue("__RenderTranslation", tTranslation)
end

-- Gets the render translation of the widget.
---@return Vector2D
function BaseWidget:GetTranslation()
    return self:GetValue("__RenderTranslation", Vector2D())
end

-- Sets the angle of the widget.
---@param fAngle number
function BaseWidget:SetAngle(fAngle)
    self:CallBlueprintEvent("SetAngle", fAngle)

    self:SetValue("__Angle", fAngle)
end

-- Gets the angle of the widget.
---@return number
function BaseWidget:GetAngle()
    return self:GetValue("__Angle", 0)
end

-- Sets the shear of the widget.
---@param tShear Vector2D
function BaseWidget:SetShear(tShear)
    self:CallBlueprintEvent("SetShear", tShear)

    self:SetValue("__Shear", tShear)
end

-- Gets the shear of the widget.
---@return Vector2D
function BaseWidget:GetShear()
    return self:GetValue("__Shear", Vector2D())
end

-- Sets the scale of the widget.
---@param tScale Vector2D
function BaseWidget:SetScale(tScale)
    self:CallBlueprintEvent("SetRenderScale", tScale)

    self:SetValue("__Scale", tScale)
end

-- Gets the scale of the widget.
---@return Vector2D
function BaseWidget:GetScale()
    return self:GetValue("__Scale", Vector2D(1))
end

-- Returns the desired size of the widget.
---@return Vector2D
function BaseWidget:GetDesiredSize()
    return self:CallBlueprintEvent("GetDesiredSize")
end

-- Sets the opacity of the widget.
---@param fOpacity number
function BaseWidget:SetOpacity(fOpacity)
    self:CallBlueprintEvent("SetRenderOpacity", fOpacity)

    self:SetValue("__Opacity", fOpacity)
end

-- Gets the opacity of the widget.
---@return number
function BaseWidget:GetOpacity()
    return self:GetValue("__Opacity", 1)
end

-- Sets the tint of the widget, this affects all children.
---@param tColor Color
function BaseWidget:SetColor(tColor)
    self:CallBlueprintEvent("SetColorAndOpacity", tColor)

    self:SetValue("__Color", tColor)
end

-- Gets the tint of the widget.
---@return Color
function BaseWidget:GetColor()
    return self:GetValue("__Color", Color.WHITE)
end

-- Sets the foreground color of the widget.
---@param tColor Color
---@param iColorRule ColorMode
function BaseWidget:SetForegroundColor(tColor, iColorRule)
    self:CallBlueprintEvent("SetForegroundColor", {
        SpecifiedColor = tColor,
        UseRule = iColorRule
    })

    self:SetValue("__ForegroundColor", tColor)
end

-- Sets the current enabled status of the widget.
---@param bEnabled boolean
function BaseWidget:SetIsEnabled(bEnabled)
    self:CallBlueprintEvent("SetIsEnabled", bEnabled)

    self:SetValue("__IsEnabled", bEnabled)
end

-- Gets the current enabled status of the widget.
---@return boolean
function BaseWidget:GetIsEnabled()
    return self:GetValue("__IsEnabled", true)
end

-- Sets the cursor to show over the widget.
---@param iCursorType CursorType
function BaseWidget:SetCursor(iCursorType)
    self:CallBlueprintEvent("SetCursor", iCursorType)

    self:SetValue("__Cursor", iCursorType)
end

-- Gets the cursor to show over the widget.
---@return CursorType
function BaseWidget:GetCursor()
    return self:GetValue("__Cursor", CursorType.Default)
end

-- Sets the clipping state of the widget.
---@param iClipping WidgetClipping
function BaseWidget:SetClipping(iClipping)
    self:CallBlueprintEvent("SetClipping", iClipping)

    self:SetValue("__Clipping", iClipping)
end

-- Gets the clipping state of the widget.
---@return WidgetClipping
function BaseWidget:GetClipping()
    return self:GetValue("__Clipping", WidgetClipping.Inherit)
end

-- Sets whether or not the widget will draw snapped to the nearest pixel.
---@param iPixelSnapping PixelSnapping
function BaseWidget:SetSnapToPixel(iPixelSnapping)
    self:SetBlueprintPropertyValue("PixelSnapping", iPixelSnapping)

    self:SetValue("__PixelSnapping", iPixelSnapping)
end

-- Gets whether or not the widget will draw snapped to the nearest pixel.
---@return PixelSnapping
function BaseWidget:GetSnapToPixel()
    return self:GetValue("__PixelSnapping", PixelSnapping.Inherit)
end

-- Sets the visibility of the widget.
---@param iVisibility WGUIVisibility
function BaseWidget:SetVisibility(iVisibility)
    self:CallBlueprintEvent("SetVisibility", iVisibility)

    self:SetValue("__Visibility", iVisibility)
end

-- Gets the visibility of the widget.
---@return WGUIVisibility
function BaseWidget:GetVisibility()
    return self:GetValue("__Visibility", WGUIVisibility.NotHitTestableSelf)
end

-- Returns true if the widget is Visible and HitTestable
---@return boolean
function BaseWidget:IsVisible()
    return self:GetVisibility() == (WGUIVisibility.Visible or WGUIVisibility.NotHitTestableAll or WGUIVisibility.NotHitTestableSelf)
end

-- Returns true if the widget is currently being hovered.
---@return boolean
function BaseWidget:IsHovered()
    return self:CallBlueprintEvent("IsHovered")
end

-- Sets the input key that will be used to drag the widget.
---@param sInputKey string
function BaseWidget:SetDragKey(sInputKey)
    self:SetBlueprintPropertyValue("DragKey", sInputKey)

    self:SetValue("__DragKey", sInputKey)
end

-- Gets the input key that will be used to drag the widget.
---@return string
function BaseWidget:GetDragKey()
    return self:GetValue("__DragKey", "")
end

-- Creates a new drag & drop operation. Should be called inside a OnDragDetected event.
---@param oDragVisual BaseWidget
---@param oPayload BaseWidget | nil
---@param sMetaData string | nil
---@param iPivot DragPivot | nil
---@param tOffset Vector2D | nil
function BaseWidget:CreateDragDropOperation(oDragVisual, oPayload, sMetaData, iPivot, tOffset)
    self:CallBlueprintEvent("CreateDragDropOperation", sMetaData or "", oPayload, oDragVisual, iPivot or DragPivot.MouseDown, tOffset or Vector2D())
end