local name, ravNameplates = ...
ravNameplates.name = "Ravenous Nameplates"
ravNameplates.version = GetAddOnMetadata(name, "Version")
ravNameplates.github = "https://github.com/waldenp0nd/ravNameplates"
ravNameplates.curseforge = "https://www.curseforge.com/wow/addons/ravnameplates"
ravNameplates.wowinterface = "https://www.wowinterface.com/downloads/info24006-RavenousNameplates.html"
ravNameplates.discord = "https://discord.gg/dNfqnRf2fq"
ravNameplates.color = "13bd12"
ravNameplates.locales = {
    ["enUS"] = {
        ["help"] = {
            "Information and How to Use",
            "This AddOn creates and maintains a macro called |cff" .. ravNameplates.color .. "%s|r for you under General Macros.", -- ravNameplates.name
            "Check out |cff" .. ravNameplates.color .. "%s|r on GitHub, WoWInterface, or Curse for more info and support!", -- ravNameplates.name
            "You can also get help directly from the author on Discord: %s" -- ravNameplates.discord
        },
        ["load"] = {
            ["outofdate"] = "There is an update available for |cff" .. ravNameplates.color .. "%s|r! Please go to GitHub, WoWInterface, or Curse to download.", -- ravNameplates.name
            ["install"] = "Thanks for installing |cff" .. ravNameplates.color .. "%s|r!", -- ravNameplates.name
            ["update"] = "Thanks for updating to |cff" .. ravNameplates.color .. "v%s|r!", -- ravNameplates.version
            ["both"] = "Type |cff" .. ravNameplates.color .. "/%s help|r to familiarize yourself with the addon." -- defaults.COMMAND
        },
        ["toggles"] = {
            ["all"] = "all",
            ["friendly"] = "friendly",
            ["enemy"] = "enemy"
        },
        ["showing"] = "Showing |cff%s%s|r nameplates.",
        ["hiding"] = "Hiding |cff%s%s|r nameplates.",
        ["warning"] = "You cannot change nameplates while in combat!",
        ["version"] = "%s is the current version.",
        ["nospace"] = "Unfortunately, you don't have enough global macro space for the macro to be created!"
    },
}
