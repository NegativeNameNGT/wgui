---@class MouseOutlineFrame : CanvasPanel
---MouseOutlineFrame widget adds a mouse outline to the widget hovered by the mouse.
MouseOutlineFrame = CanvasPanel.Inherit("MouseOutlineFrame")

Client.Subscribe("Tick", function ()
    ---@type MouseOutlineFrame[]
    local tFrames = MouseOutlineFrame.GetPairs()
    for _, oMouseOutlineFrame in pairs(tFrames) do
        oMouseOutlineFrame:OnTick()
    end
end)

function MouseOutlineFrame:Constructor()
    CanvasPanel.Constructor(self)

    self:SetForceInputRules(true)
    self:SetMouseEnabled(true)

    -- Creates the outline widget.
    local oOutlineWidget = WGUI.Create(Image, self)
    oOutlineWidget:SetSize(Vector2D())
    oOutlineWidget:SetBrush(Brush(
        DrawMode.RoundedBox,
        Color(1, 1, 1, 0),
        nil,
        nil,
        OutlineSettings(Quat(0), Color(0, 0.5, 1, 1), 1, RoundingType.FixedRadius)
    ))

    ---@return Image
    function MouseOutlineFrame:GetOutlineWidget()
        return oOutlineWidget
    end
end

-- Called each frame to update the outline.
function MouseOutlineFrame:OnTick()
    local tMousePosition = WGUI.GetPlatformMousePosition()

    local tOutlineList = self:GetOutlineList()
    for i = #tOutlineList, 1, -1 do
        local oWidget = tOutlineList[i]
        if Geometry.IsUnderLocation(oWidget, tMousePosition) then
            self:OutlineWidget(oWidget)
            break
        end
    end
end

-- Outlines the specified widget.
---@param oWidget BaseWidget
function MouseOutlineFrame:OutlineWidget(oWidget)
    local oOutlineWidget = self:GetOutlineWidget()

    if oWidget:IsA(CanvasPanel) or oWidget:IsChildOfParent(CanvasPanel) then
        oOutlineWidget:SetPos(Geometry.GetLocalTopLeft(oWidget))
        oOutlineWidget:SetSize(Geometry.GetLocalSize(oWidget))
        return
    end

    local tLocalSize = Geometry.GetLocalSize(oWidget)
    local tLocalCoordinate = Geometry.GetAbsoluteSize(oWidget) - tLocalSize
    local _, tViewportPosition = Geometry.LocalToViewport(oWidget, tLocalCoordinate / 100)

    oOutlineWidget:SetPos(tViewportPosition)
    oOutlineWidget:SetSize(tLocalSize)
end

-- Collects all the widgets inside the layout panel to be added to the outline list.
function MouseOutlineFrame:CollectWidgets()
    self:AddWidget(WGUI.GetLayout(), true)
end

-- Adds a widget to the outline list.
---@param oWidget BaseWidget
---@param bRecursive boolean
function MouseOutlineFrame:AddWidget(oWidget, bRecursive)
    local tOutlineList = self:GetOutlineList()
    table.insert(tOutlineList, oWidget)
    self:SetOutlineList(tOutlineList)

    -- Recursively add the children of the widget to the outline list.
    if bRecursive then
        if oWidget:IsA(PanelWidget) then
            local tChildren = oWidget:GetAllChildren()
            for _, oChild in ipairs(tChildren) do
                self:AddWidget(oChild, true)
            end
        end
    end
end

-- Removes a widget from the outline list.
---@param oWidget BaseWidget
---@param bRecursive boolean
function MouseOutlineFrame:RemoveWidget(oWidget, bRecursive)
    local tOutlineList = self:GetOutlineList()
    for i, oOutline in ipairs(tOutlineList) do
        if oOutline == oWidget then
            table.remove(tOutlineList, i)
            -- Recursively remove the children of the widget from the outline list.
            if bRecursive then
                if oWidget:IsA(PanelWidget) then
                    local tChildren = oWidget:GetAllChildren()
                    for _, oChild in ipairs(tChildren) do
                        self:RemoveWidget(oChild, true)
                    end
                end
            end
            break
        end
    end
    self:SetOutlineList(tOutlineList)
end

-- Sets the outline list.
---@param tOutlineList BaseWidget[]
function MouseOutlineFrame:SetOutlineList(tOutlineList)
    self:SetValue("__OutlineList", tOutlineList)
end

-- Clears the outline list.
function MouseOutlineFrame:ClearOutlineList()
    self:SetOutlineList({})
end

-- Gets the outline list.
---@return BaseWidget[]
function MouseOutlineFrame:GetOutlineList()
    local tOutlineList = self:GetValue("__OutlineList", {})
    return tOutlineList
end