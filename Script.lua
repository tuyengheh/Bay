-- 🧠 LẤY PLAYER
local player = game.Players.LocalPlayer

-- 📍 LƯU BASE
local basePosition = nil

player.CharacterAdded:Connect(function(char)
    local hrp = char:WaitForChild("HumanoidRootPart")
    task.wait(0.3)
    basePosition = hrp.Position
    print("📍 Saved base")
end)

-- 🌟 TẠO GUI
local function createGui()

    -- xoá GUI cũ nếu có
    local old = player.PlayerGui:FindFirstChild("AutoEventUI")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "AutoEventUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    -- khung chính
    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0,200,0,180)
    main.Position = UDim2.new(0.5,-100,0.7,0)
    main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    main.Active = true
    main.Draggable = true

    -- viền xanh
    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(0,170,255)
    stroke.Thickness = 2

    Instance.new("UICorner", main)

    -- 🔘 AUTO EVENT
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0,160,0,35)
    btn.Position = UDim2.new(0.5,-80,0,10)
    btn.Text = "AUTO EVENT"
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)

    -- 🔘 CREATE TEST
    local testBtn = Instance.new("TextButton", main)
    testBtn.Size = UDim2.new(0,160,0,35)
    testBtn.Position = UDim2.new(0.5,-80,0,55)
    testBtn.Text = "CREATE TEST"
    testBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    testBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", testBtn)

    -- 🔘 TELE BASE
    local baseBtn = Instance.new("TextButton", main)
    baseBtn.Size = UDim2.new(0,160,0,35)
    baseBtn.Position = UDim2.new(0.5,-80,0,100)
    baseBtn.Text = "TELE BASE"
    baseBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
    baseBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", baseBtn)

    return gui, btn, testBtn, baseBtn
end

local gui, btn, testBtn, baseBtn = createGui()

-- 🔁 RESPAWN KHÔNG MẤT GUI
player.CharacterAdded:Connect(function()
    task.wait(0.5)
    if not player.PlayerGui:FindFirstChild("AutoEventUI") then
        gui, btn, testBtn, baseBtn = createGui()
        print("🔁 GUI restored")
    end
end)

-- ⚙️ BIẾN
local enabled = false
local fake = nil

-- 🔘 BẬT AUTO
btn.MouseButton1Click:Connect(function()
    enabled = not enabled
    btn.Text = enabled and "STOP" or "AUTO EVENT"
end)

-- 🧪 TẠO FAKE CAO 2000
testBtn.MouseButton1Click:Connect(function()
    if fake then
        fake:Destroy()
        fake = nil
        testBtn.Text = "CREATE TEST"
    else
        local part = Instance.new("Part")
        part.Name = "EasterBaseSkinPedestal"
        part.Size = Vector3.new(4,8,4)
        part.Position = Vector3.new(0,2000,0) -- 🔥 cao
        part.Anchored = true
        part.Parent = workspace

        local prompt = Instance.new("ProximityPrompt", part)
        prompt.HoldDuration = 0
        prompt.RequiresLineOfSight = false

        fake = part
        testBtn.Text = "REMOVE TEST"
    end
end)

-- 🚀 TELE AN TOÀN
local function safeTeleport(pos)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- tele 2 bước tránh anti cheat
    hrp.CFrame = hrp.CFrame + Vector3.new(0,50,0)
    task.wait(0.1)
    hrp.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
end

-- 🏠 TELE BASE
baseBtn.MouseButton1Click:Connect(function()
    if basePosition then
        safeTeleport(basePosition)
        print("🏠 Tele base")
    else
        warn("❌ Chưa có base")
    end
end)

-- 🔁 AUTO EVENT
task.spawn(function()
    while true do
        if enabled then
            for _,v in pairs(workspace:GetDescendants()) do
                if v.Name == "EasterBaseSkinPedestal" then

                    local part = v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart")

                    if part then
                        print("🎯 FOUND")

                        -- 🚀 TELE TỚI EVENT
                        safeTeleport(part.Position)

                        task.wait(0.2)

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
        task.wait(0.4)
    end
end)
