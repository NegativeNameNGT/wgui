-- 'Base Widget' properties
WSS.Extend({
    IsVolatile = {"ForceVolatile", WSSParserType.Boolean},
    Padding = {"SetPadding", WSSParserType.Margin},
    ToolTipText = {"SetToolTipText", WSSParserType.String},
    Translation = {"SetTranslation", WSSParserType.Vector2D},
    Angle = {"SetAngle", WSSParserType.Number},
    Shear = {"SetShear", WSSParserType.Vector2D},
    Scale = {"SetScale", WSSParserType.Vector2D},
    Opacity = {"SetOpacity", WSSParserType.Number},
    Color = {"SetColor", WSSParserType.Color},
    IsEnabled = {"SetIsEnabled", WSSParserType.Boolean},
    Cursor = {"SetCursor", WSSParserType.Enum},
    Clipping = {"SetClipping", WSSParserType.Enum},
    PixelSnapping = {"SetPixelSnapping", WSSParserType.Enum},
    IsVisible = {function(self, bIsVisible) self:SetVisibility(bIsVisible and WGUIVisibility.Visible or WGUIVisibility.Hidden) end, WSSParserType.Boolean},
    IsHitTestable = {function(self, bIsHitTestable) self:SetVisibility(bIsHitTestable and WGUIVisibility.Visible or WGUIVisibility.NotHitTestableSelf) end, WSSParserType.Boolean},
    DragKey = {"SetDragKey", WSSParserType.String},
})

_WSS.BrushExtension = {
    DrawMode = {"SetDrawMode", WSSParserType.Enum},
    BackgroundColor = {"SetColor", WSSParserType.Color},
    BackgroundImage = {"SetSrc", WSSParserType.String},
    BackgroundImageSize = {"SetSrcSize", WSSParserType.Vector2D},
    CanCacheImage = {"SetCanCacheURLSrc", WSSParserType.Boolean},
    Margin = {"SetMargin", WSSParserType.Margin},
    Tiling = {"SetTiling", WSSParserType.Vector2D},
    OutlineColor = {"SetOutlineColor", WSSParserType.Color},
    OutlineCorner = {"SetOutlineCorners", WSSParserType.Quat},
    OutlineWidth = {"SetOutlineWidth", WSSParserType.Number},
    OutlineType = {"SetOutlineType", WSSParserType.Enum},
    OutlineUseAlpha = {"SetOutlineUseAlpha", WSSParserType.Boolean},
}
-- 'Brush' properties
WSS.Extend(_WSS.BrushExtension)

-- 'Canvas Panel' slot properties
WSS.Extend({
    Pos = {"SetPos", WSSParserType.Vector2D},
    ZPos = {"SetZPosition", WSSParserType.Number},
    Size = {"SetSize", WSSParserType.Vector2D},
    Alignment = {"SetAlignment", WSSParserType.Vector2D},
    Anchor = {"SetAnchor", WSSParserType.Enum},
    IsSizedToContent = {"SizeToContent", WSSParserType.Boolean}
})

-- Common slot properties
WSS.Extend({
    HAlign = {"SetHAlign", WSSParserType.Enum},
    VAlign = {"SetVAlign", WSSParserType.Enum},
})

-- 'Text' properties
WSS.Extend({
    Text = {"SetText", WSSParserType.String},
    Font = {"SetFont", WSSParserType.FontData, true},
})