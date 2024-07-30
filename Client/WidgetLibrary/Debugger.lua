local bIsDebuggerModeEnabled = false
local oHierarchyFrame = nil
local oWidgetPropertyEditor = nil
local oMouseOutlineFrame = nil

-- Enables the debugger mode. This allows to inspect the layout of the widgets and their properties in runtime.
---@deprecated
function WGUI.EnableDebuggerMode()
    if bIsDebuggerModeEnabled then
        Console.Warn("WGUI Debugger is already enabled.")
        return
    end

    -- Set the flag
    bIsDebuggerModeEnabled = true

    -- Widget Hierarchy
    local oWidgetHierarchy = WGUI.Create(WidgetHierarchy):Rebuild()

    -- Hierarchy Frame
    oHierarchyFrame = WGUI.Create(WindowFrame, WGUI.GetLayout())
    oHierarchyFrame:SetAnchor(Anchor.CenterLeft)
    oHierarchyFrame:SetPos(Vector2D(50, 0))
    oHierarchyFrame:SetSize(Vector2D(400, 700))
    oHierarchyFrame:AddTab("UI Hierarchy", oWidgetHierarchy)
    oHierarchyFrame:SetMouseEnabled(true)

    -- Widget Property
    local oWidgetPropertyWidget = WGUI.Create(PropertyEditor)

    -- Widget Property Frame
    oWidgetPropertyEditor = WGUI.Create(WindowFrame, WGUI.GetLayout())
    oWidgetPropertyEditor:SetAnchor(Anchor.CenterRight)
    oWidgetPropertyEditor:SetPos(Vector2D(-50, 0))
    oWidgetPropertyEditor:SetSize(Vector2D(400, 700))
    oWidgetPropertyEditor:AddTab("Widget Properties", oWidgetPropertyWidget)

    -- Mouse Outline Frame
    oMouseOutlineFrame = WGUI.Create(MouseOutlineFrame, WGUI.GetLayout())
    oMouseOutlineFrame:SetExcludedClasses({WindowFrame})
    oMouseOutlineFrame:CollectWidgets()

    -- Event Handlers
    oWidgetHierarchy:BindDispatcher("ItemSelectionChanged", function (self, Item, bIsSelected)
        local oWidget = Item:GetData() ---@type BaseWidget
        if bIsSelected and oWidget and oWidget:IsValid() then
            oWidgetPropertyWidget:SetWidget(oWidget)
        end
    end)
end

-- Disables the debugger mode.
---@deprecated
function WGUI.DisableDebuggerMode()

end

-- Returns if the debugger mode is enabled.
---@deprecated
---@return boolean
function WGUI.IsDebuggerModeEnabled()
    return bIsDebuggerModeEnabled
end