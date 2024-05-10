---@class WindowFrame : Border
---WindowFrame is a widget that provides a frame for a window (a title bar, a close button, and a content area).
WindowFrame = Border.Inherit("WindowFrame")

ExtendStylesheets(
    ".WindowFrame",
    {
        draw_mode = DrawMode.RoundedBox,
        background_color = Color(0.0075, 0.0075, 0.0075, 1),
        border_color = Color(0.005, 0.005, 0.005, 1),
        border_width = 2
    },

    "#WindowFrame_SecondaryBackground",
    {
        draw_mode = DrawMode.RoundedBox,
        padding = Margin(2.5),
        background_color = Color(0.0075, 0.0075, 0.0075, 1),
        border_color = Color(0.033, 0.033, 0.033, 1),
        border_width = 2
    },

    "#WindowFrame_NoTabText",
    {
        h_align = HAlign.Center, v_align = VAlign.Center,
        font_size = 12,
        text = "Use AddTab() to add a tab to this window.",
        text_auto_wrap = true
    },

    "#WindowFrame_ContentBackground",
    {
        padding = Margin(3, 0, 3, 3),
        background_color = Color(0.0176, 0.0176, 0.0176, 1),
        flex_size = {1, SizeRule.Fill}
    }
)

function WindowFrame:Constructor()
    Border.Constructor(self)

    -- Secondary Background
    local oSecondaryBackground = WGUI.CreateWithTags(Border, "#WindowFrame_SecondaryBackground", self)

    -- Widget Switcher
    self.WidgetSwitcher = WGUI.Create(WidgetSwitcher, oSecondaryBackground)
    WGUI.CreateWithTags(TextBlock, "#WindowFrame_NoTabText", self.WidgetSwitcher)

    -- Container
    local oFlexBox = WGUI.Create(FlexBox, self.WidgetSwitcher, Orientation.Vertical)
    oFlexBox:SetPadding(Margin(2))

    self.TabContainer = WGUI.Create(ScrollBox, oFlexBox)
    self.TabContainer:SetOrientation(Orientation.Horizontal)
    self.TabContainer:SetBoxStyleSheet(ScrollBoxStyle(0, Brush(DrawMode.None), Brush(DrawMode.None), Brush(DrawMode.None), Brush(DrawMode.None), Margin(), Margin()))
    self.TabContainer:SetScrollBarVisibility(WGUIVisibility.Collapsed)
    self.TabContainer:SetPadding(Margin(3, 3, 3, 0))

    self.TabContainer:BindDispatcher("MouseButtonDown", function (_, tPointerEvent)
        self:OnTitleBarPressed(tPointerEvent)
    end)

    local oContentBackground = WGUI.CreateWithTags(Border, "#WindowFrame_ContentBackground", oFlexBox)
end

Input.Subscribe("MouseUp", function (sKeyName)
    if not sKeyName == "LeftMouseButton" then
        return
    end

    for _, oWindowFrame in ipairs(WindowFrame.GetAll()) do
        oWindowFrame:OnTitleBarReleased()
    end
end)

---@param tPointerEvent PointerEvent
function WindowFrame:OnTitleBarPressed(tPointerEvent)
    if tPointerEvent.Key ~= "Left Mouse Button" then
        return
    end

    self:SetValue("__ClickLocDiff", Viewport.GetMousePosition() - self:GetPos())


    if self.LocationTickUpdate then
        self:OnTitleBarReleased()
    end

    self.LocationTickUpdate = Client.Subscribe("Tick", function ()
        self:UpdateLocation()
    end)
end

function WindowFrame:OnTitleBarReleased()
    if self.LocationTickUpdate then
        Client.Unsubscribe("Tick", self.LocationTickUpdate)
        self.LocationTickUpdate = nil
    end
end

function WindowFrame:UpdateLocation()
    local tClickLocDifference = self:GetValue("__ClickLocDiff", Vector2D())

    local tMousePos = Viewport.GetMousePosition()

    local oParent = self:GetParent()
    if oParent then
        self:SetPos((tMousePos - tClickLocDifference))
    end
end

-- Adds a new tab to the window frame.
---@param sTabName string
function WindowFrame:AddTab(sTabName)
    if not self.WidgetSwitcher or not self.TabContainer then
        return
    end

    self.WidgetSwitcher:SetActiveWidgetIndex(2)
    local oTab = WGUI.Create(WindowFrameTab, self.TabContainer, sTabName or "New Tab")
    oTab:SetPadding(Margin(0, 0, 5, 0))
end