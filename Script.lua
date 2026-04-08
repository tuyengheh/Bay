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
    main.Size = UDim2.new(0,220,0,320)
    main.Position = UDim2.new(0.5,-110,0.65,0)
    main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    main.Active = true
    main.Draggable = true
    Instance.new("UICorner", main)

    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(0,170,255)
    stroke.Thickness = 2

    -- AUTO EVENT
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0,170,0,35)
    btn.Position = UDim2.new(0.5,-85,0,10)
    btn.Text = "AUTO EVENT"
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)

    -- TELE BASE
    local baseBtn = Instance.new("TextButton", main)
    baseBtn.Size = UDim2.new(0,170,0,35)
    baseBtn.Position = UDim2.new(0.5,-85,0,55)
    baseBtn.Text = "TELE BASE"
    baseBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
    baseBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", baseBtn)

    -- FIX LAG
    local lagBtn = Instance.new("TextButton", main)
    lagBtn.Size = UDim2.new(0,170,0,30)
    lagBtn.Position = UDim2.new(0.5,-85,0,100)
    lagBtn.Text = "FIX LAG"
    lagBtn.BackgroundColor3 = Color3.fromRGB(170,100,0)
    lagBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", lagBtn)

    -- XRAY
    local xrayBtn = Instance.new("TextButton", main)
    xrayBtn.Size = UDim2.new(0,170,0,30)
    xrayBtn.Position = UDim2.new(0.5,-85,0,140)
    xrayBtn.Text = "XRAY BASE"
    xrayBtn.BackgroundColor3 = Color3.fromRGB(120,0,170)
    xrayBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", xrayBtn)

    -- SPEED
    local speedBtn = Instance.new("TextButton", main)
    speedBtn.Size = UDim2.new(0,170,0,30)
    speedBtn.Position = UDim2.new(0.5,-85,0,180)
    speedBtn.Text = "SPEED OFF"
    speedBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
    speedBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", speedBtn)

    -- ✨ FADE IN
    main.BackgroundTransparency = 1
    for _,v in pairs(main:GetDescendants()) do
        if v:IsA("TextButton") then
            v.TextTransparency = 1
        end
    end

    task.spawn(function()
        for i = 1,10 do
            main.BackgroundTransparency -= 0.1
            for _,v in pairs(main:GetDescendants()) do
                if v:IsA("TextButton") then
                    v.TextTransparency -= 0.1
                end
            end
            task.wait(0.03)
        end
    end)

    return gui, main, btn, baseBtn, lagBtn, xrayBtn, speedBtn
end

local gui, main, btn, baseBtn, lagBtn, xrayBtn, speedBtn = createGui()

-- 🎈 HIỆU ỨNG BONG BÓNG + KIM TUYẾN
task.spawn(function()
    while true do
        local bubble = Instance.new("Frame", main)
        bubble.Size = UDim2.new(0, math.random(6,12), 0, math.random(6,12))
        bubble.Position = UDim2.new(math.random(), 0, 1, 0)
        bubble.BackgroundColor3 = Color3.fromRGB(math.random(100,255),math.random(100,255),255)
        bubble.BackgroundTransparency = 0.3
        bubble.BorderSizePixel = 0
        Instance.new("UICorner", bubble).CornerRadius = UDim.new(1,0)

        task.spawn(function()
            for i = 1,40 do
                bubble.Position -= UDim2.new(0,0,0.025,0)
                bubble.BackgroundTransparency += 0.02
                task.wait(0.03)
            end
            bubble:Destroy()
        end)

        task.wait(0.2)
    end
end)

-- 💥 CLICK EFFECT
local function clickEffect(b)
    b.MouseButton1Down:Connect(function()
        b.Size = b.Size - UDim2.new(0,4,0,4)
    end)
    b.MouseButton1Up:Connect(function()
        b.Size = b.Size + UDim2.new(0,4,0,4)
    end)
end

clickEffect(btn)
clickEffect(baseBtn)
clickEffect(lagBtn)
clickEffect(xrayBtn)
clickEffect(speedBtn)

-- ⚙️ BIẾN
local enabled = false
local xrayEnabled = false
local speedOn = false

-- AUTO EVENT
btn.MouseButton1Click:Connect(function()
    enabled = not enabled
    btn.Text = enabled and "STOP" or "AUTO EVENT"
end)

-- 🚶 SPEED
speedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    speedBtn.Text = speedOn and "SPEED 30" or "SPEED OFF"
end)

task.spawn(function()
    while true do
        local hum = player.Character and player.Character:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = speedOn and 30 or 16
        end
        task.wait(0.5)
    end
end)

-- 🚀 TELE MƯỢT (KHÔNG LỖI)
local function smoothTeleport(targetPos)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local start = hrp.Position
    local dist = (targetPos - start).Magnitude
    local steps = math.clamp(math.floor(dist/25), 10, 40)

    for i = 1, steps do
        local pos = start:Lerp(targetPos, i/steps)
        hrp.CFrame = CFrame.new(pos + Vector3.new(0,2,0))
        hrp.Velocity = Vector3.zero
        task.wait(0.03)
    end

    local t = tick()
    while tick() - t < 2.2 do
        hrp.Velocity = Vector3.zero
        task.wait(0.1)
    end
end

-- 🏠 TELE BASE
baseBtn.MouseButton1Click:Connect(function()
    if basePosition then
        smoothTeleport(basePosition)
    end
end)

-- ⚡ FIX LAG
lagBtn.MouseButton1Click:Connect(function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
    game.Lighting.GlobalShadows = false
end)

-- 👁️ XRAY
xrayBtn.MouseButton1Click:Connect(function()
    xrayEnabled = not xrayEnabled
    xrayBtn.Text = xrayEnabled and "XRAY ON" or "XRAY BASE"

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local n = v.Name:lower()
            if n:find("wall") or n:find("house") then
                v.LocalTransparencyModifier = xrayEnabled and 0.7 or 0
            end
        end
    end
end)
