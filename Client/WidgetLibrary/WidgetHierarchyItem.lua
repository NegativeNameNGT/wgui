---@class WidgetHierarchyItem : FlexBox
-- 'WidgetHierarchyItem' is a class that represents a widget in the widget hierarchy
WidgetHierarchyItem = FlexBox.Inherit("WidgetHierarchyItem")

function WidgetHierarchyItem:Constructor()
    FlexBox.Constructor(self, Orientation.Horizontal)

    self.CaretImage = WGUI.Create(Image, self)
                                :SetBrushFromSrc("/WGui/Textures/T_Caret", Vector2D(16, 16))

    self.WidgetIconImage = WGUI.Create(Image, self)
                                :SetPadding(Margin(0, 0, 3, 0))

    self.WidgetNameBlock = WGUI.Create(TextBlock, self)
                                :SetFont("Roboto", "Regular", 10)
end

-- Calculates the padding that should be applied to the hierarchy item.
---@param oAssociatedWidget BaseWidget
local function CalculatePadding(oAssociatedWidget)
    local iPadding = 0
    local oParent = oAssociatedWidget:GetParent()

    while oParent ~= nil do
        iPadding = iPadding + 10
        oParent = oParent:GetParent()
    end

    return iPadding
end

-- Updates the widget data.
---@param oWidget BaseWidget | PanelWidget
function WidgetHierarchyItem:Update(oWidget)
    -- Display the widget class name
    local sClassName = tostring(oWidget:GetClass())
    local sFriendlyClassName = string.sub(sClassName, 1, #sClassName - 6)

    self.WidgetNameBlock:SetText(sFriendlyClassName)

    -- Update the left padding
    local iCalculatedPadding = CalculatePadding(oWidget)

    self:SetPadding(Margin(iCalculatedPadding, 0, 0, 0))

    -- Display the caret if the widget has children
    if oWidget:IsA(PanelWidget) and #oWidget:GetAllChildren() > 0 then
        self.CaretImage:SetVisibility(WGUIVisibility.Visible)
    else
        self.CaretImage:SetVisibility(WGUIVisibility.Hidden)
    end

    -- Update the widget icon
    local sWidgetIcon = oWidget.Icon or "package://wgui/Client/Textures/Icons/Widget.png"
    self.WidgetIconImage:SetBrushFromSrc(sWidgetIcon, Vector2D(16, 16))

    self:SetExpanded(false)
    self:SetSelected(false)
end

function WidgetHierarchyItem:SetExpanded(bIsExpanded)
    if bIsExpanded then
        self.CaretImage:SetAngle(90)
    else
        self.CaretImage:SetAngle(0)
    end
end

-- Updates the selected state of the widget.
---@param bIsSelected boolean
function WidgetHierarchyItem:SetSelected(bIsSelected)
    if bIsSelected then
        self.WidgetNameBlock:SetColor(Color.RED)
    else
        self.WidgetNameBlock:SetColor(Color.WHITE)
    end
end