-- Load WGUI
Package.Require("WGUI.lua")

-- Auto-load base widget classes files
for _, sPath in pairs(Package.GetFiles("Client/Classes/Base/", ".lua")) do
    Package.Require(sPath)
end

-- Load input handler
Package.Require("InputHandler.lua")

-- Auto-load structures
for _, sPath in pairs(Package.GetFiles("Client/Classes/Structs/", ".lua")) do
    Package.Require(sPath)
end

-- Enumerations
Package.Require("Enum.lua")

-- Auto-load stylesheet files
for _, sPath in pairs(Package.GetFiles("Client/Classes/Stylesheets", ".lua")) do
    Package.Require(sPath)
end

-- Load utility file
for _, sPath in pairs(Package.GetFiles("Client/Classes/", ".lua")) do
    Package.Require(sPath)
end

-- Auto-load widget slots
for _, sPath in pairs(Package.GetFiles("Client/Classes/Slots/", ".lua")) do
    Package.Require(sPath)
end

-- Auto-load widget components
for _, sPath in pairs(Package.GetFiles("Client/WidgetClasses/", ".lua")) do
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
Layout.Super:AddToViewport()

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