-- Internal WGUI library for error handling.
InternalLib = {}

-- Function to output a type error
function InternalLib.ExpectType(sFunctionName, iArgNumber, xValue, sExpectedType)
    local sArgNumber = ""

    if iArgNumber == 1 then
        sArgNumber = "1st"
    elseif iArgNumber == 2 then
        sArgNumber = "2nd"
    elseif iArgNumber == 3 then
        sArgNumber = "3rd"
    else
        sArgNumber = iArgNumber .. "th"
    end

    local sErrorMessage = string.format(
        "Error on calling method '%s' : Expected '%s', got '%s' in the %s parameter.",
        sFunctionName, sExpectedType, type(xValue), sArgNumber
    )

    assert(false, sErrorMessage)
end