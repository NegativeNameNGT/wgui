---@class Overlay : PanelWidget
Overlay = PanelWidget.Inherit("Overlay")

function Overlay:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_Overlay")
    return self
end