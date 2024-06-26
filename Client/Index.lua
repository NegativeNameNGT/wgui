-- Load WGUI
Package.Require("WGUI.lua")

-- Load widget files
Package.Require("Widgets/BaseWidget.lua")
Package.Require("Widgets/PanelWidget.lua")

-- Load input handler
Package.Require("InputHandler/InputHandler.lua")

-- Load styling files
Package.Require("Structures/Brush.lua")
Package.Require("Structures/OutlineSettings.lua")
Package.Require("Structures/FontOutlineSettings.lua")
Package.Require("Structures/DynamicMaterialInstance.lua")
Package.Require("Structures/Margin.lua")

-- Enumerations
Package.Require("Enum.lua")

-- Auto-load styling files
for _, sPath in pairs(Package.GetFiles("Client/Structures/Styles/", ".lua")) do
    Package.Require(sPath)
end

-- Load utility file
for _, sPath in pairs(Package.GetFiles("Client/Classes/", ".lua")) do
    Package.Require(sPath)
end

-- Auto-load widget slots
for _, sPath in pairs(Package.GetFiles("Client/Widgets/Slots/", ".lua")) do
    Package.Require(sPath)
end

-- Auto-load widget components
for _, sPath in pairs(Package.GetFiles("Client/Widgets/Components/", ".lua")) do
    Package.Require(sPath)
end

-- Load WSS (Widget Style Sheets)
Package.Require("WSS/WSS.lua")

-- Auto-load widget library (widgets that are native to WGUI)
for _, sPath in pairs(Package.GetFiles("Client/WidgetLibrary/", ".lua")) do
    Package.Require(sPath)
end

---@alias FontName "Roboto" | "Rufing" | "Oswald" | "PoiretOne" | "GothicA1" | "OpenSans" | string
WGUI.RegisterFont("Roboto", "/Engine/EngineFonts/Roboto")
WGUI.RegisterFont("Rufing", "/Game/NanosWorld/UI/Fonts/Rufing/Font_Rufing")
WGUI.RegisterFont("Oswald", "/Game/NanosWorld/UI/Fonts/Oswald/Font_Oswald")
WGUI.RegisterFont("PoiretOne", "/Game/NanosWorld/UI/Fonts/PoiretOne/Font_PoiretOne")
WGUI.RegisterFont("GothicA1", "/Game/NanosWorld/UI/Fonts/GothicA1/Font_GothicA1")
WGUI.RegisterFont("OpenSans", "/Game/NanosWorld/UI/Fonts/OpenSans/Font_OpenSans")

-- Creating the default WGUI canvas panel widget.
local Layout = WGUI.Create(CanvasPanel)

-- Returns the default WGUI canvas panel widget.
---@return CanvasPanel
function WGUI.GetLayout()
    return Layout
end

-- Auto export classes, enums and functions
for sKey, xValue in pairs(_ENV) do
    if not _G[sKey] then
        Package.Export(sKey, xValue)
    end
end