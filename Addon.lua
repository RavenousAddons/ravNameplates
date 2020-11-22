---
-- Ravenous Nameplates
--   Cycles through four different Nameplate configurations:
--   enemy, friendly, all, none.
-- Author: waldenp0nd
-- License: Public Domain
-- https://github.com/waldenp0nd/ravNameplates
-- https://www.wowinterface.com/downloads/info24006-RavenousNameplates.html
---
local _, ravNameplates = ...
ravNameplates.name = "Ravenous Nameplates"
ravNameplates.version = "2.0.0"

local defaults = {
    LOCALE = "enUS"
}

local colorAlliance = "0078ff"
local colorHorde = "b30000"
local colorNeutral = "f8b700"
local colorNone = "999999"
local faction, _ = UnitFactionGroup("player")
local colorFriendly = faction == "Alliance" and colorAlliance or faction == "Horde" and colorHorde or colorNeutral
local colorEnemy = faction == "Alliance" and colorHorde or faction == "Horde" and colorAlliance or colorNeutral

local function prettyPrint(message)
    local prefix = "\124cff9eb8c9" .. ravNameplates.name .. ": \124r"
    DEFAULT_CHAT_FRAME:AddMessage(prefix .. message)
end

local function nameplateHandler()
    local showingFriends = GetCVar("nameplateShowFriends") == "1" and true or false
    local showingEnemies = GetCVar("nameplateShowEnemies") == "1" and true or false

    -- All → None
    if showingFriends and showingEnemies then
        SetCVar("nameplateShowFriends", 0)
        SetCVar("nameplateShowEnemies", 0)
        prettyPrint(string.format(ravNameplates.locales[ravNameplates.locale].hiding, colorNone, ravNameplates.locales[ravNameplates.locale].toggles.all))
    -- Friendly → All
    elseif showingFriends then
        SetCVar("nameplateShowFriends", 1)
        SetCVar("nameplateShowEnemies", 1)
        prettyPrint(string.format(ravNameplates.locales[ravNameplates.locale].showing, colorNeutral, ravNameplates.locales[ravNameplates.locale].toggles.all))
    -- Enemy → Friendly
    elseif showingEnemies then
        SetCVar("nameplateShowFriends", 1)
        SetCVar("nameplateShowEnemies", 0)
        prettyPrint(string.format(ravNameplates.locales[ravNameplates.locale].showing, colorFriendly, ravNameplates.locales[ravNameplates.locale].toggles.friendly))
    -- None → Enemy
    else
        SetCVar("nameplateShowFriends", 0)
        SetCVar("nameplateShowEnemies", 1)
        prettyPrint(string.format(ravNameplates.locales[ravNameplates.locale].showing, colorEnemy, ravNameplates.locales[ravNameplates.locale].toggles.enemy))
    end
end


SLASH_RAVNAMEPLATES1 = "/ravenousnameplates"
SLASH_RAVNAMEPLATES2 = "/ravnameplates"
SLASH_RAVNAMEPLATES3 = "/ravn"
local function slashHandler(message, editbox)
    if message == "help" or message == "h" then
        prettyPrint("")
        print(ravNameplates.locales[ravNameplates.locale].help[1])
        print(string.format(ravNameplates.locales[ravNameplates.locale].help[2], ravNameplates.name))
    elseif message == "version" or message == "v" then
        prettyPrint(string.format(ravNameplates.locales[ravNameplates.locale].version, ravNameplates.version))
    elseif UnitAffectingCombat("player") then
        RaidNotice_AddMessage(RaidWarningFrame, ravNameplates.locales[ravNameplates.locale].warning, ChatTypeInfo["RAID_WARNING"])
    else
        nameplateHandler()
    end
end
SlashCmdList["RAVNAMEPLATES"] = slashHandler

-- Check Installation and Updates on AddOn Load
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, arg)
    if arg == "ravNameplates" then
        if event == "ADDON_LOADED" then
            ravNameplates.locale = GetLocale()
            if not ravNameplates.locales[ravNameplates.locale] then
                ravNameplates.locale = defaults.LOCALE
            end
            if not RAVN_version then
                prettyPrint(string.format(ravNameplates.locales[ravNameplates.locale].load.install, ravNameplates.name))
            elseif RAVN_version ~= ravNameplates.version then
                prettyPrint(string.format(ravNameplates.locales[ravNameplates.locale].load.update, ravNameplates.name))
            end
            if not RAVN_version or RAVN_version ~= ravNameplates.version then
                print(ravNameplates.locales[ravNameplates.locale].help[1])
                print(string.format(ravNameplates.locales[ravNameplates.locale].help[2], ravNameplates.name))
            end
            RAVN_version = ravNameplates.version
        end
    end
end)
