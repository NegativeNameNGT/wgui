ExtendStylesheets(
    -- This is an example of a HUD element that displays the player's health and ammo.

    -- The HUD element is a container that holds the health and ammo indicators.
    "#HUD",
    {
        anchor = Anchor.StretchBottom,
        padding = Margin(10),
        sized_to_content = true,
    },

    -- A tag to easily edit the text font of the HUD.
    "#HUD-Text",
    {
        font_family = "Oswald",
        font_typeface = "Bold"
    },

    -- The indicator border is the background of the indicator.
    "#Indicator-Border",
    {
        draw_mode = DrawMode.RoundedBox,
        border_corner = Quat(4),
        background_color = Color(0.041, 0.041, 0.041, 0.8)
    },

    -- The indicator content a flex box that holds the health icon and text.
    "#Indicator-Content",
    {
        h_align = HAlign.Center, v_align = VAlign.Center
    },

    "#HealthIcon",
    {
        background_image = "package://wgui/Client/Example/health-icon.png",
        h_align = HAlign.Center, v_align = VAlign.Center,
    },

    -- HealthText represents the text displaying the player's health.
    "#HealthText",
    {
        text = "$Health",
        font_size = 26,
        h_align = HAlign.Center, v_align = VAlign.Top,
        padding = Margin(10, 0, 0, 0)
    },

    "#WeaponIndicator",
    {
        is_visible = "$HasWeapon",
        flex_size = {1, SizeRule.Fill},
        h_align = HAlign.Right,
    },

    "#AmmoText",
    {
        text = "$Ammo",
        font_size = 28
    },

    "#AmmoBagText",
    {
        text = "$AmmoBag",
        font_size = 18,
        padding = Margin(0, 0, 0, 5),
        v_align = VAlign.Bottom
    }
)