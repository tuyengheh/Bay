-- 🧠 PLAYER
local player = game.Players.LocalPlayer

-- 📍 BASE
local basePosition = nil

player.CharacterAdded:Connect(function(char)
    local hrp = char:WaitForChild("HumanoidRootPart")
    task.wait(0.5)
    basePosition = hrp.Position
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
    main.Size = UDim2.new(0,200,0,260)
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

    -- FIX LAG
    local lagBtn = Instance.new("TextButton", main)
    lagBtn.Size = UDim2.new(0,160,0,30)
    lagBtn.Position = UDim2.new(0.5,-80,0,145)
    lagBtn.Text = "FIX LAG"
    lagBtn.BackgroundColor3 = Color3.fromRGB(170,100,0)
    lagBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", lagBtn)

    -- XRAY
    local xrayBtn = Instance.new("TextButton", main)
    xrayBtn.Size = UDim2.new(0,160,0,30)
    xrayBtn.Position = UDim2.new(0.5,-80,0,185)
    xrayBtn.Text = "XRAY BASE"
    xrayBtn.BackgroundColor3 = Color3.fromRGB(120,0,170)
    xrayBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", xrayBtn)

    return gui, btn, testBtn, baseBtn, lagBtn, xrayBtn
end

local gui, btn, testBtn, baseBtn, lagBtn, xrayBtn = createGui()

-- 🔁 RESPAWN
player.CharacterAdded:Connect(function()
    task.wait(0.5)
    if not player.PlayerGui:FindFirstChild("AutoEventUI") then
        gui, btn, testBtn, baseBtn, lagBtn, xrayBtn = createGui()
    end
end)

-- ⚙️ BIẾN
local enabled = false
local fake = nil
local xrayEnabled = false

btn.MouseButton1Click:Connect(function()
    enabled = not enabled
    btn.Text = enabled and "STOP" or "AUTO EVENT"
end)

-- 🧪 TEST
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

-- 🚶 SPEED 30
task.spawn(function()
    while true do
        local hum = player.Character and player.Character:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = 30
        end
        task.wait(0.5)
    end
end)

-- 🚀 TELE
local function stepTeleport(pos)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local cur = hrp.Position
    for i = 1,5 do
        hrp.CFrame = CFrame.new(cur:Lerp(pos, i/5))
        task.wait(0.05)
    end
end

-- 🛑 ĐỨNG YÊN
local function stayStill(t)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local s = tick()
    while tick() - s < t do
        hrp.Velocity = Vector3.zero
        task.wait(0.1)
    end
end

-- 🧠 TELE LEGIT
local function legitTeleport(pos)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    local near = pos - (hrp.CFrame.LookVector * 6)
    stepTeleport(near)

    task.wait(0.2)

    hum:MoveTo(pos)

    local done = false
    hum.MoveToFinished:Connect(function()
        done = true
    end)

    local t = tick()
    while not done and tick() - t < 2 do
        task.wait()
    end

    stayStill(2.3)
end

-- 🏠 TELE BASE
baseBtn.MouseButton1Click:Connect(function()
    if basePosition then
        legitTeleport(basePosition)
    end
end)

-- ⚡ FIX LAG (SAFE)
lagBtn.MouseButton1Click:Connect(function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or
           v:IsA("Trail") or
           v:IsA("Smoke") or
           v:IsA("Fire") then
            v.Enabled = false
        end

        if v:IsA("PointLight") or
           v:IsA("SpotLight") or
           v:IsA("SurfaceLight") then
            v.Enabled = false
        end
    end

    game.Lighting.GlobalShadows = false
end)

-- 👁️ XRAY BASE
xrayBtn.MouseButton1Click:Connect(function()
    xrayEnabled = not xrayEnabled
    xrayBtn.Text = xrayEnabled and "XRAY ON" or "XRAY BASE"

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local name = v.Name:lower()

            if name:find("wall") or name:find("house") or name:find("base") then
                if xrayEnabled then
                    v.LocalTransparencyModifier = 0.7
                else
                    v.LocalTransparencyModifier = 0
                end
            end
        end
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
                        legitTeleport(part.Position)

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
