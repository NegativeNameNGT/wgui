---@class Indicator : SizeBox
Indicator = SizeBox.Inherit("Indicator")

-- Static Brush to be used by all Indicators to draw the border.
local BorderBrush = Brush()
BorderBrush.SetDrawMode(DrawMode.RoundedBox)
BorderBrush.SetColor(Color(0.041, 0.041, 0.041, 0.8))
BorderBrush.SetOutlineSettings(OutlineSettings(Quat(4)))

function Indicator:Constructor()
    -- Calls the SizeBox constructor with a minimum desired size of 125x50.
    SizeBox.Constructor(self, Vector2D(125, 50))

    -- Creates a border inside the size box.
    local ContainerBorder = WGUI.Create(Border, self)
    ContainerBorder:SetBrush(BorderBrush)

    -- Creates a flex box inside the border. This flex box will be used by inherited classes to add their content.
    local ContentFlexBox = WGUI.Create(FlexBox, ContainerBorder, Orientation.Horizontal)
    ContentFlexBox:SetHAlign(HAlign.Center)
    ContentFlexBox:SetVAlign(VAlign.Center)

    -- Redirection of the panel functions to the ContentFlexBox.
    WGUI.RedirectPanelFunctions(self, ContentFlexBox)
    return self
end