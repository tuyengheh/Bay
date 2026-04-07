local player = game.Players.LocalPlayer

-- 🌟 GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,200,0,150)
main.Position = UDim2.new(0.5,-100,0.7,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(0,170,255)
stroke.Thickness = 2
Instance.new("UICorner", main)

-- 🔘 AUTO EVENT
local btn = Instance.new("TextButton", main)
btn.Size = UDim2.new(0,160,0,40)
btn.Position = UDim2.new(0.5,-80,0,10)
btn.Text = "AUTO EVENT"
btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
btn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", btn)

-- 🔘 TEST
local testBtn = Instance.new("TextButton", main)
testBtn.Size = UDim2.new(0,160,0,40)
testBtn.Position = UDim2.new(0.5,-80,0,60)
testBtn.Text = "CREATE HIGH TEST"
testBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
btn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", testBtn)

local enabled = false
local fake = nil

btn.MouseButton1Click:Connect(function()
    enabled = not enabled
    btn.Text = enabled and "STOP" or "AUTO EVENT"
end)

-- 🧪 Fake rất cao (test anti)
testBtn.MouseButton1Click:Connect(function()
    if fake then
        fake:Destroy()
        fake = nil
        testBtn.Text = "CREATE HIGH TEST"
    else
        local part = Instance.new("Part")
        part.Name = "EasterBaseSkinPedestal"
        part.Size = Vector3.new(4,8,4)
        part.Position = Vector3.new(0,2000,0) -- 🔥 cao 2000
        part.Anchored = true
        part.Parent = workspace

        local prompt = Instance.new("ProximityPrompt", part)
        prompt.HoldDuration = 0
        prompt.RequiresLineOfSight = false

        fake = part
        testBtn.Text = "REMOVE TEST"
        print("✅ Fake cao 2000 đã tạo")
    end
end)

-- 🚀 TELE NHANH + AUTO E
task.spawn(function()
    while true do
        if enabled then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if hrp then
                for _,v in pairs(workspace:GetDescendants()) do
                    if v.Name == "EasterBaseSkinPedestal" then
                        local part = v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart")

                        if part then
                            print("🎯 FOUND")

                            -- ⚡ TELE 1 PHÁT (không spam)
                            hrp.CFrame = CFrame.new(part.Position + Vector3.new(0,3,0))

                            task.wait(0.2) -- cho game ổn định

                            -- 🔘 AUTO E
                            for _,p in pairs(v:GetDescendants()) do
                                if p:IsA("ProximityPrompt") then
                                    fireproximityprompt(p)
                                    print("✅ PRESS E")
                                end
                            end
                        end
                    end
                end
            end
        end
        task.wait(0.3)
    end
end)
---------------------
local stopBtn = Instance.new("TextButton", main)
stopBtn.Size = UDim2.new(0,160,0,30)
stopBtn.Position = UDim2.new(0.5,-80,1,-35)
stopBtn.Text = "FORCE STOP"
stopBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
stopBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", stopBtn)

stopBtn.MouseButton1Click:Connect(function()
    enabled = false
    print("🛑 Force stopped")
end)
------------
local player = game.Players.LocalPlayer

-- 🔁 Hàm tạo GUI
local function createGui()
    local old = player.PlayerGui:FindFirstChild("AutoEventUI")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "AutoEventUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0,200,0,120)
    main.Position = UDim2.new(0.5,-100,0.7,0)
    main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    main.Active = true
    main.Draggable = true

    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(0,170,255)
    stroke.Thickness = 2

    Instance.new("UICorner", main)

    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0,160,0,40)
    btn.Position = UDim2.new(0.5,-80,0,10)
    btn.Text = "AUTO EVENT"
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)

    return gui
end

-- 🌟 tạo lần đầu
local gui = createGui()

-- 🔁 respawn vẫn giữ GUI
player.CharacterAdded:Connect(function()
    task.wait(0.5)
    if not player.PlayerGui:FindFirstChild("AutoEventUI") then
        gui = createGui()
        print("🔁 GUI restored after death")
    end
end)
