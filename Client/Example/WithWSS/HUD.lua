---@class WSS_HUD : FlexBox
WSS_HUD = FlexBox.Inherit("WSS_HUD")

function WSS_HUD:Constructor()
    FlexBox.Constructor(self, Orientation.Horizontal)

    -- Apply the WSS to the HUD
    self:SetStyleTags("#HUD")
    self:ApplyWSS()

    -- Adds the HUD to the default WGUI canvas panel widget.
    WGUI.GetLayout():AddChild(self)

    -- Creates the HealthIndicator and WeaponIndicator widgets
    local HealthIndicator = WGUI.Create(WSS_HealthIndicator, self)
end

WSS.LoadFile("wgui/Client/Example/WithWSS/HUD.toml")

Package.Require("Indicator.lua")
Package.Require("HealthIndicator.lua")