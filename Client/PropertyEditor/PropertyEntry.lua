---@class PropertyEntry : ExpandableArea
-- 'PropertyEntry' represents a single widget property in the property editor.
PropertyEntry = ExpandableArea.Inherit("PropertyEntry")

---@param sPropertyName string
---@param tPropertyData WidgetPropertyData
---@param oPropertyEditor PropertyEditor
function PropertyEntry:Constructor(sPropertyName, tPropertyData, oPropertyEditor)
    ExpandableArea.Constructor(self, false)

    -- Header panel
    local oHeaderPanel = WGUI.Create(Overlay, nil, Orientation.Horizontal)

    -- Header title border
    local oHeaderTitleBorder = WGUI.Create(Border, oHeaderPanel)
    oHeaderTitleBorder:SetVAlign(VAlign.Center)
    oHeaderTitleBorder:SetBrush(Brush(DrawMode.None))

    -- Header title
    local oHeaderTitle = WGUI.Create(TextBlock, oHeaderTitleBorder)
    oHeaderTitle:SetVAlign(VAlign.Center)
    oHeaderTitle:SetFont("Roboto", "Regular", 10)
    oHeaderTitle:SetColor(Color(0.57, 0.57, 0.57, 1))
    oHeaderTitle:SetText(sPropertyName or "Unknown Property Name")
    oHeaderTitle:SetOverflowMode(OverflowMode.Ellipsis)
    oHeaderTitle:SetClipping(WidgetClipping.ClipToBounds)

    self:SetHeaderContent(oHeaderPanel)

    -- Store the property data
    self.PropertyData = tPropertyData

    -- Store the header panel
    self.HeaderPanel = oHeaderPanel

    -- Store the header title border
    self.HeaderTitleBorder = oHeaderTitleBorder

    -- Store the header title
    self.HeaderTitle = oHeaderTitle

    -- Store the property editor
    self.PropertyEditor = oPropertyEditor

    -- Generate the value widget
    self:GenerateEntryValueWidget()
end

local tTypeWidgets = {
    [WidgetPropertyType.Unsupported] = UnsupportedProperty,
    [WidgetPropertyType.Boolean] = PropertyBoolean
}

-- Generates the value widget for the property entry.
function PropertyEntry:GenerateEntryValueWidget()
    if self:GetBodyContent() then
        self:DestroyBodyContent()
    end

    local iPropertyType = self.PropertyData.Type

    if not tTypeWidgets[iPropertyType] then
        iPropertyType = WidgetPropertyType.Unsupported
    end

    local cValueWidgetClass = tTypeWidgets[iPropertyType]

    local oValueWidget = nil

    if cValueWidgetClass then
        oValueWidget = WGUI.Create(cValueWidgetClass, self.HeaderPanel)
        oValueWidget:SetVAlign(VAlign.Center)

        self:SetValue("__ValueWidget", oValueWidget)

        -- Refresh the value
        self:RefreshValue()
        return
    end
end

function PropertyEntry:RefreshValue()
    local oValueWidget = self:GetValueWidget()

    if not oValueWidget or not oValueWidget:IsValid() then
        return
    end

    local fnGetter = self.PropertyData.Getter

    if not fnGetter then
        return
    end
    
    local oWidget = self.PropertyEditor:GetWidget()

    if not oWidget or not oWidget:IsValid() then
        print("[PropertyEntry] Widget is invalid.")
        return
    end

    local xValue = fnGetter(oWidget)
    oValueWidget:SetInternalValue(xValue)

    print("[PropertyEntry] Refreshed value.")
    print("[PropertyEntry] Value: " .. tostring(xValue))
end

-- Gets the value widget of the property entry. Returns nil if the value widget is not found.
---@return PropertyValue
function PropertyEntry:GetValueWidget()
    return self:GetValue("__ValueWidget")
end