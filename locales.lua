local _, ns = ...
local L = {}
ns.L = L

setmetatable(L, { __index = function(t, k)
    local v = tostring(k)
    t[k] = v
    return v
end })

-- Default (English)
L.CycleNameplates = "Cycle Through Nameplates"
L.Support1 = "This Addon uses a Keybind setting to cycle through nameplates. Go to your Keybindings or search in Game Options to find an option to \"Cycle Through Nameplates\"."
L.Support2 = "Check out the Addon on CurseForge, GitHub, or WoWInterface for more info and support!"
L.Version = "%s is the current version." -- ns.version
L.Install = "Thanks for installing |cff%1$sv%2$s|r!" -- ns.color, ns.version
L.All = "all"
L.Friendly = "friendly"
L.Enemy = "enemy"
L.Showing = "Showing |cff%1$s%2$s|r nameplates." -- DYNAMIC, DYNAMIC
L.Hiding = "Hiding |cff%1$s%2$s|r nameplates." -- DYNAMIC, DYNAMIC
L.Warning = "You cannot change nameplates while in combat!"

-- Check locale and apply appropriate changes below
local CURRENT_LOCALE = GetLocale()

-- XXXX
-- if CURRENT_LOCALE == "xxXX" then return end
