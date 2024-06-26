---@class WSS_HUD : FlexBox
WSS_HUD = FlexBox.Inherit("WSS_HUD")
WSS.SetWidgetTags(WSS_HUD, "#HUD")

function WSS_HUD:Constructor()
    FlexBox.Constructor(self, Orientation.Horizontal)

    -- Adds the HUD to the default WGUI canvas panel widget.
    WGUI.GetLayout():AddChild(self)

    -- Creates the HealthIndicator and WeaponIndicator widgets
    WGUI.Create(WSS_HealthIndicator, self)
    WGUI.CreateWithTags(WSS_WeaponIndicator, "#WeaponIndicator", self)
end

Package.Require("Indicator.lua")
Package.Require("HealthIndicator.lua")
Package.Require("WeaponIndicator.lua")
Package.Require("style.lua")