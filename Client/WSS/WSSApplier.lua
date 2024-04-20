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
---@param tDynamicStyleSheet table
function _WSS.CollectTagLayers(oWidget, tOutput, tDynamicStyleSheet)
    local tStyleTags = oWidget:GetValue("__StyleTags", {})

    for _, sTag in pairs(tStyleTags) do
        local tStyleSheet = _WSS.GetStyleSheet(sTag, LayerType.Tag)
        if not tStyleSheet then
            goto continue
        end

        CollectFields(tStyleSheet, tOutput)

        ::continue::

        local tDynamicPseudoClasses = _WSS.GetStyleSheet(sTag, LayerType.Dynamic)
        if tDynamicPseudoClasses then
            for sField, xValue in pairs(tDynamicPseudoClasses) do
                tDynamicStyleSheet[sField] = xValue
            end
        end
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
    _WSS.CollectTagLayers(oWidget, tFields, tDynamicStyleSheet)

    return tFields, tDynamicStyleSheet
end

local function CallFieldSetter(oWidget, sSetterFunction, xValue, bShouldUnpack)
    if type(sSetterFunction) == "function" then
        sSetterFunction(oWidget, xValue)
        return
    end

    if not oWidget[sSetterFunction] then
        _WSS.StoreSlotValue(oWidget, sSetterFunction, xValue)
        return
    end

    if bShouldUnpack then
        oWidget[sSetterFunction](oWidget, table.unpack(xValue))
    else
        oWidget[sSetterFunction](oWidget, xValue)
    end
end

-- Applies a style sheet to a widget.
---@param oWidget BaseWidget
---@param tStyleSheet table
function _WSS.ApplyStyleSheet(oWidget, tStyleSheet)
    local bBrushPropertyChanged = false

    local tBatchedOperations = {}

    for sField, xValue in pairs(tStyleSheet) do
        if not _WSS.Fields[sField] then
            goto continue
        end

        if type(xValue) == "string" and xValue:sub(1, 1) == "$" then
            local sAttribute = xValue:sub(2)
            if not _WSS.IsWidgetSubscribedToAttribute(sAttribute, oWidget) then
                _WSS.AddWidgetToDynamicAttribute(sAttribute, sField, oWidget)
            end

            local xDynamicValue = WSS.GetDynamicAttributeValue(sAttribute)
            if xDynamicValue ~= nil then
                xValue = xDynamicValue
            else
                xValue = "null"
            end
        end

        --Console.Warn("[WSS] Applying field '" .. sField .. "' with value '" .. tostring(xValue) .. "'")

        local sSetterFunction = _WSS.Fields[sField][1]
        local bIsBatched = _WSS.Fields[sField]["IsBatchable"] or false

        if bIsBatched then
            if not tBatchedOperations[sSetterFunction] then
                tBatchedOperations[sSetterFunction] = {}
            end

            tBatchedOperations[sSetterFunction][sField] = xValue

            goto continue
        end

        if _WSS.BrushExtension[sField] then
            bBrushPropertyChanged = true
            _WSS.HandleBrushProperty(oWidget, sField, xValue)
            goto continue
        end

        if not sSetterFunction then
            goto continue
        end

        local bShouldUnpack = _WSS.Fields[sField][3] or false

        CallFieldSetter(oWidget, sSetterFunction, xValue, bShouldUnpack)
        ::continue::
    end

    -- Apply brush properties
    if bBrushPropertyChanged then
        oWidget:SetBrush(oWidget:GetBrush())
    end

    -- Handle batched operations
    for sFunction, tFields in pairs(tBatchedOperations) do
        local tOrderedFields = {}

        -- Make sure the fields are ordered correctly for each function
        if sFunction == "SetFont" then
            tOrderedFields = {tFields["font_family"], tFields["font_typeface"], tFields["font_size"]}
        end

        oWidget[sFunction](oWidget, table.unpack(tOrderedFields))
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
end