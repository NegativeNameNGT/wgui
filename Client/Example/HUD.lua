Package.Require("Indicator.lua")
Package.Require("HealthIndicator.lua")
Package.Require("WeaponIndicator.lua")

-- Spawning the HUD as a FlexBox.
local HUD = WGUI.Create(FlexBox, WGUI.GetLayout(), Orientation.Horizontal)
HUD:SetAnchor(Anchor.StretchBottom)
HUD:SizeToContent()
HUD:SetPadding(10)

-- Create a container for the health and weapon indicators
local HealthContainer = WGUI.Create(HealthIndicator, HUD)
local WeaponContainer = WGUI.Create(WeaponIndicator, HUD)

-- Set the weapon container to be on the right side of the HUD
WeaponContainer:SetHAlign(HAlign.Right)
WeaponContainer:SetSize(1)