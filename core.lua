local name, ns = ...
local L = ns.L

function ravNameplates_OnLoad(self)
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function ravNameplates_OnEvent(_, event, arg)
    if arg == name then
        if event == "ADDON_LOADED" then
            if not RAVN_version then
                ns:PrettyPrint(string.format(L.Install, ns.color, ns.version))
            elseif RAVN_version ~= ns.version then
                ns:PrettyPrint(string.format(L.Update, ns.color, ns.version))
            end
            if not RAVN_version or RAVN_version ~= ns.version then
                print(string.format(L.InstallUpdate, ns.color))
            end
            RAVN_version = ns.version
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        ns:EnsureMacro()
    end
end

SlashCmdList["RAVNAMEPLATES"] = function(message)
    if message == "version" or message == "v" then
        ns:PrettyPrint(string.format(L.Version, ns.version))
    elseif message == "help" or message == "h" then
        ns:PrettyPrint(L.SupportHeading)
        print(string.format(L.Support1, ns.color, ns.name))
        print(L.Support2)
        print(string.format(L.Support3, ns.color, ns.discord))
    elseif UnitAffectingCombat("player") then
        RaidNotice_AddMessage(RaidWarningFrame, L.Warning, ChatTypeInfo["RAID_WARNING"])
    else
        ns:Toggle()
    end
end
SLASH_RAVNAMEPLATES1 = "/ravn"
SLASH_RAVNAMEPLATES2 = "/ns"
SLASH_RAVNAMEPLATES3 = "/ravenousnameplates"
