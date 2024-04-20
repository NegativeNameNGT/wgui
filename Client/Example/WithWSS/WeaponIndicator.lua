---@class WSS_WeaponIndicator : WSS_Indicator
WSS_WeaponIndicator = WSS_Indicator.Inherit("WSS_WeaponIndicator")

function WSS_WeaponIndicator:Constructor()
    WSS_Indicator.Constructor(self)

    -- Creates a text block to display the ammo value
    WGUI.CreateWithTags(TextBlock, {"#HUD-Text", "#AmmoText"}, self)

    -- Creates a text block to display the ammo bag value
    WGUI.CreateWithTags(TextBlock, {"#HUD-Text", "#AmmoBagText"}, self)
end