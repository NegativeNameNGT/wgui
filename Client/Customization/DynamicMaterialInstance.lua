---@class MaterialInstance
MaterialInstance = {}
MaterialInstance.__index = MaterialInstance

-- Variable to store a unique ID for each material instance.
local iID = 0

function MaterialInstance:__tostring()
    return "DynamicMaterialInstance"
end

---Creates a new dynamic material instance.
---@param sMaterialPath string
---@param sOptionalName string | nil
---@param iCreationFlags CreationFlags | nil
---@return MaterialInstance
function DynamicMaterialInstance(sMaterialPath, sOptionalName, iCreationFlags)
    if not sMaterialPath then
        return nil
    end

    -- Initializes the material properties
    sMaterialPath = Assets.GetAssetPath(sMaterialPath, AssetType.Material)

    sMaterialPath = sMaterialPath .. "." .. sMaterialPath:match(".*/(.*)")
    iID = iID + 1

    -- Creates the material instance.
    ---@type MaterialInstance
    local self = setmetatable({__ID = iID}, MaterialInstance)

    WGUI.ToolkitBlueprint:CallBlueprintEvent("CreateDynamicMaterial", sMaterialPath, sOptionalName or "", iCreationFlags or CreationFlags.None, iID)

    return self
end

-- Sets a scalar (float) parameter value.
---@param sParameterName string
---@param fValue number
function MaterialInstance:SetScalarParameter(sParameterName, fValue)
    WGUI.ToolkitBlueprint:CallBlueprintEvent("SetScalarParameterValue", self.__ID, sParameterName, fValue)
end

-- Sets a vector parameter value.
---@param sParameterName string
---@param fValue Color
function MaterialInstance:SetVectorParameter(sParameterName, fValue)
    WGUI.ToolkitBlueprint:CallBlueprintEvent("SetVectorParameterValue", self.__ID, sParameterName, fValue)
end

-- Sets a vector parameter value.
---@param sParameterName string
---@param fValue Quat
function MaterialInstance:SetDoubleVectorParameter(sParameterName, fValue)
    WGUI.ToolkitBlueprint:CallBlueprintEvent("SetDoubleVectorParameterValue", self.__ID, sParameterName, fValue)
end

-- Sets a texture parmeter value.
---@param sParameterName string
---@param sTexturePath string
---@param bShouldCacheURLImage boolean | nil
function MaterialInstance:SetTextureParameter(sParameterName, sTexturePath, bShouldCacheURLImage)
    if string.sub(sTexturePath, 1, 1) == ("p" or "s") then
        WGUI.ToolkitBlueprint:CallBlueprintEvent("SetTextureParameterValue", self.__ID, sParameterName, nil, sTexturePath)
        return
    end

    WGUI.ToolkitBlueprint:CallBlueprintEvent("SetTextureParameterValue", self.__ID, sParameterName, sTexturePath, bShouldCacheURLImage)
end