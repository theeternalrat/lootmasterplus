local L = LibStub("AceLocale-3.0"):NewLocale("LootMasterPlus", "enUS", true)

L.core = {
    addonName = "LootMasterPlus",
    name = "Loot Master Plus",
    dbName = "LootMasterPlusDB",
    tabs = {
        {
            value = "mainTab",
            text = "Main Tab"
        },
        {
            value = "optionsTab",
            text = "Options"
        }
    },
    lootStyleLabel = "Loot Style",
    lootStyleOptions = {
        epgp = "EPGP",
        lm = "Loot Master",
        epgplm = "EPGP/LM"
    },
    lootStyleOptionsEnum = {
        "epgp", "lm", "epgplm"
    },
    lootMastersLabel = "Loot Masters",
    disenchantersLabel = "Disenchanters",
}

L.dev = {
    tabs = {
        {
            value = "mainTab",
            text = "Main Tab"
        },
        {
            value = "optionsTab",
            text = "Options"
        },
        {
            value = "dev",
            text = "Dev Options"
        }
    },
}