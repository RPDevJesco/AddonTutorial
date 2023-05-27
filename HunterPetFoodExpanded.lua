local displayFrame = CreateFrame("Frame", "PetFoodDisplayFrame", UIParent)
displayFrame:SetSize(400, 30)
displayFrame:SetPoint("TOP", 0, 0)

local displayText = displayFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
displayText:SetAllPoints()
displayText:SetJustifyH("CENTER")
displayFrame:Show()

local function UpdatePetFood()
  local petFoodList = { GetPetFoodTypes() }
  local petFoodDisplay = ""
  local index, foodType
  for index, foodType in pairs(petFoodList) do
    petFoodDisplay = foodType
  end
  displayText:SetText(petFoodDisplay)
end

local function RandomizeTextColor()
  local r, g, b = math.random(), math.random(), math.random()
  displayText:SetTextColor(r, g, b)
end

local function PeriodicallyRandomizeColor()
  RandomizeTextColor()
  C_Timer.After(1, PeriodicallyRandomizeColor)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_PET")
frame:RegisterEvent("PET_BAR_UPDATE")
frame:RegisterEvent("PET_STABLE_UPDATE")
frame:RegisterEvent("PET_UI_UPDATE")

frame:SetScript("OnEvent", function(self, event, unit)
  if event == "UNIT_PET" or event == "PET_BAR_UPDATE" or event == "PET_STABLE_UPDATE" or event == "PET_UI_UPDATE" then
    UpdatePetFood()
    PeriodicallyRandomizeColor()
  end
end)