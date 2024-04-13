-- 'Base Widget' properties
WSS.Extend({
    ["is-volatile"] = {"ForceVolatile", WSSParserType.Boolean},
    ["padding"] = {"SetPadding", WSSParserType.Margin},
    ["tooltip-text"] = {"SetToolTipText", WSSParserType.String},
    ["translation"] = {"SetTranslation", WSSParserType.Vector2D},
    ["angle"] = {"SetAngle", WSSParserType.Number},
    ["shear"] = {"SetShear", WSSParserType.Vector2D},
    ["scale"] = {"SetScale", WSSParserType.Vector2D},
    ["opacity"] = {"SetOpacity", WSSParserType.Number},
    ["color"] = {"SetColor", WSSParserType.Color},
    ["is-enabled"] = {"SetIsEnabled", WSSParserType.Boolean},
    ["cursor"] = {"SetCursor", WSSParserType.Enum},
    ["clipping"] = {"SetClipping", WSSParserType.Enum},
    ["pixel-snapping"] = {"SetPixelSnapping", WSSParserType.Enum},
    ["is-visible"] = {function(self, bIsVisible) self:SetVisibility(bIsVisible and WGUIVisibility.Visible or WGUIVisibility.Hidden) end, WSSParserType.Boolean},
    ["is-hit-testable"] = {function(self, bIsHitTestable) self:SetVisibility(bIsHitTestable and WGUIVisibility.Visible or WGUIVisibility.NotHitTestableSelf) end, WSSParserType.Boolean},
    ["drag-key"] = {"SetDragKey", WSSParserType.String},
})

_WSS.BrushExtension = {
    ["draw-mode"] = {"SetDrawMode", WSSParserType.Enum},
    ["background-color"] = {"SetColor", WSSParserType.Color},
    ["background-image"] = {"SetSrc", WSSParserType.String},
    ["background-image-size"] = {"SetSrcSize", WSSParserType.Vector2D},
    ["can-cache-image"] = {"SetCanCacheURLSrc", WSSParserType.Boolean},
    ["margin"] = {"SetMargin", WSSParserType.Margin},
    ["tiling"] = {"SetTiling", WSSParserType.Vector2D},
    ["border-color"] = {"SetOutlineColor", WSSParserType.Color},
    ["border-corner"] = {"SetOutlineCorners", WSSParserType.Quat},
    ["border-width"] = {"SetOutlineWidth", WSSParserType.Number},
    ["border-type"] = {"SetOutlineType", WSSParserType.Enum},
    ["border-use-alpha"] = {"SetOutlineUseAlpha", WSSParserType.Boolean},
}
-- 'Brush' properties
WSS.Extend(_WSS.BrushExtension)

-- 'Canvas Panel' slot properties
WSS.Extend({
    ["pos"] = {"SetPos", WSSParserType.Vector2D},
    ["z-pos"] = {"SetZPosition", WSSParserType.Number},
    ["size"] = {"SetSize", WSSParserType.Vector2D},
    ["alignment"] = {"SetAlignment", WSSParserType.Vector2D},
    ["anchor"] = {"SetAnchor", WSSParserType.Enum},
    ["sized-to-content"] = {"SizeToContent", WSSParserType.Boolean}
})

-- Common slot properties
WSS.Extend({
    ["h-align"] = {"SetHAlign", WSSParserType.Enum},
    ["v-align"] = {"SetVAlign", WSSParserType.Enum},
    ["flex-size"] = {"SetSize", WSSParserType.FlexSize, true},
})

-- 'Text' properties
WSS.Extend({
    ["text"] = {"SetText", WSSParserType.String},

    -- Font properties
    ["font-family"] = {"SetFont", WSSParserType.String, nil, IsBatchable = true},
    ["font-typeface"] = {"SetFont", WSSParserType.String, nil, IsBatchable = true},
    ["font-size"] = {"SetFont", WSSParserType.Number, nil, IsBatchable = true},
})

-- 'Progress Bar' properties
WSS.Extend({
    ["percent"] = {"SetPercent", WSSParserType.Number},
    ["fill-color"] = {"SetFillColor", WSSParserType.Color},
})