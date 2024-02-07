WSS = {}

-- Internal table to store the WSS data.
_WSS = {}

_WSS.StyleSheets = {
    Class = {},
    Tag = {},
    Dynamic = {}
}
_WSS.Fields = {}

-- Extends a table with the given fields.
---@param tFields table
function WSS.Extend(tFields)
    for sField, xFieldValue in pairs(tFields) do
        _WSS.Fields[sField] = xFieldValue
    end
end

Package.Require("WSSLoader.lua")
Package.Require("WSSParser.lua")
Package.Require("WSSFieldStoring.lua")
Package.Require("WSSDefaults.lua")
Package.Require("WSSApplier.lua")
Package.Require("WSSEvents.lua")
Package.Require("WSSBrush.lua")
Package.Require("WSSDynamicAttribute.lua")