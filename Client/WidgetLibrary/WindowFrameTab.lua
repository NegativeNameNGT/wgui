---@class WindowFrameTab : SizeBox
---WindowFrameTab is a widget that represents a tab in a window frame.
WindowFrameTab = SizeBox.Inherit("WindowFrameTab")

ExtendStylesheets(
    "#WindowFrameTab_Background",
    {
        draw_mode = DrawMode.RoundedBox,
        background_color = Color(0.0176, 0.0176, 0.0176, 1),
        border_width = 0,
        border_corner = Quat(5, 5, 0, 1),
        border_color = Color(0.0176, 0.0176, 0.0176, 1),
    },

    "#WindowFrameTab_Text",
    {
        font_size = 10,
        color = Color(0.215, 0.215, 0.215, 1),
        h_align = HAlign.Left,
        v_align = VAlign.Center,
        padding = Margin(5, 0, 5, 0)
    }
)

---@param sTabName string
---@param oWindowFrame WindowFrame
function WindowFrameTab:Constructor(sTabName, oWindowFrame)
    SizeBox.Constructor(self, Vector2D(75, 25))

    -- Background
    local oBackgroundBorder = WGUI.CreateWithTags(Border, "#WindowFrameTab_Background", self)

    -- Tab Name
    self.TabName = WGUI.CreateWithTags(TextBlock, "#WindowFrameTab_Text", oBackgroundBorder)
    self.TabName:SetText(sTabName)

    -- Events
    oBackgroundBorder:BindDispatcher("MouseButtonDown", function (_, tPointerEvent)
        if not tPointerEvent.Key == "Left Mouse Button" then
            return
        end
        oWindowFrame:SetActiveTab(sTabName)
    end)
end