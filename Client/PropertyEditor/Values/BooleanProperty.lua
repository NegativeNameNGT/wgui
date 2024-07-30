---@class PropertyBoolean : PropertyValue
-- 'PropertyBoolean' represents a boolean property value in the property editor.
PropertyBoolean = PropertyValue.Inherit("PropertyBoolean")

---@param sPropertyName string
---@param tPropertyData WidgetPropertyData
function PropertyBoolean:Constructor(sPropertyName, tPropertyData)
    PropertyValue.Constructor(self)

    self.CheckBox = WGUI.Create(CheckBox, self)
end

---@param bValue boolean
function PropertyBoolean:SetInternalValue(bValue)
    self.CheckBox:SetChecked(bValue)
end