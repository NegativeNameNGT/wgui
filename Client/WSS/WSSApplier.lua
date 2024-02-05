-- Apply a WSS stylesheet to a widget.
---@param oWidget BaseWidget
---@param tStyleSheet table
---@param iLayerType LayerType
local function ApplyStyleSheet(oWidget, tStyleSheet, iLayerType)
    for sField, xValue in pairs(tStyleSheet) do
        if not WSS.Fields[sField] then
            goto continue
        end

        Console.Warn("[WSS] Applying field '" .. sField .. "' with value '" .. xValue .. "'")

        local fnSetter = WSS.Fields[sField][1]

        fnSetter(oWidget, xValue)
        ::continue::
    end
end

-- Apply a WSS layer (class, tag, dynamic) to a widget.
---@param oWidget BaseWidget
---@param sLayerName string
---@param iLayerType LayerType
local function ApplyLayer(oWidget, sLayerName, iLayerType)
    local tStyleSheet = WSS.GetStyleSheet(sLayerName, iLayerType or LayerType.Class)
    if not tStyleSheet then
        Console.Error("[WSS] Layer '" .. sLayerName .. "' does not exist.")
        return
    end

    ApplyStyleSheet(oWidget, tStyleSheet, iLayerType)
end

-- Applies a WSS tag to a widget.
---@param oWidget BaseWidget
---@param sTag string
function WSS.ApplyTag(oWidget, sTag)
    ApplyLayer(oWidget, sTag, LayerType.Tag)
end