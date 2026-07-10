-- // Key System by ItzCatto
--[[
 /$$   /$$                              
| $$  /$$/                              
| $$ /$$/  /$$   /$$  /$$$$$$   /$$$$$$ 
| $$$$$/  | $$  | $$ /$$__  $$ /$$__  $$
| $$  $$  | $$  | $$| $$  \__/| $$  \ $$
| $$\  $$ | $$  | $$| $$      | $$  | $$
| $$ \  $$|  $$$$$$$| $$      |  $$$$$$/
|__/  \__/ \____  $$|__/       \______/ 
            /$$  | $$                   
           |  $$$$$$/                   
            \______/                    
--]]

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local RAW_URL = "https://raw.githubusercontent.com/ItzCatto/cattohub/main/fart.json"
local GET_KEY_URL = "https://discord.gg/UBxMXCAr8w"

-- // Validate
local function validateKey(inputKey)
    local success, result = pcall(function()
        return game:HttpGet(RAW_URL)
    end)
    if not success then return false, "Could not connect." end

    local ok, keys = pcall(function() return HttpService:JSONDecode(result) end)
    if not ok then return false, "Failed to read key list." end

    local now = os.time() * 1000
    for _, entry in ipairs(keys) do
        if entry.key == inputKey then
            if entry.username:lower() ~= player.Name:lower() then
                return false, "Key not linked to your username."
            end
            if entry.expires <= now then
                return false, "Key expired. Get a new one."
            end
            return true, "Access granted!"
        end
    end
    return false, "Invalid key."
end

-- // GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = player.PlayerGui

local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = game:GetService("Lighting")

local Backdrop = Instance.new("Frame")
Backdrop.Size = UDim2.new(1, 0, 1, 0)
Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Backdrop.BackgroundTransparency = 1
Backdrop.BorderSizePixel = 0
Backdrop.ZIndex = 1
Backdrop.Parent = ScreenGui

-- // Card
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 400, 0, 240)
Frame.Position = UDim2.new(0.5, -200, 0.5, -120)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BackgroundTransparency = 1
Frame.BorderSizePixel = 0
Frame.ZIndex = 2
Frame.Parent = ScreenGui

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 16)

local FrameStroke = Instance.new("UIStroke", Frame)
FrameStroke.Color = Color3.fromRGB(40, 40, 40)
FrameStroke.Thickness = 1

-- // Accent line
local Accent = Instance.new("Frame", Frame)
Accent.Size = UDim2.new(0, 40, 0, 3)
Accent.Position = UDim2.new(0.5, -20, 0, 0)
Accent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Accent.BorderSizePixel = 0
Accent.ZIndex = 3
Instance.new("UICorner", Accent).CornerRadius = UDim.new(0, 99)

-- // Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 26)
Title.Position = UDim2.new(0, 0, 0, 28)
Title.BackgroundTransparency = 1
Title.Text = "Key System"
Title.TextColor3 = Color3.fromRGB(235, 235, 235)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 3

-- // Subtitle
local Subtitle = Instance.new("TextLabel", Frame)
Subtitle.Size = UDim2.new(1, 0, 0, 18)
Subtitle.Position = UDim2.new(0, 0, 0, 56)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Enter your 24-hour key to continue"
Subtitle.TextColor3 = Color3.fromRGB(90, 90, 90)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.Gotham
Subtitle.ZIndex = 3

-- // Input
local KeyBox = Instance.new("TextBox", Frame)
KeyBox.Size = UDim2.new(1, -40, 0, 40)
KeyBox.Position = UDim2.new(0, 20, 0, 86)
KeyBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "XXXXX-XXXXX-XXXXX-XXXXX"
KeyBox.PlaceholderColor3 = Color3.fromRGB(55, 55, 55)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(210, 210, 210)
KeyBox.TextSize = 13
KeyBox.Font = Enum.Font.Code
KeyBox.ClearTextOnFocus = false
KeyBox.ZIndex = 3
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 8)
local KStroke = Instance.new("UIStroke", KeyBox)
KStroke.Color = Color3.fromRGB(40, 40, 40)
KStroke.Thickness = 1

-- // Status
local StatusLabel = Instance.new("TextLabel", Frame)
StatusLabel.Size = UDim2.new(1, -40, 0, 16)
StatusLabel.Position = UDim2.new(0, 20, 0, 132)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(90, 90, 90)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.ZIndex = 3

-- // Submit
local SubmitBtn = Instance.new("TextButton", Frame)
SubmitBtn.Size = UDim2.new(1, -40, 0, 38)
SubmitBtn.Position = UDim2.new(0, 20, 0, 150)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Text = "Submit"
SubmitBtn.TextColor3 = Color3.fromRGB(210, 210, 210)
SubmitBtn.TextSize = 13
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.AutoButtonColor = false
SubmitBtn.ZIndex = 3
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 8)
local SStroke = Instance.new("UIStroke", SubmitBtn)
SStroke.Color = Color3.fromRGB(50, 50, 50)
SStroke.Thickness = 1

-- // Get Key
local GetKeyBtn = Instance.new("TextButton", Frame)
GetKeyBtn.Size = UDim2.new(1, -40, 0, 20)
GetKeyBtn.Position = UDim2.new(0, 20, 0, 204)
GetKeyBtn.BackgroundTransparency = 1
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Text = "Don't have a key? Get one here ↗"
GetKeyBtn.TextColor3 = Color3.fromRGB(160, 160, 160)
GetKeyBtn.TextSize = 13
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.AutoButtonColor = false
GetKeyBtn.ZIndex = 3

-- // Hover
SubmitBtn.MouseEnter:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play()
end)
SubmitBtn.MouseLeave:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
end)
GetKeyBtn.MouseEnter:Connect(function()
    TweenService:Create(GetKeyBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(210, 210, 210)}):Play()
end)
GetKeyBtn.MouseLeave:Connect(function()
    TweenService:Create(GetKeyBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(160, 160, 160)}):Play()
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(GET_KEY_URL)
    GetKeyBtn.Text = "Link copied!"
    task.wait(2)
    GetKeyBtn.Text = "Don't have a key? Get one here ↗"
end)

-- // Submit logic
local function submit()
    local input = KeyBox.Text:match("^%s*(.-)%s*$")
    if input == "" then
        StatusLabel.Text = "Enter a key first."
        StatusLabel.TextColor3 = Color3.fromRGB(180, 70, 70)
        return
    end

    SubmitBtn.Text = "Checking..."
    StatusLabel.Text = ""

    local valid, message = validateKey(input)

    if valid then
        StatusLabel.Text = "✓ " .. message
        StatusLabel.TextColor3 = Color3.fromRGB(100, 200, 120)
        SubmitBtn.Text = "✓ Valid"
        task.wait(0.8)
        TweenService:Create(Frame, TweenInfo.new(0.35), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Backdrop, TweenInfo.new(0.35), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Blur, TweenInfo.new(0.35), {Size = 0}):Play()
        task.wait(0.4)
        ScreenGui:Destroy()
        Blur:Destroy()
        task.spawn(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FN_AnimalHospital.lua"))()
        end)
    else
        StatusLabel.Text = "✗ " .. message
        StatusLabel.TextColor3 = Color3.fromRGB(180, 70, 70)
        SubmitBtn.Text = "Submit"
    end
end

SubmitBtn.MouseButton1Click:Connect(submit)
KeyBox.FocusLost:Connect(function(enter) if enter then submit() end end)

-- // Fade in
TweenService:Create(Backdrop, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
TweenService:Create(Blur, TweenInfo.new(0.3), {Size = 12}):Play()
