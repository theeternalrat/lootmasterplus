function LMP:CreateFrame(name, height)
    local f = CreateFrame("Frame", name, UIParent, "BasicFrameTemplateWithInset")
    --f:Hide()
    f:SetFrameStrata("DIALOG")
    f:SetWidth(450)
    f:SetHeight(height or 325)
    f:SetPoint("CENTER", UIParent, "CENTER")
    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    f.title:SetPoint("LEFT", f.TitleBg, "LEFT", 5, 0)
    f.title:SetText("Loot Master Plus")

    f.closeButton = self.CreateButton(f, "BOTTOM", 0, 0, "Close")

    LMP:Debug("We made the frame!")

    return f
end

function LMP:CreateButton(parent, relPos, x, y, text)
    local button = CreateFrame("Button", nil, parent, "GameMenuButtonTemplate")
    button:SetPoint("CENTER", parent, relPos, x, y)
    button:SetText(text)
    button:SetNormalFontObject("GameFontNormalLarge")
    button:SetHighlightFontObject("GameFontHighlightLarge")

    return button
end