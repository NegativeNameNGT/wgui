---@class Indicator : SizeBox
Indicator = SizeBox.Inherit("Indicator")

function Indicator:Constructor()
    SizeBox.Constructor(self, Vector2D(125, 50))

    local ContainerBorder = WGUI.Create(Border, self)
    ContainerBorder:SetBrush(Brush(
        DrawMode.RoundedBox,
        Color(0.041, 0.041, 0.041, 0.8),
        nil,
        nil,
        OutlineSettings(Quat(4)))
    )

    local ContentFlexBox = WGUI.Create(FlexBox, ContainerBorder, Orientation.Horizontal)
    ContentFlexBox:SetHAlign(HAlign.Center)
    ContentFlexBox:SetVAlign(VAlign.Center)

    -- Gives the ability to redirect panel functions (AddChild, RemoveChild...) to the content flex box.
    WGUI.RedirectPanelFunctions(self, ContentFlexBox)
    return self
end