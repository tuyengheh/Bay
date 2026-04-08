-- 🧠 PLAYER
local player = game.Players.LocalPlayer

-- 📍 LƯU BASE
local basePosition = nil

player.CharacterAdded:Connect(function(char)
    local hrp = char:WaitForChild("HumanoidRootPart")
    task.wait(0.5)
    basePosition = hrp.Position
    print("📍 Saved base")
end)

-- 🌟 GUI
local function createGui()

    local old = player.PlayerGui:FindFirstChild("AutoEventUI")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "AutoEventUI"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0,200,0,180)
    main.Position = UDim2.new(0.5,-100,0.7,0)
    main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    main.Active = true
    main.Draggable = true

    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(0,170,255)
    stroke.Thickness = 2

    Instance.new("UICorner", main)

    -- AUTO EVENT
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0,160,0,35)
    btn.Position = UDim2.new(0.5,-80,0,10)
    btn.Text = "AUTO EVENT"
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)

    -- TEST
    local testBtn = Instance.new("TextButton", main)
    testBtn.Size = UDim2.new(0,160,0,35)
    testBtn.Position = UDim2.new(0.5,-80,0,55)
    testBtn.Text = "CREATE TEST"
    testBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    testBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", testBtn)

    -- TELE BASE
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

-- 🔁 KHÔNG MẤT GUI
player.CharacterAdded:Connect(function()
    task.wait(0.5)
    if not player.PlayerGui:FindFirstChild("AutoEventUI") then
        gui, btn, testBtn, baseBtn = createGui()
    end
end)

-- ⚙️ BIẾN
local enabled = false
local fake = nil

btn.MouseButton1Click:Connect(function()
    enabled = not enabled
    btn.Text = enabled and "STOP" or "AUTO EVENT"
end)

-- 🧪 FAKE TEST 2000
testBtn.MouseButton1Click:Connect(function()
    if fake then
        fake:Destroy()
        fake = nil
        testBtn.Text = "CREATE TEST"
    else
        local part = Instance.new("Part")
        part.Name = "EasterBaseSkinPedestal"
        part.Size = Vector3.new(4,8,4)
        part.Position = Vector3.new(0,2000,0)
        part.Anchored = true
        part.Parent = workspace

        local prompt = Instance.new("ProximityPrompt", part)
        prompt.HoldDuration = 0
        prompt.RequiresLineOfSight = false

        fake = part
        testBtn.Text = "REMOVE TEST"
    end
end)

-- 🚀 TELE CHIA BƯỚC (ANTI-CHEAT)
local function stepTeleport(targetPos)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local current = hrp.Position
    local distance = (targetPos - current).Magnitude
    local steps = math.clamp(math.floor(distance / 60), 2, 10)

    for i = 1, steps do
        local pos = current:Lerp(targetPos, i/steps)
        hrp.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
        task.wait(0.05)
    end
end

-- 🛑 GIỮ ĐỨNG YÊN
local function stayStill(seconds)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local t = tick()
    while tick() - t < seconds do
        hrp.Velocity = Vector3.zero
        task.wait(0.1)
    end
end

-- 🧠 TELE THÔNG MINH (XOAY + TIẾN NHẸ)
local function smartForwardTeleport(targetPos)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- tele tới gần
    stepTeleport(targetPos)

    -- xoay mặt đúng hướng
    hrp.CFrame = CFrame.new(hrp.Position, targetPos)

    task.wait(0.1)

    -- tiến nhẹ phía trước
    hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * 3)

    -- đứng yên 2s
    stayStill(2)
end

-- 🏠 TELE BASE
baseBtn.MouseButton1Click:Connect(function()
    if basePosition then
        smartForwardTeleport(basePosition)
        print("🏠 Tele base chuẩn")
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

                        -- 🚀 TELE CHUẨN
                        smartForwardTeleport(part.Position)

                        -- 🔘 AUTO E
                        for _,p in pairs(v:GetDescendants()) do
                            if p:IsA("ProximityPrompt") then
                                fireproximityprompt(p)
                            end
                        end

                        task.wait(0.5)
                    end
                end
            end
        end
        task.wait(0.3)
    end
end)
