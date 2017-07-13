--localization
local L = LibStub("AceLocale-3.0"):GetLocale("LootMasterPlus", true)

--init addon
LMP = LibStub("AceAddon-3.0"):NewAddon(L.core.name, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0")

--debug
local debug = true;
local Debug = true;

function LMP:Debug(msg, VerboseMode)
    if(debug) then 
        if (VerboseMode and Debug) then
            self:Print("Verbose: " .. msg)
        else
            self:Print("Debug: " .. msg)
        end
    end
end

local function InitDefaultSettings()
    LMP.db.profile.init = true;
    LMP.db.profile.lootChoice = "lm"
    LMP.db.profile.lootMasters = UnitName("player")
    LMP.db.profile.epStart = 100
    LMP.db.profile.gpStart = 100
end

function LMP:OnInitialize()
    --called when addon is first loaded in-game
    self.db = LibStub("AceDB-3.0"):New(L.core.dbName)
    self.db:ResetDB()

    --check for first init
    if(self.db.profile.init == nil) then
        --init values
        InitDefaultSettings()
    end
    
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
    self:MakeGUI()

    --local editbox = AceGUI:Create("EditBox")
    --editbox:SetLabel("Insert Text:")
    --editbox:SetWidth(200)
    --frame:AddChild(editbox)

    self:Debug("Addon loaded successfully")
end

function LMP:OnEnable()
    --called when addon is enabled
end

function LMP:OnDisable()
    --called when addon is disabled
end

function LMP:CheckNum(value, valName)
    local num = tonumber(value)
    if(num == nil) then
        self:Print("You did not enter a number. Please fix the " .. valName .. " value")
        return false
    else 
        return num
    end
end

--save the dropdown choice
local function WriteLootDropdown(dropdown)
    LMP:Debug("Writing loot choice to db", true)
    LMP.db.profile.lootChoice = dropdown["value"]
    LMP:Debug("Loot choice set to: " .. LMP.db.profile.lootChoice, true)
end

--save the values in the ep boxes
local function SaveEPStart(value)
    local epNum = LMP:CheckNum(value:GetText(), "EP Start")
    if(epNum ~= false) then 
        LMP:Debug("Writing epStart to db: " .. epNum, true)
        LMP.db.profile.epStart = epNum
    end
end

local function SaveGPStart(value)
    local gpNum = LMP:CheckNum(value:GetText(), "GP Start")
    if(gpNum ~= false) then 
        LMP:Debug("Writing epStart to db: " .. gpNum, true)
        LMP.db.profile.gpStart = gpNum
    end
end

--tab group selection
local function TabGroupSelected(container, event, group)
    --draw tab elements
    LMP:Debug("TabGroupSelected fired. Tab selected " .. group, true)
    container:ReleaseChildren()
    local AceGUI = LibStub("AceGUI-3.0")

    if group == L.core.tabs[1].value then

    elseif group == L.core.tabs[2].value then
        --draw tab two
        local lootStyleDropdown = AceGUI:Create("Dropdown")
        lootStyleDropdown:SetList(L.core.lootStyleOptions)
        lootStyleDropdown:SetValue(LMP.db.profile.lootChoice)
        lootStyleDropdown:SetLabel(L.core.lootStyleLabel)
        lootStyleDropdown:SetCallback("OnValueChanged", WriteLootDropdown)
        container:AddChild(lootStyleDropdown)

        local lootMastersBox = AceGUI:Create("MultiLineEditBox")
        lootMastersBox:SetText(LMP.db.profile.lootMasters)
        lootMastersBox:SetLabel(L.core.lootMastersLabel)
        lootMastersBox:SetRelativeWidth(0.5)
        container:AddChild(lootMastersBox)

        --add bottom group
        local bottomGroup = AceGUI:Create("InlineGroup")
        bottomGroup:SetLayout("Flow")
        bottomGroup:SetRelativeWidth(1)
        container:AddChild(bottomGroup)

        local startValuesLabel = AceGUI:Create("Label")
        startValuesLabel:SetText("Starting Values")
        bottomGroup:AddChild(startValuesLabel)

        local epStartBox = AceGUI:Create("EditBox")
        epStartBox:SetText(LMP.db.profile.epStart)
        epStartBox:SetLabel("EP Start")
        epStartBox:SetCallback("OnTextChanged", SaveEPStart)
        epStartBox:DisableButton(true)
        container:AddChild(epStartBox)

        local gpStartBox = AceGUI:Create("EditBox")
        gpStartBox:SetText(LMP.db.profile.gpStart)
        gpStartBox:SetLabel("EP Start")
        gpStartBox:SetCallback("OnTextChanged", SaveGPStart)
        gpStartBox:DisableButton(true)
        container:AddChild(gpStartBox)
    end
    LMP:Debug("Finished creating tab", true)
end

--chat commands
function LMP:ChatCommandHandler(input)
    if not input or input:trim() == "" then
        --LibStub("AceConfigDialog-3.0"):Open("LootMasterPlus")
        self:MakeGUI()
    else
        LibStub("AceConfigCmd-3.0").HandleCommand(LMP, "lmp", "LootMasterPlus", input)
    end
end

--AceComm inter-addon comm
function LMP:OnCommReceived(prefix, message, dist, sender)
    --process the message
end

function LMP:MakeGUI()
    self:Debug("Started making main frame - MakeGUI", true)
    local AceGUI = LibStub("AceGUI-3.0")
    self.mainFrame = AceGUI:Create("Frame")
    local frame = self.mainFrame
    frame:SetTitle("Loot Master Plus")
    frame:SetStatusText(L.core.name .. " by Ryan Atkinson - Ecoshock US-Deathwing(H)")
    frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    frame:SetLayout("Fill")

    --add our tabs into the main UI frame
    local tabFrame = AceGUI:Create("TabGroup")
    tabFrame:SetLayout("List")
    tabFrame:SetTabs(L.core.tabs)
    frame:AddChild(tabFrame)
    tabFrame:SelectTab(L.core.tabs[1].value)
    tabFrame:SetCallback("OnGroupSelected", TabGroupSelected)

    self:Debug("Finished making main frame - MakeGUI", true)
end

LMP:RegisterComm("LMP$$")