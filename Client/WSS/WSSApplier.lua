-- Collects all the fields from the stylesheet.
---@param tStyleSheet table
---@param tOutput table
local function CollectFields(tStyleSheet, tOutput)
    for sField, xValue in pairs(tStyleSheet) do
        if not _WSS.Fields[sField] then
            goto continue
        end

        tOutput[sField] = xValue
        ::continue::
    end
end

-- Gets all the class layers
---@param oClass table
---@param tClassStyleSheet table
function _WSS.CollectClassLayers(oClass, tClassStyleSheet, tDynamicStyleSheet)
    if oClass:GetParentClass() then
        _WSS.CollectClassLayers(oClass:GetParentClass(), tClassStyleSheet)
    end

    local tStyleSheet = _WSS.GetStyleSheet(tostring(oClass), LayerType.Class)

    if tStyleSheet then
        CollectFields(tStyleSheet, tClassStyleSheet)
    end


    local tDynamicPseudoClasses = _WSS.GetStyleSheet(tostring(oClass), LayerType.Dynamic)
    if not tDynamicPseudoClasses then
        return
    end

    for sField, xValue in pairs(tDynamicPseudoClasses) do
        tDynamicStyleSheet[sField] = xValue
    end
end

-- Collects all the tag layers
---@param oWidget BaseWidget
---@param tOutput table
function _WSS.CollectTagLayers(oWidget, tOutput)
    for _, sTag in pairs(oWidget:GetValue("__StyleTags", {})) do
        local tStyleSheet = _WSS.GetStyleSheet(sTag, LayerType.Tag)
        if not tStyleSheet then
            goto continue
        end

        CollectFields(tStyleSheet, tOutput)
        ::continue::
    end

    return tOutput
end

-- Collects all the fields to be applied to a widget.
---@param oWidget BaseWidget
---@return table, table
function _WSS.CollectFields(oWidget)
    local tFields = {}
    local tDynamicStyleSheet = {}

    _WSS.CollectClassLayers(oWidget:GetClass(), tFields, tDynamicStyleSheet)
    _WSS.CollectTagLayers(oWidget, tFields)

    return tFields, tDynamicStyleSheet
end

-- Applies a style sheet to a widget.
---@param oWidget BaseWidget
---@param tStyleSheet table
function _WSS.ApplyStyleSheet(oWidget, tStyleSheet)
    local bBrushPropertyChanged = false
    for sField, xValue in pairs(tStyleSheet) do
        if not _WSS.Fields[sField] then
            goto continue
        end

        if type(xValue) == "string" and xValue:sub(1, 1) == "$" then
            local sAttribute = xValue:sub(2)
            _WSS.AddWidgetToDynamicAttribute(sAttribute, sField, oWidget)

            xValue = WSS.GetDynamicAttributeValue(sAttribute)
            if xValue == nil then
                goto continue
            end
        end

        Console.Warn("[WSS] Applying field '" .. sField .. "' with value '" .. tostring(xValue) .. "'")

        local sSetterFunction = _WSS.Fields[sField][1]
        if _WSS.BrushExtension[sField] then
            bBrushPropertyChanged = true
            _WSS.HandleBrushProperty(oWidget, sField, xValue)
            goto continue
        end

        if not sSetterFunction then
            goto continue
        end

        local bShouldUnpack = _WSS.Fields[sField][3]

        if type(sSetterFunction) == "function" then
            sSetterFunction(oWidget, xValue)
            goto continue
        end

        if not oWidget[sSetterFunction] then
            _WSS.StoreSlotValue(oWidget, sSetterFunction, xValue)
            goto continue
        end

        if bShouldUnpack then
            oWidget[sSetterFunction](oWidget, table.unpack(xValue))
        else
            oWidget[sSetterFunction](oWidget, xValue)
        end
        ::continue::
    end

    if bBrushPropertyChanged then
        oWidget:SetBrush(oWidget:GetBrush())
    end
end

-- Builds a brush from a style sheet.
---@param oBrush Brush
---@param tStyleSheet table
---@return Brush
local function BuildBrushFromStyleSheet(oBrush, tStyleSheet)
    for sField, xValue in pairs(tStyleSheet) do
        if not _WSS.BrushExtension[sField] then
            goto continue
        end

        local sFunction = _WSS.BrushExtension[sField][1]
        oBrush[sFunction](xValue)
        ::continue::
    end

    return oBrush
end

-- Applies a dynamic style sheet to a widget.
---@param oWidget BaseWidget
---@param tDynamicStyleSheet table
function _WSS.ApplyDynamicStyleSheet(oWidget, tDynamicStyleSheet)
    if not next(tDynamicStyleSheet) then
        return
    end

    local oStyleSheet = oWidget["GetStyleSheet"](oWidget)

    for sState, tStyleSheet in pairs(tDynamicStyleSheet) do
        local oBrush = BuildBrushFromStyleSheet(oStyleSheet[sState], tStyleSheet)

        oStyleSheet[sState] = oBrush
    end

    oWidget["SetStyleSheet"](oWidget, oStyleSheet)

    print(oStyleSheet["NormalPadding"])
end