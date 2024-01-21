-- The canvas panel is a designer friendly panel that allows widgets to be laid out at arbitrary locations, anchored and z-ordered with other children of the canvas.
---@class CanvasPanel : PanelWidget
CanvasPanel = PanelWidget.Inherit("CanvasPanel", {
    Slot = CanvasPanelSlot
})

function CanvasPanel:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_CanvasPanel")

    self:AddToViewport()
    return self
end