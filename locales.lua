local _, ravNameplates = ...
local L = {}
ravNameplates.L = L

setmetatable(L, { __index = function(t, k)
    local v = tostring(k)
    t[k] = v
    return v
end })

-- Default (English)
L.SupportHeading = "Information and How to Use"
L.Support1 = "This Addon creates and maintains a macro called |cff%1$s%2$s|r for you under General Macros." -- ravNameplates.color, ravNameplates.name
L.Support2 = "Check out the Addon on GitHub, WoWInterface, or Curse for more info and support!"
L.Support3 = "You can also get help directly from the author on Discord: |cff%1$s%2$s|r" -- ravNameplates.color, ravNameplates.discord
L.Version = "%s is the current version." -- ravNameplates.version
L.Install = "Thanks for installing |cff%1$sv%2$s|r!" -- ravNameplates.color, ravNameplates.version
L.Update = "Thanks for updating to |cff%1$sv%2$s|r!" -- ravNameplates.color, ravNameplates.version
L.InstallUpdate = "Type |cff%s/ravn help|r to familiarize yourself with the Addon." -- ravNameplates.color
L.All = "all"
L.Friendly = "friendly"
L.Enemy = "enemy"
L.Showing = "Showing |cff%1$s%2$s|r nameplates." -- DYNAMIC, DYNAMIC
L.Hiding = "Hiding |cff%1$s%2$s|r nameplates." -- DYNAMIC, DYNAMIC
L.Warning = "You cannot change nameplates while in combat!"
L.NoMacroSpace = "Unfortunately, you don't have enough global macro space for the macro to be created!"

-- Check locale and assign appropriate
local CURRENT_LOCALE = GetLocale()

-- German
if CURRENT_LOCALE == "deDE" then return end

-- Spanish
if CURRENT_LOCALE == "esES" then return end

-- Latin-American Spanish
if CURRENT_LOCALE == "esMX" then return end

-- French
if CURRENT_LOCALE == "frFR" then return end

-- Italian
if CURRENT_LOCALE == "itIT" then return end

-- Brazilian Portuguese
if CURRENT_LOCALE == "ptBR" then return end

-- Russian
if CURRENT_LOCALE == "ruRU" then return end

-- Korean
if CURRENT_LOCALE == "koKR" then return end

-- Simplified Chinese
if CURRENT_LOCALE == "zhCN" then return end

-- Traditional Chinese
if CURRENT_LOCALE == "zhTW" then return end

-- Swedish
if CURRENT_LOCALE == "svSE" then return end
