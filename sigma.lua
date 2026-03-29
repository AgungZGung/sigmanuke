-- [[ SIGMA NUKE V3 - HYBRID EDITION ]] --
local Plr = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Hapus GUI lama
if CoreGui:FindFirstChild("SigmaNuke") then CoreGui.SigmaNuke:Destroy() end

local function getNil(name, class)
    for _, v in pairs(getnilinstances()) do
        if v.ClassName == class and v.Name == name then return v end
    end
end

-- --- UI SETUP ---
local SG = Instance.new("ScreenGui", CoreGui)
SG.Name = "SigmaNuke"
local Main = Instance.new("Frame", SG)
Main.Size, Main.Position = UDim2.new(0, 350, 0, 300), UDim2.new(0.4, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active, Main.Draggable = true, true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(0, 255, 150)

-- --- FEATURES ---

-- 1. REMOTE COLLECT (Pake ID Terbaru Tuan)
local function CollectFunc(v)
    _G.Collect = v
    task.spawn(function()
        while _G.Collect do
            local args = {
                [1] = {
                    ["Received"] = 6,
                    ["Loader"] = getNil("", "Folder").ClientMover,
                    ["Mode"] = "Fire",
                    ["Sent"] = 10,
                    ["Module"] = getNil("Client", "ModuleScript")
                },
                [2] = "u\n\11\3_B&YHV\\",
                [3] = {["Received"] = 6, ["Sent"] = 9},
                [4] = "18654411-1bc4-41ae-bb06-2f78fac95ec1"
            }
            local Remote = game:GetService("ReplicatedStorage"):FindFirstChild("df523965-a98d-4d1f-a088-1e41b29e9ab2")
            if Remote then Remote:FireServer(unpack(args)) end
            task.wait(0.1)
        end
    end)
end

-- 2. GHOST TOUCH BUY (Buat tombol injek)
local function BuyFunc(v)
    _G.Buy = v
    task.spawn(function()
        while _G.Buy do
            -- Nyari Tycoon punya lo
            local MyTycoon
            for _, t in pairs(workspace.Tycoons:GetChildren()) do
                if t:FindFirstChild("Owner") and t.Owner.Value == Plr.Name then
                    MyTycoon = t; break
                end
            end
            
            if MyTycoon then
                for _, b in pairs(MyTycoon:GetDescendants()) do
                    -- Nyari tombol yang transparan (artinya bisa dibeli)
                    if (b.Name == "Button" or b.Name == "Purchase" or b:FindFirstChild("TouchInterest")) and b:IsA("BasePart") then
                        if b.Transparency < 1 then
                            firetouchinterest(Plr.Character.HumanoidRootPart, b, 0)
                            firetouchinterest(Plr.Character.HumanoidRootPart, b, 1)
                        end
                    end
                end
            end
            task.wait(0.5) -- Biar gak lag pas scan tombol
        end
    end)
end

-- --- MINIMIZE SYSTEM ---
local MinBtn = Instance.new("TextButton", SG)
MinBtn.Size, MinBtn.Position = UDim2.new(0, 40, 0, 40), UDim2.new(0.05, 0, 0.1, 0)
MinBtn.Text, MinBtn.BackgroundColor3 = "X", Color3.fromRGB(0, 255, 150)
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)
MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    MinBtn.Text = Main.Visible and "X" or "S"
end)

-- --- UI LIST LAYOUT ---
local L = Instance.new("UIListLayout", Main)
L.Padding, L.HorizontalAlignment = UDim.new(0, 10), Enum.HorizontalAlignment.Center

local function AddToggle(txt, func)
    local B = Instance.new("TextButton", Main)
    B.Size, B.Text = UDim2.new(0.9, 0, 0, 45), "OFF | "..txt
    B.BackgroundColor3 = Color3.fromRGB(30,30,40)
    B.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", B)
    local on = false
    B.MouseButton1Click:Connect(function()
        on = not on
        B.Text = (on and "ON | " or "OFF | ")..txt
        B.BackgroundColor3 = on and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(30,30,40)
        func(on)
    end)
end

AddToggle("Auto Collect (REMOTE)", CollectFunc)
AddToggle("Auto Buy (GHOST TOUCH)", BuyFunc)

print("Sigma Nuke V3 Loaded! ☢️💰")
