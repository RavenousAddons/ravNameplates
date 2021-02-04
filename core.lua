local name, ravNameplates = ...
local L = ravNameplates.L

function ravNameplates_OnLoad(self)
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function ravNameplates_OnEvent(_, event, arg)
    if arg == name then
        if event == "ADDON_LOADED" then
            if not RAVN_version then
                ravNameplates:PrettyPrint(string.format(L.Install, ravNameplates.color, ravNameplates.version))
            elseif RAVN_version ~= ravNameplates.version then
                ravNameplates:PrettyPrint(string.format(L.Update, ravNameplates.color, ravNameplates.version))
            end
            if not RAVN_version or RAVN_version ~= ravNameplates.version then
                print(string.format(L.InstallUpdate, ravNameplates.color))
            end
            RAVN_version = ravNameplates.version
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        ravNameplates:EnsureMacro()
    end
end

SlashCmdList["RAVNAMEPLATES"] = function(message)
    if message == "version" or message == "v" then
        ravNameplates:PrettyPrint(string.format(L.Version, ravNameplates.version))
    elseif message == "help" or message == "h" then
        ravNameplates:PrettyPrint(L.SupportHeading)
        print(string.format(L.Support1, ravNameplates.color, ravNameplates.name))
        print(L.Support2)
        print(string.format(L.Support3, ravNameplates.color, ravNameplates.discord))
    elseif UnitAffectingCombat("player") then
        RaidNotice_AddMessage(RaidWarningFrame, L.Warning, ChatTypeInfo["RAID_WARNING"])
    else
        ravNameplates:Toggle()
    end
end
SLASH_RAVNAMEPLATES1 = "/ravn"
SLASH_RAVNAMEPLATES2 = "/ravnameplates"
SLASH_RAVNAMEPLATES3 = "/ravenousnameplates"
