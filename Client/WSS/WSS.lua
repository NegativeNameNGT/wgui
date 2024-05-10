WSS = {}

-- Internal table to store the WSS data.
_WSS = {}

_WSS.StyleSheets = {
    Class = {},
    Tag = {},
    Dynamic = {}
}
_WSS.Fields = {}

-- Extends a table with the given fields.
---@param tFields table
function WSS.Extend(tFields)
    for sField, xFieldValue in pairs(tFields) do
        _WSS.Fields[sField] = xFieldValue
    end
end

-- Applies the WSS style tags of the widget.
---@param Widget BaseWidget
---@param tTags string[] | string
function WSS.SetWidgetTags(Widget, tTags)
    if type(tTags) ~= "table" then
        tTags = {tTags}
    end

    -- Remove the first character of each tag
    for i = 1, #tTags do
        tTags[i] = string.sub(tTags[i], 2)
    end

    Widget.WidgetTags = tTags
end

-- Gets the WSS style tags of the widget.
---@param oWidget BaseWidget
---@return string[]
function WSS.GetWidgetTags(oWidget)
    return oWidget.WidgetTags or {}
end

-- Applies the style of the specified widget.
---@param oWidget BaseWidget
function WSS.Apply(oWidget)
    -- Checks if the widget is valid
    if not oWidget or not oWidget:IsValid() then
        return
    end

    local tFields, tDynamicStyleSheet = _WSS.CollectFields(oWidget)

    if next(tFields) then
        _WSS.ApplyStyleSheet(oWidget, tFields)
    end

    if next(tDynamicStyleSheet) then
        _WSS.ApplyDynamicStyleSheet(oWidget, tDynamicStyleSheet)
    end
end

-- Applies the specified style sheet to the widget.
---@param oWidget BaseWidget
---@param tStyleSheet StylesheetFields | nil
function WSS.ApplyStylesheet(oWidget, tStyleSheet)
    _WSS.ApplyStyleSheet(oWidget, tStyleSheet)
end

Package.Require("WSSLoader.lua")
Package.Require("WSSParser.lua")
Package.Require("WSSFieldStoring.lua")
Package.Require("WSSDefaults.lua")
Package.Require("WSSApplier.lua")
Package.Require("WSSEvents.lua")
Package.Require("WSSBrush.lua")
Package.Require("WSSDynamicAttribute.lua")