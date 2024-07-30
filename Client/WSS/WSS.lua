WSS = {}

-- Internal table to store the WSS data.
_WSS = {}

_WSS.StyleSheets = {
    Class = {},
    Tag = {},
    Dynamic = {}
}
_WSS.Fields = {}
_WSS.PropertyFields = {}
_WSS.InstanceProperties = {}

-- Extends a table with the given fields.
---@param tFields table
function WSS.Extend(tFields)
    for sField, xFieldValue in pairs(tFields) do
        _WSS.Fields[sField] = xFieldValue
    end
end

---@class WidgetPropertyData
---@field Setter function
---@field Getter function
---@field Type WidgetPropertyType
---@field Category string

-- Adds a property field to a widget class.
---@param cWidgetClass BaseWidget @The widget class to add the property to.
---@param sPropertyName string @The name of the property.
---@param fnSetter function @The setter function of the property.
---@param fnGetter function @The getter function of the property.
---@param iPropertyType WidgetPropertyType @The type of the property.
---@param sCategory? string @The category of the property. Used for grouping in the property editor.
function WSS.AddWidgetClassProperty(cWidgetClass, sPropertyName, fnSetter, fnGetter, iPropertyType, sCategory)
    if type(sPropertyName) ~= "string" then
        assert(false, "[WSS] Property name must be a string.")
    end

    if type(fnSetter) ~= "function" then
        assert(false, "[WSS] Setter must be a function.")
    end

    if type(fnGetter) ~= "function" then
        assert(false, "[WSS] Getter must be a function.")
    end

    if type(cWidgetClass) ~= "table" then
        assert(false, "[WSS] Widget class is invalid.")
    end

    _WSS.PropertyFields[sPropertyName] = {
        Class = cWidgetClass,
        Setter = fnSetter,
        Getter = fnGetter,
        Type = iPropertyType,
        Category = sCategory or "Default"
    }
end

---@param cWidgetClass BaseWidget
function WSS.GetWidgetClassProperties(cWidgetClass)
    local tProperties = {}

    for sProperty, tPropertyData in pairs(_WSS.PropertyFields) do
        if cWidgetClass == tPropertyData.Class then
            tProperties[sProperty] = {
                Setter = tPropertyData.Setter,
                Getter = tPropertyData.Getter,
                Type = tPropertyData.Type,
                Category = tPropertyData.Category
            }
        end
    end

    return tProperties
end

-- Sets a property value of the widget.
---@param oWidget BaseWidget
---@param sPropertyName string
---@param ... any
---@return boolean
function WSS.SetWidgetPropertyValue(oWidget, sPropertyName, ...)
    if not oWidget or not oWidget:IsValid() then
        return false
    end

    if not _WSS.PropertyFields[sPropertyName] then
        assert(false, "[WSS] Property '" .. sPropertyName .. "' does not exist.")
        return false
    end

    if not _WSS.InstanceProperties[oWidget] then
        _WSS.InstanceProperties[oWidget] = {}
    end

    _WSS.InstanceProperties[oWidget][sPropertyName] = ...

    Events.Call("WSS::OnPropertyValueChange", oWidget, sPropertyName, ...)

    return true
end

-- Gets a property value of the widget.
---@param oWidget BaseWidget
---@param sPropertyName string
---@param xFallbackValue? any
---@return any
function WSS.GetWidgetPropertyValue(oWidget, sPropertyName, xFallbackValue)
    if not oWidget or not oWidget:IsValid() then
        return
    end

    if not _WSS.PropertyFields[sPropertyName] then
        return xFallbackValue
    end

    if not _WSS.InstanceProperties[oWidget] then
        return xFallbackValue
    end

    return _WSS.InstanceProperties[oWidget][sPropertyName]
end

---@param oWidget BaseWidget
---@return table<string, WidgetPropertyData>
function WSS.GetWidgetProperties(oWidget)
    local tAllProperties = {}
    local cClass = oWidget:GetClass()

    while cClass do
        local tProperties = WSS.GetWidgetClassProperties(cClass)
        if next(tProperties) then
            for sPropertyName, tPropertyData in pairs(tProperties) do
                tAllProperties[sPropertyName] = tPropertyData
            end
        end
        cClass = cClass:GetParentClass()
    end

    return tAllProperties
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

Package.Require("WSS_Loader.lua")
Package.Require("WSS_Parser.lua")
Package.Require("WSS_FieldStoring.lua")
Package.Require("WSS_Defaults.lua")
Package.Require("WSS_Applier.lua")
Package.Require("WSS_Events.lua")
Package.Require("WSS_Brush.lua")
Package.Require("WSS_DynamicAttributes.lua")