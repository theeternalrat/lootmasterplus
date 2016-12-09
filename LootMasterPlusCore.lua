--localization
local L = LibStub("AceLocale-3.0"):GetLocale("LootMasterPlus", true)

--init addon
LMP = LibStub("AceAddon-3.0"):NewAddon(L.core.name, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0")

function LMP:OnInitialize()
    --called when addon is first loaded in-game
    self.db = LibStub("AceDB-3.0"):New("LootMasterPlusDB")
    
    --TODO: profiles with default
    --options table for Ace3
    local options = {
        name = "LootMasterPlus",
        handler = LMP,
        type = 'group',
        args = {
            msg = {
                type = 'input',
                name = L.core.msg.name,
                desc = L.core.msg.desc,
                set = 'SetMyMessage',
                get = 'GetMyMessage'
            }
        }
    }

    --setup profiles for options
    options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

    --register the options table
    LibStub("AceConfig-3.0"):RegisterOptionsTable("LootMasterPlus", options, {"lmp", "lootmasterplus"})
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("LootMasterPlus", L.core.name)

    --Basic UI
    local AceGUI = LibStub("AceGUI-3.0")
    self.mainFrame = AceGUI:Create("Frame")
    local frame = self.mainFrame
    frame:SetTitle("Main Frame")
    frame:SetStatusText("AceGUI-3.0 Example Frame")
    frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    frame:SetLayout("Flow")

    local editbox = AceGUI:Create("EditBox")
    editbox:SetLabel("Insert Text:")
    editbox:SetWidth(200)
    frame:AddChild(editbox)
end

function LMP:OnEnable()
    --called when addon is enabled
end

function LMP:OnDisable()
    --called when addon is disabled
end

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
