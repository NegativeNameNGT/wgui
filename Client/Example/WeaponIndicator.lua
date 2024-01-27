---@class WeaponIndicator : Indicator
WeaponIndicator = Indicator.Inherit("WeaponIndicator")

function WeaponIndicator:Constructor()
    Indicator.Constructor(self)

    -- Creates a text block to display the ammo value
    local AmmoText = WGUI.Create(TextBlock, self, "6")
    AmmoText:SetFont("Oswald", "Bold", 28)

    -- Creates a text block to display the ammo bag value
    local AmmoBagText = WGUI.Create(TextBlock, self, " / 960")
    AmmoBagText:SetFont("Oswald", "Bold", 18)
    AmmoBagText:SetPadding(Margin(0, 0, 0, 5))
    AmmoBagText:SetVAlign(VAlign.Bottom)

    -- Stores the AmmoText and AmmoBagText to be used later
    self:SetValue("AmmoText", AmmoText)
    self:SetValue("AmmoBagText", AmmoBagText)

    -- Hides the widget by default
    self:SetVisibility(WGUIVisibility.Hidden)
    return self
end

function WeaponIndicator:SetAmmo(Ammo, AmmoBag)
    local AmmoText = self:GetValue("AmmoText")
    local AmmoBagText = self:GetValue("AmmoBagText")

    AmmoText:SetText(tostring(Ammo))
    AmmoBagText:SetText(" / " .. tostring(AmmoBag))
end