---@class WSS_Indicator : SizeBox
WSS_Indicator = SizeBox.Inherit("WSS_Indicator")

function WSS_Indicator:Constructor()
    -- Calls the SizeBox constructor with a minimum desired size of 125x50.
    SizeBox.Constructor(self, Vector2D(125, 50))

    -- Creates a border inside the size box.
    local ContainerBorder = WGUI.CreateWithTags(Border, "#Indicator-Border", self)

    -- Creates a flex box inside the border. This flex box will be used by inherited classes to add their content.
    local ContentFlexBox = WGUI.CreateWithTags(FlexBox, "#Indicator-Content", ContainerBorder, Orientation.Horizontal)

    WGUI.RedirectPanelFunctions(self, ContentFlexBox)
    return self
end