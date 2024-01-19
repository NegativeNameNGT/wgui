-- Load WGUI
Package.Require("WGUI.lua")

-- Load widget files
Package.Require("Widgets/BaseWidget.lua")
Package.Require("Widgets/PanelWidget.lua")

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
for _, sPath in pairs(Package.GetFiles("Client/UtilityClasses/", ".lua")) do
    Package.Require(sPath)
end

-- Auto-load widget components
for _, sPath in pairs(Package.GetFiles("Client/Widgets/Components/", ".lua")) do
    Package.Require(sPath)
end

-- Auto-load widget slots
for _, sPath in pairs(Package.GetFiles("Client/Widgets/Slots/", ".lua")) do
    Package.Require(sPath)
end

WGUI.RegisterFont("Roboto", "/Engine/EngineFonts/Roboto")

-- Auto export classes, enums and functions
for sKey, xValue in pairs(_ENV) do
    if not _G[sKey] then
        Package.Export(sKey, xValue)
    end
end