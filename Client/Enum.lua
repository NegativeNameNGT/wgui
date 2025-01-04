---@enum Anchor
Anchor = {
    TopRight = 0,
    TopCenter = 1,
    TopLeft = 2,
    CenterRight = 3,
    Center = 4,
    CenterLeft = 5,
    BottomRight = 6,
    BottomCenter = 7,
    BottomLeft = 8,
    StretchTop = 9,
    StretchHorizontalCenter = 10,
    StretchVerticalCenter = 11,
    StretchBottom = 12,
    StretchRight = 13,
    StretchLeft = 14,
    Filled = 15
}

---@enum WGUI_ImageType
WGUI_ImageType = {
    Invalid = 0,
    URL = 1,
    Package = 2,
    Asset = 3
}

---@enum CaseMode
CaseMode = {
    None = 0,
    Lower = 1,
    Upper = 2,
}

---@enum OverflowMode
OverflowMode = {
    Clip = 0,
    Ellipsis = 1
}

---@enum SizeRule
SizeRule = {
    Auto = 0,
    Fill = 1
}

---@enum HAlign
HAlign = {
    Fill = 0,
    Left = 1,
    Center = 2,
    Right = 3
}

---@enum VAlign
VAlign = {
    Fill = 0,
    Top = 1,
    Center = 2,
    Bottom = 3
}

---@enum DrawMode
DrawMode = {
    None = 0,
    Box = 1,
    Border = 2,
    Image = 3,
    RoundedBox = 4
}

---@enum TileMode
TileMode = {
    NoTile = 0,
    Horizontal = 1,
    Vertical = 2,
    Both = 3
}

---@enum RoundingType
RoundingType = {
    FixedRadius = 0,
    HalfHeightRadius = 1
}

---@enum ScrollWhenFocusChanges
ScrollWhenFocusChanges = {
    NoScroll = 0,
    InstantScroll = 1,
    AnimatedScroll = 2
}

---@enum WGUIVisibility
WGUIVisibility = {
    Visible = 0,
    Collapsed = 1,
    Hidden = 2,
    NotHitTestableAll = 3,
    NotHitTestableSelf = 4,
}

---@enum Orientation
Orientation = {
    Horizontal = 0,
    Vertical = 1
}

---@enum BarFillDirection
BarFillDirection = {
    LeftToRight = 0,
    RightToLeft = 1,
    FillFromCenter = 2,
    FillFromCenterHorizontal = 3,
    FillFromCenterVertical = 4,
    TopToBottom = 5,
    BottomToTop = 6
}
---@enum BarFillStyle
BarFillStyle = {
    Mask = 0,
    Scale = 1
}

---@enum ConsumeMouseWheel
ConsumeMouseWheel = {
    WhenScrollingPossible = 0,
    Always = 1,
    Never = 2
}

---@enum Stretch
Stretch = {
    None = 0,
    Fill = 1,
    ScaleToFit = 2,
    ScaleToFitX = 3,
    ScaleToFitY = 4,
    ScaleToFill = 5,
    ScaleBySafeZone = 6,
    UserSpecified = 7,
    UserSpecifiedWithClipping = 8
}

---@enum TextCommit
TextCommit = {
    Default = 0,
    OnEnter = 1,
    OnUserMovedFocus = 2,
    OnCleared = 3
}

---@enum StretchDirection
StretchDirection = {
    Both = 0,
    DownOnly = 1,
    UpOnly = 2
}

---@enum TextJustify
TextJustify = {
    Left = 0,
    Center = 1,
    Right = 2
}

---@enum CreationFlags
CreationFlags = {
    None = 0,
    Transient = 1
}

---@enum ColorMode
ColorMode = {
    SpecifiedColor = 0,
    ForegroundColor = 1
}

---@enum WidgetClipping
WidgetClipping = {
    Inherit = 0,
    ClipToBounds = 1,
    ClipToBoundsWithoutIntersecting = 2,
    ClipToBoundsAlways = 3,
    OnDemand = 4
}

---@enum DragPivot
DragPivot = {
    MouseDown = 0,
    TopLeft = 1,
    TopCenter = 2,
    TopRight = 3,
    CenterLeft = 4,
    Center = 5,
    CenterRight = 6,
    BottomLeft = 7,
    BottomCenter = 8,
    BottomRight = 9
}

---@enum ClickMethod
ClickMethod = {
    DownAndUp = 0,
    MouseDown = 1,
    MouseUp = 2,
    PreciseClick = 3
}

---@enum TouchMethod
TouchMethod = {
    DownAndUp = 0,
    Down = 1,
    PreciseTap = 2
}

---@enum PressMethod
PressMethod = {
    DownAndUp = 0,
    ButtonPress = 1,
    ButtonRelease = 2
}

---@enum PixelSnapping
PixelSnapping = {
    Inherit = 0,
    Disabled = 1,
    SnapToPixel = 2
}

---@enum ListViewSelectionMode
ListViewSelectionMode = {
    None = 0,
    Single = 1,
    SingleToggle = 2,
    Multi = 3,
}