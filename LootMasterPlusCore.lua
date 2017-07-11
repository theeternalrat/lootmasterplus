--localization
local L = LibStub("AceLocale-3.0"):GetLocale("LootMasterPlus", true)

--init addon
LMP = LibStub("AceAddon-3.0"):NewAddon(L.core.name, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0")

function LMP:OnInitialize()
    --called when addon is first loaded in-game
    self.db = LibStub("AceDB-3.0"):New(L.core.dbName)
    
    --TODO: profiles with default
    --options table for Ace3
    local options = {
        name = "LootMasterPlus",
        handler = LMP,
        type = 'group',
        args = {
        }
    }

    --setup profiles for options
    options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

    --register the options table
    LibStub("AceConfig-3.0"):RegisterOptionsTable("LootMasterPlus", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("LootMasterPlus", L.core.name)

    --register chat commands
    LMP:RegisterChatCommand("lmp", "ChatCommandHandler")

    --Basic UI
    local AceGUI = LibStub("AceGUI-3.0")
    self.mainFrame = AceGUI:Create("Frame")
    local frame = self.mainFrame
    frame:SetTitle("Loot Master Plus")
    frame:SetStatusText(L.core.name .. " by Ryan Atkinson - Ecoshock US-Deathwing(H)")
    frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    frame:SetLayout("Fill")

    --add our tabs into the main UI frame
    local tabFrame = AceGUI:Create("TabGroup")
    tabFrame:SetLayout("Flow")
    tabFrame:SetTabs(L.core.tabs)
    frame:AddChild(tabFrame)
    tabFrame:SelectTab(L.core.tabs[1].value)
    tabFrame:SetCallback("OnGroupSelected", TabGroupSelected)

    --local editbox = AceGUI:Create("EditBox")
    --editbox:SetLabel("Insert Text:")
    --editbox:SetWidth(200)
    --frame:AddChild(editbox)
end

function LMP:OnEnable()
    --called when addon is enabled
end

function LMP:OnDisable()
    --called when addon is disabled
end

--tab group selection
function LMP:TabGroupSelected(group)
    self:Print(group .. " selected")
end

--chat commands
function LMP:ChatCommandHandler(input)
    if not input or input:trim() == "" then
        LibStub("AceConfigDialog-3.0"):Open("LootMasterPlus")
    else
        LibStub("AceConfigCmd-3.0").HandleCommand(LMP, "lmp", "LootMasterPlus", input)
    end
end

--AceComm inter-addon comm
function LMP:OnCommReceived(prefix, message, dist, sender)
    --process the message
end

LMP:RegisterComm("LMP$$")
