-- [[ SIGMA NUKE V2 - FIXED & MINIMIZE ]] --
local CoreGui = game:GetService("CoreGui")
local Plr = game.Players.LocalPlayer

-- Hapus yang lama
if CoreGui:FindFirstChild("SigmaNuke") then CoreGui.SigmaNuke:Destroy() end

local SG = Instance.new("ScreenGui", CoreGui)
SG.Name = "SigmaNuke"

-- --- MAIN FRAME ---
local Main = Instance.new("Frame", SG)
Main.Size, Main.Position = UDim2.new(0, 350, 0, 280), UDim2.new(0.4, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active, Main.Draggable = true, true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(0, 255, 150)

-- --- MINIMIZE SYSTEM ---
local MinBtn = Instance.new("TextButton", SG)
MinBtn.Size, MinBtn.Position = UDim2.new(0, 50, 0, 50), UDim2.new(0.1, 0, 0.1, 0)
MinBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
MinBtn.Text, MinBtn.TextSize = "X", 20
MinBtn.TextColor3 = Color3.new(0,0,0)
MinBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", MinBtn).Thickness = 2

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    MinBtn.Text = Main.Visible and "X" or "S"
end)

-- --- FUNGSI AUTO-FARM FIXED ---
local function GetMyTycoon()
    for _, t in pairs(workspace.Tycoons:GetChildren()) do
        if t:FindFirstChild("Owner") and t.Owner.Value == Plr.Name then
            return t
        end
    end
    return nil
end

-- 1. Auto Collect Money (FIXED)
local function CollectFunc(v)
    _G.Collect = v
    task.spawn(function()
        while _G.Collect do
            local MyTycoon = GetMyTycoon()
            if MyTycoon then
                -- Cari tombol collect/giver di dalam tycoon lo
                for _, obj in pairs(MyTycoon:GetDescendants()) do
                    if (obj.Name == "Collect" or obj.Name == "Giver" or obj.Name:find("Collect")) and obj:IsA("TouchTransmitter") then
                        firetouchinterest(Plr.Character.HumanoidRootPart, obj.Parent, 0)
                        firetouchinterest(Plr.Character.HumanoidRootPart, obj.Parent, 1)
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end

-- 2. Auto Buy Buttons (FIXED)
local function BuyFunc(v)
    _G.Buy = v
    task.spawn(function()
        while _G.Buy do
            local MyTycoon = GetMyTycoon()
            if MyTycoon then
                for _, b in pairs(MyTycoon:GetDescendants()) do
                    if b.Name == "Button" or b.Name == "Purchase" or b:FindFirstChild("TouchInterest") then
                        if b:IsA("BasePart") and b.Transparency < 1 then
                            firetouchinterest(Plr.Character.HumanoidRootPart, b, 0)
                            firetouchinterest(Plr.Character.HumanoidRootPart, b, 1)
                        end
                    end
                end
            end
            task.wait(1)
        end
    end)
end

-- --- UI BUTTONS (Scroll) ---
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size, Scroll.Position = UDim2.new(1, -20, 1, -50), UDim2.new(0, 10, 0, 45)
Scroll.BackgroundTransparency, Scroll.CanvasSize = 1, UDim2.new(0, 0, 2, 0)
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 5)

local function AddToggle(txt, callback)
    local B = Instance.new("TextButton", Scroll)
    B.Size, B.BackgroundColor3 = UDim2.new(1, 0, 0, 40), Color3.fromRGB(30,30,40)
    B.Text, B.TextColor3 = "OFF | "..txt, Color3.new(1,1,1)
    Instance.new("UICorner", B)
    local on = false
    B.MouseButton1Click:Connect(function()
        on = not on
        B.Text = (on and "ON | " or "OFF | ")..txt
        B.BackgroundColor3 = on and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(30,30,40)
        callback(on)
    end)
end

AddToggle("Auto Collect Money", CollectFunc)
AddToggle("Auto Buy Buttons", BuyFunc)
AddToggle("Infinite Jump", function(v)
    _G.InfJ = v
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfJ then Plr.Character.Humanoid:ChangeState("Jumping") end
    end)
end)

print("Sigma Nuke V2 Loaded! 🚀")
