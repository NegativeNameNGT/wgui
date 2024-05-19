local bIsDebuggerModeEnabled = false
local oHierarchyFrame = nil
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

    -- Hierarchy Frame
    oHierarchyFrame = WGUI.Create(WindowFrame, WGUI.GetLayout())
    oHierarchyFrame:SetAnchor(Anchor.CenterLeft)
    oHierarchyFrame:SetPos(Vector2D(50, 0))
    oHierarchyFrame:SetSize(Vector2D(400, 700))
    oHierarchyFrame:AddTab("UI Hierarchy", WGUI.Create(WidgetHierarchy):Rebuild())
    oHierarchyFrame:SetMouseEnabled(true)

    -- Mouse Outline Frame
    oMouseOutlineFrame = WGUI.Create(MouseOutlineFrame, WGUI.GetLayout())
    oMouseOutlineFrame:SetExcludedClasses({WindowFrame})
    oMouseOutlineFrame:CollectWidgets()
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