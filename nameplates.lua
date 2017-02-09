

local addonName, addonTable = ... -- Pulls back the Addon-Local Variables and stores them.
-- addonName = "ravNameplates"
-- addonTable = {}


local function prettyPrint(message)
    local prefix = "\124cff5f8aa6ravNameplates:\124r "

    DEFAULT_CHAT_FRAME:AddMessage(prefix..message)
end


local function nameplateHandler(toggle)
    local showingFriends = GetCVar("nameplateShowFriends")
    local showingEnemies = GetCVar("nameplateShowEnemies")

    -- Order of Nameplate Toggling Loop:
    --   None
    --   Enemies
    --   Friendly
    --   Both

    -- if showing Both and Toggling
    if showingFriends == "1" and showingEnemies == "1" and toggle then
        prettyPrint("Showing \124cffaaaaaano\124r nameplates.")
        SetCVar("nameplateShowFriends", 0)
        SetCVar("nameplateShowEnemies", 0)

    -- if showing Both and Querying
    elseif showingFriends == "1" and showingEnemies == "1" then
        prettyPrint("Showing \124cffffff66all\124r nameplates.")

    -- if showing Friends and Toggling
    elseif showingFriends == "1" and toggle then
        prettyPrint("Showing \124cffffff66all\124r nameplates.")
        SetCVar("nameplateShowFriends", 1)
        SetCVar("nameplateShowEnemies", 1)

    -- if showing Friends and Querying
    elseif showingFriends == "1" then
        prettyPrint("Showing \124cff66ff66friendly\124r nameplates.")

    -- if showing Enemies and Toggling
    elseif showingEnemies == "1" and toggle then
        prettyPrint("Showing \124cff66ff66friendly\124r nameplates.")
        SetCVar("nameplateShowFriends", 1)
        SetCVar("nameplateShowEnemies", 0)

    -- if showing Enemies and Querying
    elseif showingEnemies == "1" then
        prettyPrint("Showing \124cffff6666enemy\124r nameplates.")

    -- if showing None and Toggling
    elseif toggle then
        prettyPrint("Showing \124cffff6666enemy\124r nameplates.")
        SetCVar("nameplateShowFriends", 0)
        SetCVar("nameplateShowEnemies", 1)

    -- if showing None and Querying
    else
        prettyPrint("Showing \124cffaaaaaano\124r nameplates.")
    end
end


SLASH_RAVNAMEPLATES1 = "/ravnameplates"

local function slashHandler(message, editbox)
    if message == "query" then
        nameplateHandler(false)
    else
        if UnitAffectingCombat("player") then
            RaidNotice_AddMessage(RaidWarningFrame, "You cannot change nameplates while in combat!", ChatTypeInfo["RAID_WARNING"])
        else
            nameplateHandler(true)
        end
    end
end

SlashCmdList["RAVNAMEPLATES"] = slashHandler
