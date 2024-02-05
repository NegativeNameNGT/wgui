-- Stores the widget's slot value to be set when the widget is added to a panel.
---@param oWidget BaseWidget
---@param sSlotFunction string
---@param xValue any
function StoreSlotValue(oWidget, sSlotFunction, xValue)
    local SlotData = oWidget.__UStyleSlotData or {}

    SlotData[sSlotFunction] = xValue

    oWidget.__UStyleSlotData = SlotData

    if oWidget[sSlotFunction] then
        oWidget[sSlotFunction](oWidget, xValue)
    end
end

-- Applies the stored slot values to the widget.
---@param oContent BaseWidget
function UStyle.ApplySlotProperties(oContent)
    local tFunctions = {
        SetPos = oContent.SetPos,
        SetSize = oContent.SetSize,
        SetAnchor = oContent.SetAnchor,
        SizeToContent = function(bPropertyValue) if bPropertyValue == true then oContent:SizeToContent() else oContent:SizeWithinBounds() end end,
        SetHAlign = oContent.SetHAlign,
        SetVAlign = oContent.SetVAlign,
    }

    if not oContent["__UStyleSlotData"] then
        return
    end

    for sFunctionName, xPropertyValue in pairs(oContent["__UStyleSlotData"]) do
        for sSlotFunction, fnFunction in pairs(tFunctions) do
            if sFunctionName == sSlotFunction then
                fnFunction(oContent, xPropertyValue)
            end
        end
    end
end

UStyle.AddWidgetFields(BaseWidget, {
    Color = {BaseWidget.SetColor, UStyleType.Color},
    Padding = {BaseWidget.SetPadding, UStyleType.Margin},
    Translation = {BaseWidget.SetTranslation, UStyleType.Vector2D},
    Angle = {BaseWidget.SetAngle, UStyleType.Number},
    Shear = {BaseWidget.SetShear, UStyleType.Vector2D},
    Scale = {BaseWidget.SetScale, UStyleType.Vector2D},
    Opacity = {BaseWidget.SetOpacity, UStyleType.Number},
    IsEnabled = {BaseWidget.SetIsEnabled, UStyleType.Boolean},
    Cursor = {BaseWidget.SetCursor, UStyleType.Cursor},
    IsVisible = {function(self, bIsVisible) self:SetVisibility(bIsVisible and WGUIVisibility.Visible or WGUIVisibility.Hidden) end, UStyleType.Boolean},
    IsHitTestable = {function(self, bIsHitTestable) self:SetVisibility(bIsHitTestable and WGUIVisibility.Visible or WGUIVisibility.NotHitTestableSelf) end, UStyleType.Boolean},

    -- Canvas Panel slot properties
    Pos = {"SetPos", UStyleType.Vector2D},
    Size = {"SetSize", UStyleType.Vector2D},
    Anchor = {"SetAnchor", UStyleType.Anchor},
    SizeToContent = {"SizeToContent", UStyleType.Boolean},
    HAlign = {"SetHAlign", UStyleType.HAlign},
    VAlign = {"SetVAlign", UStyleType.VAlign},
})

UStyle.AddWidgetFields(Image, {
    Src = {Image.SetBrushFromSrc, UStyleType.String},
})