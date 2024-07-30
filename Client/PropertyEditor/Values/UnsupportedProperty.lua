---@class UnsupportedProperty : PropertyValue
-- 'UnsupportedProperty' represents a property value that is not supported by the property editor.
UnsupportedProperty = PropertyValue.Inherit("UnsupportedProperty")

---@param sPropertyName string
---@param tPropertyData WidgetPropertyData
function UnsupportedProperty:Constructor(sPropertyName, tPropertyData)
    PropertyValue.Constructor(self)

    local oTextBlock = WGUI.Create(TextBlock, self)
    oTextBlock:SetText("Unsupported Type")
    oTextBlock:SetFont("Roboto", "Regular", 9)
    oTextBlock:SetVAlign(VAlign.Center)
end