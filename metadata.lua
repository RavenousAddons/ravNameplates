local name, ns = ...

local GetAddOnMetadata = C_AddOns.GetAddOnMetadata

ns.name = "Ravenous Nameplates"
ns.title = GetAddOnMetadata(name, "Title")
ns.notes = GetAddOnMetadata(name, "Notes")
ns.version = GetAddOnMetadata(name, "Version")
ns.color = "87d387"
ns.command = "ravn"
ns.icon = "134067"
