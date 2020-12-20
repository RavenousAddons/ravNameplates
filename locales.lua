local _, ravNameplates = ...

ravNameplates.locales = {
    ["enUS"] = {
        ["help"] = {
            "Information and How to Use",
            "This AddOn creates and maintains a macro called |cff9eb8c9%s|r for you under General Macros.", -- ravNameplates.name
            "Check out |cff9eb8c9%s|r on GitHub, WoWInterface, or Curse for more info and support!", -- ravNameplates.name
            "You can also get help directly from the author on Discord: %s" -- ravNameplates.discord
        },
        ["load"] = {
            ["outofdate"] = "There is an update available for |cff9eb8c9%s|r! Please go to GitHub, WoWInterface, or Curse to download.", -- ravNameplates.name
            ["install"] = "Thanks for installing |cff9eb8c9%s|r!", -- ravNameplates.name
            ["update"] = "Thanks for updating to |cff9eb8c9v%s|r!", -- ravNameplates.version
            ["both"] = "Type |cff9eb8c9/%s help|r to familiarize yourself with the addon." -- defaults.COMMAND
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
