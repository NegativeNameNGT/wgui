-- Allows widgets to be stacked on top of each other, uses simple flow layout for content on each layer.
---@class Overlay : PanelWidget
Overlay = PanelWidget.Inherit("Overlay", {
    Slot = OverlaySlot
})

function Overlay:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_Overlay")
    return self
end