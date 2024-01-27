Package.Require("Indicator.lua")
Package.Require("HealthIndicator.lua")
Package.Require("WeaponIndicator.lua")

---@class HUD : FlexBox
HUD = FlexBox.Inherit("HUD")

function HUD:Constructor()
    FlexBox.Constructor(self, Orientation.Horizontal)

    -- Adds the HUD to the default WGUI canvas panel widget.
    WGUI.GetLayout():AddChild(self)
    self:SetAnchor(Anchor.StretchBottom)
    self:SizeToContent()
    self:SetPadding(10)

    -- Creates the HealthIndicator and WeaponIndicator widgets
    local HealthContainer = WGUI.Create(HealthIndicator, self)
    local WeaponContainer = WGUI.Create(WeaponIndicator, self)

    -- Sets the weapon container to be on the right side of the HUD
    WeaponContainer:SetHAlign(HAlign.Right)
    WeaponContainer:SetSize(1)

    -- Stores the HealthContainer and WeaponContainer to be used later
    self:SetValue("HealthContainer", HealthContainer)
    self:SetValue("WeaponContainer", WeaponContainer)

    return self
end

-- Sets the health value
function HUD:SetHealth(Health)
    self:GetValue("HealthContainer"):SetHealth(Health)
end

-- Sets the ammo and ammo bag values
function HUD:SetAmmo(EnableUI, Ammo, AmmoBag)
    local WeaponContainer = self:GetValue("WeaponContainer")

    -- Hides the widget if EnableUI is false, otherwise shows it
    WeaponContainer:SetVisibility(EnableUI and WGUIVisibility.Visible or WGUIVisibility.Hidden)

    -- Updates the ammo values
    self:GetValue("WeaponContainer"):SetAmmo(Ammo, AmmoBag)
end