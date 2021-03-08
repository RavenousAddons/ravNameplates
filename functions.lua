local _, ns = ...
local L = ns.L

local colorAlliance = "0078ff"
local colorHorde = "b30000"
local colorNeutral = "f8b700"
local colorNone = "999999"
local faction, _ = UnitFactionGroup("player")
local colorFriendly = faction == "Alliance" and colorAlliance or faction == "Horde" and colorHorde or colorNeutral
local colorEnemy = faction == "Alliance" and colorHorde or faction == "Horde" and colorAlliance or colorNeutral

function ns:PrettyPrint(message)
    DEFAULT_CHAT_FRAME:AddMessage("|cff" .. ns.color .. ns.name .. ":|r " .. message)
end

local hasSeenNoSpaceMessage = false
function ns:EnsureMacro()
    if not UnitAffectingCombat("player") then
        local body = "/" .. ns.command
        local numberOfMacros, _ = GetNumMacros()
        if GetMacroIndexByName(ns.name) > 0 then
            EditMacro(GetMacroIndexByName(ns.name), ns.name, ns.icon, body)
        elseif numberOfMacros < 120 then
            CreateMacro(ns.name, ns.icon, body)
        elseif not hasSeenNoSpaceMessage then
            hasSeenNoSpaceMessage = true
            ns:PrettyPrint(L.NoMacroSpace)
        end
    end
end

function ns:Toggle()
    local showingFriends = GetCVar("nameplateShowFriends") == "1" and true or false
    local showingEnemies = GetCVar("nameplateShowEnemies") == "1" and true or false

    -- All → None
    if showingFriends and showingEnemies then
        SetCVar("nameplateShowFriends", 0)
        SetCVar("nameplateShowEnemies", 0)
        ns:PrettyPrint(string.format(L.Hiding, colorNone, L.All))
    -- Friendly → All
    elseif showingFriends then
        SetCVar("nameplateShowFriends", 1)
        SetCVar("nameplateShowEnemies", 1)
        ns:PrettyPrint(string.format(L.Showing, colorNeutral, L.All))
    -- Enemy → Friendly
    elseif showingEnemies then
        SetCVar("nameplateShowFriends", 1)
        SetCVar("nameplateShowEnemies", 0)
        ns:PrettyPrint(string.format(L.Showing, colorFriendly, L.Friendly))
    -- None → Enemy
    else
        SetCVar("nameplateShowFriends", 0)
        SetCVar("nameplateShowEnemies", 1)
        ns:PrettyPrint(string.format(L.Showing, colorEnemy, L.Enemy))
    end
end
