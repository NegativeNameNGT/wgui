---@class Brush
---@overload fun(iDrawMode?: DrawMode, cTintColor?: Color, sSrcImage?: string, tSrcSize?: Vector2D, xDrawModeSetting?: Margin | TileMode | OutlineSettings): Brush
---@field private new function
---@field private __index Brush
---@field private IsCustom boolean
---@field private WeakData? table
Brush = {}
Brush.__index = Brush

---@param iDrawMode? DrawMode
---@param cTintColor? Color
---@param sSrcImage? string
---@param tSrcSize? Vector2D
---@param xDrawModeSetting? Margin | TileMode | OutlineSettings
function Brush.new(_, iDrawMode, cTintColor, sSrcImage, tSrcSize, xDrawModeSetting)
    local self = setmetatable({}, Brush)
    self.IsCustom = true

    if type(iDrawMode) ~= "nil" then
        self.DrawAs = iDrawMode
    end

    if type(cTintColor) ~= "nil" then
        self.Tint = cTintColor
    end

    if type(tSrcSize) ~= "nil" then
        self.SrcSize = tSrcSize
    end

    if sSrcImage then
        self:SetSrc(sSrcImage)
    end

    if xDrawModeSetting then
        if iDrawMode == DrawMode.RoundedBox then
            self:SetOutlineSettings(xDrawModeSetting)
        end

        if iDrawMode == DrawMode.Box or iDrawMode == DrawMode.Border then
            self:SetMargin(xDrawModeSetting)
        end

        if iDrawMode == DrawMode.Image then
            self:SetTiling(xDrawModeSetting)
        end
    end

    return self
end

setmetatable(Brush, {
    __call = Brush.new
})

---@param iDrawMode DrawMode
function Brush:SetDrawMode(iDrawMode)
    self.DrawAs = iDrawMode

    return self
end

---@param cColor Color
function Brush:SetColor(cColor)
    if cColor and getmetatable(cColor) == Color then
        self.Tint = cColor
        return self
    end

    InternalLib.ExpectType("SetColor", 1, cColor, "Color")
end

---@param cOutlineColor Color
function Brush:SetOutlineColor(cOutlineColor)
    self.OutlineSettings = self.OutlineSettings or {}
    self.OutlineSettings.OutlineColor = cOutlineColor

    return self
end

---@param fOutlineWidth number
function Brush:SetOutlineWidth(fOutlineWidth)
    self.OutlineSettings = self.OutlineSettings or {}
    self.OutlineSettings.OutlineWidth = fOutlineWidth

    return self
end

---@param tOutlineRadius Quat
function Brush:SetOutlineRadius(tOutlineRadius)
    self.OutlineSettings = self.OutlineSettings or {}
    self.OutlineSettings.OutlineCorners = tOutlineRadius

    return self
end

---@param iOutlineType integer
function Brush:SetOutlineType(iOutlineType)
    self.OutlineSettings = self.OutlineSettings or {}
    self.OutlineSettings.OutlineType = iOutlineType

    return self
end

---@param bUseAlpha boolean
function Brush:SetOutlineUseAlpha(bUseAlpha)
    self.OutlineSettings = self.OutlineSettings or {}
    self.OutlineSettings.UseBrushTransparency = bUseAlpha

    return self
end

---@param SrcImage string | nil
function Brush:SetSrc(SrcImage)
    if not SrcImage then
        self.Src = nil
        self.SrcTexture = nil
        return self
    end

    local iImageType = WGUI.DetermineImageType(SrcImage)

    if iImageType == WGUI_ImageType.Package then
        self.Src = nil
        self.SrcTexture = SrcImage
        return self
    end

    if iImageType == WGUI_ImageType.URL then
        self.SrcTexture = nil
        self.Src = SrcImage
        return self
    end

    if iImageType == WGUI_ImageType.Asset then
        self.SrcTexture = nil
        self.Src = SrcImage:match(".+/(.+)") and SrcImage .. '.' .. SrcImage:match(".+/(.+)") or SrcImage
        return self
    end

    return self
end

---@param tSrcSize Vector2D
function Brush:SetSrcSize(tSrcSize)
    self.SrcSize = tSrcSize

    return self
end

-- Only used for URL sources.
---@param ShouldCache boolean
function Brush:SetCacheURLSrc(ShouldCache)
    self.CacheURLSrc = ShouldCache

    return self
end


---@param Material MaterialInstance | WebUI | Canvas | SceneCapture
function Brush:SetMaterial(Material)
    if not Material.__ID then
        self:SetSrc(nil)

        self.SrcMaterial = Material
    end

    self.WeakData = self.WeakData or setmetatable({}, { __mode = "v" })
    self.WeakData.Material = Material
    self.SrcTexture = nil
    self.Src = tostring(Material.__ID)

    return self
end

---@param OutlineSettings OutlineSettings
function Brush:SetOutlineSettings(OutlineSettings)
    self.OutlineSettings = OutlineSettings

    return self
end

---@param tMargin Margin
function Brush:SetMargin(tMargin)
    self.Margin = tMargin

    return self
end

---@param tTiling TileMode
function Brush:SetTiling(tTiling)
    self.Tiling = tTiling

    return self
end

-- Creates a Brush that won't draw anything.
---@return Brush
function Brush.NoResourceBrush()
    return Brush(DrawMode.None)
end