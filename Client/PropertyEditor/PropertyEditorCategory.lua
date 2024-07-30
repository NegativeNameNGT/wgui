---@class PropertyEditorCategory : ExpandableArea
-- 'WidgetPropertyCategory' represents a category of properties in the property editor.
PropertyEditorCategory = ExpandableArea.Inherit("PropertyCategory")

---@param sCategoryName string
function PropertyEditorCategory:Constructor(sCategoryName)
    ExpandableArea.Constructor(self)

    -- Border color
    self:SetBorderColor(Color(0.028, 0.028, 0.028, 1))

    -- Header title
    local oHeaderTitle = WGUI.Create(TextBlock)
    oHeaderTitle:SetFont("Roboto", "Bold", 10)
    oHeaderTitle:SetColor(Color(0.57, 0.57, 0.57, 1))
    oHeaderTitle:SetText(sCategoryName or "Default")
    oHeaderTitle:SetPadding(Margin(0, 3))

    -- Set the header content
    self:SetHeaderContent(oHeaderTitle)

    -- Body content
    self.BodyContent = WGUI.Create(FlexBox, nil, Orientation.Vertical)

    -- Set the body content
    self:SetBodyContent(self.BodyContent)

    -- Expand the category by default
    self:SetIsExpanded(true)
end