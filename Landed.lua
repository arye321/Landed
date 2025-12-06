local addonName, addonTable = ...

-- State tracking
local wasOnTaxi = false

-- Function to check taxi status
local function CheckTaxiStatus()
    local isOnTaxi = UnitOnTaxi("player")

    -- Detect landing: Transition from true -> false
    if wasOnTaxi and not isOnTaxi then
        FlashClientIcon()
        print("|cFF00FF00Landed!|r") -- Green colored text
    end

    wasOnTaxi = isOnTaxi
end

-- Initialize state on load
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        wasOnTaxi = UnitOnTaxi("player")
        -- Start the ticker to check every 1 second
        C_Timer.NewTicker(1, CheckTaxiStatus)
        self:UnregisterEvent("PLAYER_ENTERING_WORLD") -- Only need to start this once
    end
end)
