-- Creates a new brush table.
---@param iDrawMode DrawMode | nil
---@param cTintColor Color | nil
---@param sSrcImage string | nil
---@param tSrcSize Vector2D | nil
---@param xDrawModeSetting Margin | TileMode | OutlineSettings | nil
---@return Brush
function Brush(iDrawMode, cTintColor, sSrcImage, tSrcSize, xDrawModeSetting)
    ---@class Brush
    local oBrush = {}
    oBrush.DrawAs = iDrawMode or nil
    oBrush.Tint = cTintColor or nil
    oBrush.SrcSize = tSrcSize or nil
    oBrush.IsCustom = true

    ---@param iDrawMode DrawMode
    function oBrush.SetDrawMode(iDrawMode)
        oBrush.DrawMode = iDrawMode
        return oBrush
    end

    ---@param cColor Color
    function oBrush.SetColor(cColor)
        oBrush.Tint = cColor
        return oBrush
    end

    ---@param SrcImage string
    function oBrush.SetImage(SrcImage)
        if not SrcImage then
            return oBrush
        end

        local iImageType = WGUI.DetermineImageType(SrcImage)

        if iImageType == WGUI_ImageType.Package then
            oBrush.Src = nil
            oBrush.SrcTexture = SrcImage
            return oBrush
        end

        if iImageType == WGUI_ImageType.URL then
            oBrush.SrcTexture = nil
            oBrush.Src = SrcImage
            return oBrush
        end

        if iImageType == WGUI_ImageType.Asset then
            oBrush.SrcTexture = nil
            oBrush.Src = SrcImage:match(".+/(.+)") and SrcImage .. '.' .. SrcImage:match(".+/(.+)") or SrcImage
            return oBrush
        end

        return oBrush
    end

    ---@param Material MaterialInstance
    function oBrush.SetMaterial(Material)
        oBrush.WeakData = oBrush.WeakData or setmetatable({}, {__mode = "v"})
        oBrush.WeakData.Material = Material
        oBrush.SrcTexture = nil
        oBrush.Src = tostring(Material.__ID)

        return oBrush
    end

    if sSrcImage then
        oBrush.SetImage(sSrcImage)
    end

    -- Draw Mode custom settings
    if xDrawModeSetting then
        if iDrawMode == DrawMode.RoundedBox then
            oBrush.OutlineSettings = xDrawModeSetting
        end

        if iDrawMode == DrawMode.Box or iDrawMode == DrawMode.Border then
            oBrush.Margin = xDrawModeSetting
        end

        if iDrawMode == DrawMode.Image then
            oBrush.Tiling = xDrawModeSetting
        end
    end

    return oBrush
end