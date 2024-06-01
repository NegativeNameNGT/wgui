WGUI = WGUI or {}
WGUI.ToolkitBlueprint = Blueprint(Vector(), Rotator(), "wgui-assets::BP_WGUI_Toolkit")
WGUI.Widgets = {}

local tFonts = {}
local tURLImageCallbacks = {}
local iCurrentURLImageCallbackID = -1
local iCurWidgetID = 0

-- Adds a child to the specified parent panel.
---@param oParentPanel PanelWidget
---@param oContent BaseWidget
---@vararg any
local function AddChild(oParentPanel, oContent, ...)
    -- Redirects the panel if needed
    oParentPanel = oParentPanel:GetValue("__RedirectedPanelFunctions") or oParentPanel

    -- Adds the widget to the parent panel
    if oParentPanel.CustomAddChild then
        oParentPanel:AddChild(oContent, ...)
    else
        oParentPanel:AddChild(oContent)
    end
end

-- Creates a WGUI component by the specified class.
---@generic T : BaseWidget
---@param cClass T
---@param oParentPanel PanelWidget | nil
---@vararg any
---@return T
local function Create(cClass, oParentPanel, ...)
    -- Checks if the class exists
    if not cClass then
        assert(false, "WGui.Create: Class '" .. cClass .. "' does not exist.")
        return nil
    end

    local oWidget = cClass(...) ---@type BaseWidget

    -- Gives the widget a unique ID
    iCurWidgetID = iCurWidgetID + 1
    oWidget:SetValue("__ID", iCurWidgetID)

    -- Stores the widget
    WGUI.Widgets[iCurWidgetID] = oWidget

    oWidget:BindDispatcher("RefreshData", function (_, iVisibility)
        oWidget:SetValue("__Visibility", iVisibility)

        oWidget:UnbindDispatcher("RefreshData")
    end)

    -- Initialize the widget properties by sending the toolkit blueprint & the widget unique ID
    oWidget:CallBlueprintEvent("InitializeProperties", WGUI.ToolkitBlueprint, iCurWidgetID)

    -- Checks if the parent panel is valid
    if oParentPanel and oParentPanel:IsValid() then
        AddChild(oParentPanel, oWidget, ...)
    end

    return oWidget
end

-- Creates a WGUI component by the specified class.
---@generic T : BaseWidget
---@param cClass T
---@param oParentPanel PanelWidget | nil
---@vararg any
---@return T
function WGUI.Create(cClass, oParentPanel, ...)
    local oWidget = Create(cClass, oParentPanel, ...) ---@type BaseWidget | nil
    if oWidget then
        WSS.Apply(oWidget)
    end
    return oWidget
end

-- Creates a WGUI component by the specified class with the specified WSS tags.
---@generic T : BaseWidget
---@param cClass T
---@param tStyleTags table | string
---@param oParentPanel PanelWidget | nil
---@vararg any
---@return T
function WGUI.CreateWithTags(cClass, tStyleTags, oParentPanel, ...)
    local oWidget = Create(cClass, oParentPanel, ...) ---@type BaseWidget | nil
    if oWidget then
        WSS.SetWidgetTags(oWidget, tStyleTags)
        WSS.Apply(oWidget)
    end

    return oWidget
end

-- Gets the widget by the specified Unique ID.
---@param iID number
---@return BaseWidget
function WGUI.GetWidgetByID(iID)
    return WGUI.Widgets[iID]
end

-- Determines the type of a image path.
---@param sImagePath string
---@return WGUI_ImageType
function WGUI.DetermineImageType(sImagePath)
    if not sImagePath or sImagePath == "" then
        return WGUI_ImageType.Invalid
    end

    -- Checks if the image path is a package reference
    if string.sub(sImagePath, 1, 1) == ("p" or "s") then
        return WGUI_ImageType.Package
    end

    -- Checks if the image path is a asset reference
    if string.sub(sImagePath, 1, 1) == "/" then
        return WGUI_ImageType.Asset
    end

    -- Checks if the image path is a URL
    if (string.sub(sImagePath, 1, 1) == "h") or (string.sub(sImagePath, 1, 1) == "w") then
        return WGUI_ImageType.URL
    end

    return WGUI_ImageType.Invalid
end

-- Registers a new font by the specified name and path.
---@param sFontName FontName
---@param sFontPath string
function WGUI.RegisterFont(sFontName, sFontPath)
    -- Checks if the font name is valid
    if not sFontName or sFontName == "" then
        assert(false, "WGui.RegisterFont: Can't register a font with an empty name.")
        return
    end

    -- Checks if the font already exists
    if WGUI.IsFontRegistered(sFontName) then
        assert(false, "WGui.RegisterFont: Font '" .. sFontName .. "' is already registered.")
        return
    end

    -- Checks if the font path is valid
    if not sFontPath or sFontPath == "" then
        assert(false, "WGui.RegisterFont: Can't register a font with an empty path.")
        return
    end

    -- Checks if the font path is a asset reference path
    if not sFontPath:find("package://") then
        sFontPath = Assets.GetAssetPath(sFontPath, AssetType.Other)
        sFontPath = sFontPath .. "." .. sFontPath:match(".*/(.*)")

        if not WGUI.ToolkitBlueprint:CallBlueprintEvent("LoadAsset", sFontPath) then
            assert(false, "WGui.RegisterFont: Failed to load font asset '" .. sFontPath .. "'.")
            return
        end
    end

    tFonts[sFontName] = sFontPath
end

-- Returns whether the specified font is registered.
---@param sFontName string
---@return boolean
function WGUI.IsFontRegistered(sFontName)
    return tFonts[sFontName] ~= nil
end

-- Returns the path of the specified font.
---@param sFontName FontName
---@return string
function WGUI.GetFontPath(sFontName)
    return tFonts[sFontName]
end

-- Pre-loads a URL image.
---@param sURL string
---@param fCallback function | nil
function WGUI.PreLoadURL(sURL, fCallback)
    if not sURL or sURL == "" then
        assert(false, "WGui.PreLoadURL: Can't preload a URL with an empty path.")
        return
    end

    if not fCallback then
        WGUI.ToolkitBlueprint:CallBlueprintEvent("PreLoadURL", sURL, -1)
        return
    end

    -- Update the callback current ID
    iCurrentURLImageCallbackID = iCurrentURLImageCallbackID + 1

    -- Adds the callback to the table
    tURLImageCallbacks[iCurrentURLImageCallbackID] = {fCallback, sURL}

    WGUI.ToolkitBlueprint:CallBlueprintEvent("PreLoadURL", sURL, iCurrentURLImageCallbackID)
end

local function OnImagePreLoaded(_, iCallbackID, bSuccess)
    local tCallback = tURLImageCallbacks[iCallbackID]
    if not tCallback then
        return
    end

    local fCallback = tCallback[1]
    local sURL = tCallback[2]

    fCallback(sURL, bSuccess)

    -- Removes the callback from the table
    tURLImageCallbacks[iCallbackID] = nil
end
WGUI.ToolkitBlueprint:BindBlueprintEventDispatcher("OnImagePreLoaded", OnImagePreLoaded)

---@param oSourceWidget PanelWidget
---@param oTargetWidget PanelWidget
function WGUI.RedirectPanelFunctions(oSourceWidget, oTargetWidget)
    if not oSourceWidget:IsA(PanelWidget) then
        return
    end

    if not oTargetWidget:IsA(PanelWidget) then
        return
    end

    oSourceWidget["AddChild"] = function(...) oTargetWidget:AddChild(...) end
    oSourceWidget["RemoveChild"] = function(...) oTargetWidget:RemoveChild(...) end
    oSourceWidget["ClearChildren"] = function() oTargetWidget:ClearChildren() end
    oSourceWidget["RemoveChildAt"] = function(...) oTargetWidget:RemoveChildAt(...) end
    oSourceWidget["GetChildrenIndex"] = function(...) return oTargetWidget:GetChildrenIndex(...) end
    oSourceWidget["GetChildrenAt"] = function(...) return oTargetWidget:GetChildrenAt(...) end
    oSourceWidget["GetAllChildren"] = function() return oTargetWidget:GetAllChildren() end

    -- Store the target widget
    oSourceWidget:SetValue("__RedirectedPanelFunctions", oTargetWidget)
end

-- Gets the platform's mouse cursor position. This the 'absolute' desktop location of the mouse. <br>
---@see Viewport.GetMousePosition
---@return Vector2D
function WGUI.GetPlatformMousePosition()
    return WGUI.ToolkitBlueprint:CallBlueprintEvent("GetPlatformMousePosition") ---@type Vector2D
end