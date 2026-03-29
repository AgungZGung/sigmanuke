-- [[ NUKE XENTRIE V1 - PREMIUM GUI ]] --
local CoreGui = game:GetService("CoreGui")
local Plr = game.Players.LocalPlayer

-- Hapus GUI lama kalau ada
if CoreGui:FindFirstChild("NukeXentrie") then CoreGui.NukeXentrie:Destroy() end

-- --- UI CONSTRUCTION ---
local SG = Instance.new("ScreenGui", CoreGui)
SG.Name = "NukeXentrie"

local Main = Instance.new("Frame", SG)
Main.Size, Main.Position = UDim2.new(0, 380, 0, 320), UDim2.new(0.35, 0, 0.25, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BorderSizePixel = 0
Main.Active, Main.Draggable = true, true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Glow & Stroke
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color, Stroke.Thickness = Color3.fromRGB(0, 255, 150), 2

-- Header
local Header = Instance.new("TextLabel", Main)
Header.Size, Header.Text = UDim2.new(1, 0, 0, 45), "☢️ NUKE TYCOON: XENTRIE HUB ☢️"
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Header.TextColor3, Header.Font = Color3.new(1, 1, 1), Enum.Font.GothamBold
Header.TextSize = 16
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size, Scroll.Position = UDim2.new(1, -20, 1, -60), UDim2.new(0, 10, 0, 50)
Scroll.BackgroundTransparency, Scroll.CanvasSize = 1, UDim2.new(0, 0, 1.5, 0)
Scroll.ScrollBarThickness = 2
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 10)

-- --- FUNCTION BUILDER ---
local function CreateButton(name, desc, func)
    local Btn = Instance.new("TextButton", Scroll)
    Btn.Size, Btn.BackgroundColor3 = UDim2.new(1, 0, 0, 45), Color3.fromRGB(35, 35, 45)
    Btn.Text = "  " .. name .. " [OFF]"
    Btn.TextColor3, Btn.Font = Color3.new(1, 1, 1), Enum.Font.Gotham
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", Btn)
    
    local Enabled = false
    Btn.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        Btn.Text = "  " .. name .. (Enabled and " [ON]" or " [OFF]")
        Btn.BackgroundColor3 = Enabled and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(35, 35, 45)
        func(Enabled)
    end)
end

-- --- FEATURES ---

-- 1. Auto Collect
CreateButton("Auto Collect Money", "Narik duit otomatis", function(v)
    _G.Collect = v
    task.spawn(function()
        while _G.Collect do
            local Root = Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart")
            if Root then
                for _, x in pairs(workspace:GetDescendants()) do
                    if (x.Name == "Collect" or x.Name == "Giver") and x:IsA("TouchTransmitter") then
                        firetouchinterest(Root, x.Parent, 0)
                        firetouchinterest(Root, x.Parent, 1)
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

-- 2. Auto Buy
CreateButton("Auto Buy Buttons", "Otomatis upgrade base", function(v)
    _G.Buy = v
    task.spawn(function()
        while _G.Buy do
            local Root = Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart")
            if Root then
                for _, b in pairs(workspace:GetDescendants()) do
                    if (b.Name == "Button" or b.Name == "Purchase") and b:FindFirstChild("TouchInterest") then
                        if b.Transparency < 1 then
                            firetouchinterest(Root, b, 0)
                            firetouchinterest(Root, b, 1)
                        end
                    end
                end
            end
            task.wait(2)
        end
    end)
end)

-- 3. Speed Boost
CreateButton("Hyper Speed (150)", "Lari secepat kilat", function(v)
    Plr.Character.Humanoid.WalkSpeed = v and 150 or 16
end)

-- 4. Infinite Jump
CreateButton("Infinite Jump", "Bisa terbang manual", function(v)
    _G.Jump = v
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.Jump then Plr.Character.Humanoid:ChangeState("Jumping") end
    end)
end)

-- 5. Anti-AFK
CreateButton("Anti-AFK System", "Gak bakal kena kick", function(v)
    local VU = game:GetService("VirtualUser")
    Plr.Idled:Connect(function()
        if v then VU:CaptureController() VU:ClickButton2(Vector2.new()) end
    end)
end)

print("GUI Loaded! Siap jadi Bos Nuklir Tuan! ☢️")
