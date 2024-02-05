WSS = {}
_WSS = {}

WSS.StyleSheets = {
    Class = {},
    Tag = {},
    Dynamic = {}
}
WSS.Fields = {}

-- Extends a table with the given fields.
---@param tFields table
function WSS.Extend(tFields)
    for sField, xFieldValue in pairs(tFields) do
        WSS.Fields[sField] = xFieldValue
    end
end

Package.Require("WSSLoader.lua")
Package.Require("WSSParser.lua")
Package.Require("WSSDefaults.lua")
Package.Require("WSSApplier.lua")
Package.Require("WSSEvents.lua")