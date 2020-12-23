---
-- Ravenous Nameplates
--   Cycles through four different Nameplate configurations:
--   enemy, friendly, all, none.
-- Author: waldenp0nd
-- License: Public Domain
---
local name, ravNameplates = ...

local defaults = {
    COMMAND = "ravn",
    LOCALE =  "enUS"
}

local colorAlliance = "0078ff"
local colorHorde = "b30000"
local colorNeutral = "f8b700"
local colorNone = "999999"
local faction, _ = UnitFactionGroup("player")
local colorFriendly = faction == "Alliance" and colorAlliance or faction == "Horde" and colorHorde or colorNeutral
local colorEnemy = faction == "Alliance" and colorHorde or faction == "Horde" and colorAlliance or colorNeutral

local function prettyPrint(message, full)
    if full == false then
        message = message .. ":"
    end
    local prefix = "|cff" .. ravNameplates.color .. ravNameplates.name .. (full and " " or ":|r ")
    DEFAULT_CHAT_FRAME:AddMessage(prefix .. message)
end

local function sendVersionData()
    local inInstance, _ = IsInInstance()
    if inInstance then
        C_ChatInfo.SendAddonMessage(name, RAVN_version, "INSTANCE_CHAT")
    elseif IsInGroup() then
        if GetNumGroupMembers() > 5 then
            C_ChatInfo.SendAddonMessage(name, RAVN_version, "RAID")
        end
        C_ChatInfo.SendAddonMessage(name, RAVN_version, "PARTY")
    end
    local guildName, _, _, _ = GetGuildInfo("player")
    if guildName then
        C_ChatInfo.SendAddonMessage(name, RAVN_version, "GUILD")
    end
end

function ensureMacro()
    if not UnitAffectingCombat("player") then
        local body = "/" .. defaults.COMMAND
        local numberOfMacros, _ = GetNumMacros()
        if GetMacroIndexByName(ravNameplates.name) > 0 then
            EditMacro(GetMacroIndexByName(ravNameplates.name), ravNameplates.name, 134067, body)
        elseif numberOfMacros < 120 then
            CreateMacro(ravNameplates.name, 134067, body)
        else
            prettyPrint(ravNameplates.locales[ravNameplates.locale].nospace)
        end
    end
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


SLASH_RAVNAMEPLATES1 = "/" .. defaults.COMMAND
SLASH_RAVNAMEPLATES2 = "/ravplates"
SLASH_RAVNAMEPLATES3 = "/ravnameplates"
SLASH_RAVNAMEPLATES4 = "/ravenousplates"
SLASH_RAVNAMEPLATES5 = "/ravenousnameplates"
local function slashHandler(message, editbox)
    local command, argument = strsplit(" ", message)
    if command == "version" or command == "v" then
        prettyPrint(string.format(ravNameplates.locales[ravNameplates.locale].version, ravNameplates.version))
        sendVersionData()
    elseif command == "help" or command == "h" then
        prettyPrint(ravNameplates.locales[ravNameplates.locale].help[1])
        print(string.format(ravNameplates.locales[ravNameplates.locale].help[2], ravNameplates.name))
        print(string.format(ravNameplates.locales[ravNameplates.locale].help[3], ravNameplates.name))
        print(string.format(ravNameplates.locales[ravNameplates.locale].help[4], ravNameplates.discord))
    elseif UnitAffectingCombat("player") then
        RaidNotice_AddMessage(RaidWarningFrame, ravNameplates.locales[ravNameplates.locale].warning, ChatTypeInfo["RAID_WARNING"])
    else
        nameplateHandler()
    end
end
SlashCmdList["RAVNAMEPLATES"] = slashHandler

local function OnEvent(self, event, arg, ...)
    if arg == name then
        if event == "ADDON_LOADED" then
            ravNameplates.locale = GetLocale()
            if not ravNameplates.locales[ravNameplates.locale] then
                ravNameplates.locale = defaults.LOCALE
            end
            if not RAVN_version then
                prettyPrint(string.format(ravNameplates.locales[ravNameplates.locale].load.install, ravNameplates.name))
            elseif RAVN_version ~= ravNameplates.version then
                prettyPrint(string.format(ravNameplates.locales[ravNameplates.locale].load.update, ravNameplates.version))
            end
            if not RAVN_version or RAVN_version ~= ravNameplates.version then
                print(string.format(ravNameplates.locales[ravNameplates.locale].help[2], ravNameplates.name))
                print(string.format(ravNameplates.locales[ravNameplates.locale].load.both, defaults.COMMAND))
                RAV_seenUpdate = false
            end
            RAVN_version = ravNameplates.version
            C_ChatInfo.RegisterAddonMessagePrefix(name)
            sendVersionData()
        elseif event == "CHAT_MSG_ADDON" and RAVN_seenUpdate == false then
            local message, _ = ...
            local a, b, c = strsplit(".", ravNameplates.version)
            local d, e, f = strsplit(".", message)
            if (d > a) or (d == a and e > b) or (d == a and e == b and f > c) then
                prettyPrint(string.format(ravNameplates.locales[ravNameplates.locale].load.outofdate, ravNameplates.name))
                RAVN_seenUpdate = true
            end
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        ensureMacro()
    end
end
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", OnEvent)
