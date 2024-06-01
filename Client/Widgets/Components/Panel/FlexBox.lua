---@class FlexBox : PanelWidget
FlexBox = PanelWidget.Inherit("FlexBox", {
    Slot = FlexBoxSlot
})

FlexBox.Horizontal = 0
FlexBox.Vertical = 1

function FlexBox:Constructor(iOrientation)
    if (iOrientation or 0) == 0 then
        self.Super:Constructor("wgui-assets::WBP_WGUI_HorizontalBox")
        self.Icon = "package://wgui/Client/Textures/Icons/HorizontalBox.png"
    else
        self.Super:Constructor("wgui-assets::WBP_WGUI_VerticalBox")
        self.Icon = "package://wgui/Client/Textures/Icons/VerticalBox.png"
    end
    return self
end