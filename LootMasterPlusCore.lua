--localization
local L = LibStub("AceLocale-3.0"):GetLocale("LootMasterPlus", true)

--init addon
LMP = LibStub("AceAddon-3.0"):NewAddon(L.core.name, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0")

function LMP:OnInitialize()
    --called when addon is first loaded in-game
    self.db = LibStub("AceDB-3.0"):New("LootMasterPlusDB")
    --TODO: profiles with default
end

function LMP:OnEnable()
    --called when addon is enabled
end

function LMP:OnDisable()
    --called when addon is disabled
end

--options table for Ace3
local options = {
    name = "LootMasterPlus",
    handler = LMP,
    type = 'group',
    args = {
        msg = {
            type = 'input',
            name = L.core.message,
            desc = 'The message for my addon',
            set = 'SetMyMessage',
            get = 'GetMyMessage'
        }
    }
}

--setup profiles for options
--options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(db)

--register the options table
LibStub("AceConfig-3.0"):RegisterOptionsTable("LootMasterPlus", options, {"lmp", "lootmasterplus"})

--chat commands
function LMP:GetMyMessage(info)
    return myMessageVar
end

function LMP:SetMyMessage(info, input)
    myMessageVar = input
end

--AceComm inter-addon comm
function LMP:OnCommReceived(prefix, message, dist, sender)
    --process the message
end

LMP:RegisterComm("LMP$$")
