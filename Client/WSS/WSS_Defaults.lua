--- Defines the fields within a Stylesheet.
--- @class StylesheetFields
--- @field is_volatile? boolean | string @Whether the widget is volatile.
--- @field padding? Margin | string @The padding of the widget.
--- @field tooltip_text? string | string @The tooltip text of the widget.
--- @field translation? Vector2D | string @The translation of the widget.
--- @field angle? number | string @The angle of the widget.
--- @field shear? Vector2D | string @The shear of the widget.
--- @field scale? Vector2D | string @The scale of the widget.
--- @field opacity? number | string @The opacity of the widget.
--- @field color? Color | string @The color of the widget.
--- @field is_enabled? boolean | string @Whether the widget is enabled.
--- @field cursor? CursorType | string @The cursor of the widget.
--- @field clipping? WidgetClipping | string @The clipping of the widget.
--- @field pixel_snapping? PixelSnapping | string @The pixel snapping of the widget.
--- @field is_visible? boolean | string @Whether the widget is visible.
--- @field is_hit_testable? boolean | string @Whether the widget is hit testable.
--- @field drag_key? string | string @The drag key of the widget.
--- @field draw_mode? DrawMode | string @The draw mode of the widget.
--- @field background_color? Color | string @The background color of the widget.
--- @field background_image? string | string @The background image of the widget.
--- @field background_image_size? Vector2D | string @The background image size of the widget.
--- @field can_cache_image? boolean | string @Whether the image can be cached.
--- @field margin? Margin | string @The margin of the widget.
--- @field tiling? Vector2D | string @The tiling of the widget.
--- @field border_color? Color | string @The border color of the widget.
--- @field border_radius? Quat | string @The border corner of the widget.
--- @field border_width? number | string @The border width of the widget.
--- @field border_use_alpha? boolean | string @Whether the border uses alpha.
--- @field border_type? RoundingType | string @The border type of the widget.
--- @field pos? Vector2D | string @The position of the widget.
--- @field z_pos? number | string @The z position of the widget.
--- @field size? Vector2D | string @The size of the widget.
--- @field alignment? Vector2D | string @The alignment of the widget.
--- @field anchor? Anchor | string @The anchor of the widget.
--- @field sized_to_content? boolean | string @Whether the widget is sized to content.
--- @field h_align? HAlign | string @The horizontal alignment of the widget.
--- @field v_align? VAlign | string @The vertical alignment of the widget.
--- @field flex_size? table<number, SizeRule> | number | string @The flex size of the widget.
--- @field text? string | string @The text of the widget.
--- @field text_justify? TextJustify | string @The text justification of the widget.
--- @field text_case_mode? CaseMode | string @The text case mode of the widget.
--- @field text_shadow_offset? Vector2D | string @The text shadow offset of the widget.
--- @field text_shadow_color? Color | string @The text shadow color of the widget.
--- @field text_auto_wrap? boolean | string @Whether the text auto wraps.
--- @field font_family? string | string @The font family of the widget.
--- @field font_typeface? string  | string@The font typeface of the widget.
--- @field font_size? number | string @The font size of the widget.
--- @field percent? number | string @The percentage of the widget.
--- @field fill_color? Color | string @The fill color of the widget.
--- @field min_desired_width? number | string @The minimum desired width of the widget.
--- @field min_desired_height? number | string @The minimum desired height of the widget.
--- @field max_desired_width? number | string @The maximum desired width of the widget.
--- @field max_desired_height? number | string @The maximum desired height of the widget.

-- 'Base Widget' properties
WSS.Extend({
    ["is_volatile"] = {"ForceVolatile", WSSParserType.Boolean},
    ["padding"] = {"SetPadding", WSSParserType.Margin},
    ["tooltip_text"] = {"SetToolTipText", WSSParserType.String},
    ["translation"] = {"SetTranslation", WSSParserType.Vector2D},
    ["angle"] = {"SetAngle", WSSParserType.Number},
    ["shear"] = {"SetShear", WSSParserType.Vector2D},
    ["scale"] = {"SetScale", WSSParserType.Vector2D},
    ["opacity"] = {"SetOpacity", WSSParserType.Number},
    ["color"] = {"SetColor", WSSParserType.Color},
    ["is_enabled"] = {"SetIsEnabled", WSSParserType.Boolean},
    ["cursor"] = {"SetCursor", WSSParserType.Enum},
    ["clipping"] = {"SetClipping", WSSParserType.Enum},
    ["pixel_snapping"] = {"SetPixelSnapping", WSSParserType.Enum},
    ["is_visible"] = {function(self, bIsVisible) self:SetVisibility(bIsVisible and WGUIVisibility.Visible or WGUIVisibility.Hidden) end, WSSParserType.Boolean},
    ["is_hit_testable"] = {function(self, bIsHitTestable) self:SetVisibility(bIsHitTestable and WGUIVisibility.Visible or WGUIVisibility.NotHitTestableSelf) end, WSSParserType.Boolean},
    ["drag_key"] = {"SetDragKey", WSSParserType.String},
})

_WSS.BrushExtension = {
    ["draw_mode"] = {"SetDrawMode", WSSParserType.Enum},
    ["background_color"] = {"SetColor", WSSParserType.Color},
    ["background_image"] = {"SetSrc", WSSParserType.String},
    ["background_image_size"] = {"SetSrcSize", WSSParserType.Vector2D},
    ["can_cache_image"] = {"SetCanCacheURLSrc", WSSParserType.Boolean},
    ["margin"] = {"SetMargin", WSSParserType.Margin},
    ["tiling"] = {"SetTiling", WSSParserType.Vector2D},
    ["border_color"] = {"SetOutlineColor", WSSParserType.Color},
    ["border_radius"] = {"SetOutlineRadius", WSSParserType.Quat},
    ["border_width"] = {"SetOutlineWidth", WSSParserType.Number},
    ["border_type"] = {"SetOutlineType", WSSParserType.Enum},
    ["border_use_alpha"] = {"SetOutlineUseAlpha", WSSParserType.Boolean},
}
-- 'Brush' properties
WSS.Extend(_WSS.BrushExtension)

-- 'Canvas Panel' slot properties
WSS.Extend({
    ["pos"] = {"SetPos", WSSParserType.Vector2D},
    ["z_pos"] = {"SetZPosition", WSSParserType.Number},
    ["size"] = {"SetSize", WSSParserType.Vector2D},
    ["alignment"] = {"SetAlignment", WSSParserType.Vector2D},
    ["anchor"] = {"SetAnchor", WSSParserType.Enum},
    ["sized_to_content"] = {"SizeToContent", WSSParserType.Boolean}
})

-- Common slot properties
WSS.Extend({
    ["h_align"] = {"SetHAlign", WSSParserType.Enum},
    ["v_align"] = {"SetVAlign", WSSParserType.Enum},
    ["flex_size"] = {"SetSize", WSSParserType.FlexSize, true},
})

-- 'Text' properties
WSS.Extend({
    ["text"] = {"SetText", WSSParserType.String},
    ["text_justify"] = {"SetJustification", WSSParserType.String},
    ["text_shadow_offset"] = {"SetShadowSettings", WSSParserType.String, nil, IsBatchable = true},
    ["text_shadow_color"] = {"SetShadowSettings", WSSParserType.Color, nil, IsBatchable = true},
    ["text_auto_wrap"] = {"SetAutoWrapText", WSSParserType.Boolean},
    ["text_case_mode"] = {"SetCaseMode", WSSParserType.Enum},

    -- Font properties
    ["font_family"] = {"SetFont", WSSParserType.String, nil, IsBatchable = true},
    ["font_typeface"] = {"SetFont", WSSParserType.String, nil, IsBatchable = true},
    ["font_size"] = {"SetFont", WSSParserType.Number, nil, IsBatchable = true},
})

-- 'Progress Bar' properties
WSS.Extend({
    ["percent"] = {"SetPercent", WSSParserType.Number},
    ["fill_color"] = {"SetFillColor", WSSParserType.Color},
})

-- 'Size Box' properties
WSS.Extend({
    ["min_desired_width"] = {"SetMinDesiredWidth", WSSParserType.Number},
    ["min_desired_height"] = {"SetMinDesiredHeight", WSSParserType.Number},
    ["max_desired_width"] = {"SetMaxDesiredWidth", WSSParserType.Number},
    ["max_desired_height"] = {"SetMaxDesiredHeight", WSSParserType.Number},
})

WSS.AddWidgetClassProperty(BaseWidget, "is_enabled", BaseWidget.SetIsEnabled, BaseWidget.GetIsEnabled, WidgetPropertyType.Boolean)