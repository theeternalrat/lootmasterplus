SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadIU

SLASH_FRAMESTK1 = "/fs"
SlashCmdList.FRAMESTK = function()
    LoadAddOn('Blizzard_DebugTools')
    FrameStackTooltip_Toggle()
end

for i = 1, NUM_CHAT_WINDOWS do
    _G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
end