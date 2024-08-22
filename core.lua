local name, ns = ...
local L = ns.L

local CT = C_Timer

function ravNameplates_OnLoad(self)
    self:RegisterEvent("ADDON_LOADED")
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

            CT.After(3, function ()
                local key1, key2 = GetBindingKey("RAVENOUS_NAMEPLATES_KEY")
                if not key1 and not key2 then
                    ns:PrettyPrint("\n" .. L.Support1)
                end
            end)
        end
    end
end

SlashCmdList["RAVNAMEPLATES"] = function(message)
    if message == "version" or message == "v" then
        ns:PrettyPrint(string.format(L.Version, ns.version))
    elseif message == "help" or message == "h" then
        ns:PrettyPrint("\n" .. L.Support1 .. "\n" .. L.Support2)
    else
        ns:Toggle()
    end
end
SLASH_RAVNAMEPLATES1 = "/ravn"
SLASH_RAVNAMEPLATES2 = "/ns"
SLASH_RAVNAMEPLATES3 = "/ravenousnameplates"

BINDING_NAME_RAVENOUS_NAMEPLATES_KEY = L.CycleNameplates
