-- 🧠 PLAYER
local player = game.Players.LocalPlayer

-- ⚙️ BIẾN
local autoEvent = false
local speedOn = false
local xrayOn = false
local fakePart = nil

-- 🌟 GUI
local function createGui()

    local old = player.PlayerGui:FindFirstChild("AutoEventUI")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "AutoEventUI"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0,220,0,300)
    main.Position = UDim2.new(0.5,-110,0.65,0)
    main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    main.Active = true
    main.Draggable = true
    Instance.new("UICorner", main)

    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(0,170,255)

    -- BUTTON TEMPLATE
    local function makeBtn(text, y, color)
        local b = Instance.new("TextButton", main)
        b.Size = UDim2.new(0,170,0,35)
        b.Position = UDim2.new(0.5,-85,0,y)
        b.Text = text
        b.BackgroundColor3 = color
        b.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", b)
        return b
    end

    local autoBtn = makeBtn("AUTO EVENT OFF",10,Color3.fromRGB(40,40,40))
    local speedBtn = makeBtn("SPEED OFF",55,Color3.fromRGB(0,170,0))
    local xrayBtn = makeBtn("XRAY OFF",100,Color3.fromRGB(120,0,170))
    local lagBtn = makeBtn("FIX LAG",145,Color3.fromRGB(170,100,0))
    local testBtn = makeBtn("CREATE TEST",190,Color3.fromRGB(0,120,255))

    return main, autoBtn, speedBtn, xrayBtn, lagBtn, testBtn
end

local main, autoBtn, speedBtn, xrayBtn, lagBtn, testBtn = createGui()

-- 🎈 BONG BÓNG
task.spawn(function()
    while true do
        local b = Instance.new("Frame", main)
        b.Size = UDim2.new(0,math.random(6,12),0,math.random(6,12))
        b.Position = UDim2.new(math.random(),0,1,0)
        b.BackgroundColor3 = Color3.fromRGB(math.random(100,255),math.random(100,255),255)
        b.BackgroundTransparency = 0.3
        b.BorderSizePixel = 0
        Instance.new("UICorner", b)

        task.spawn(function()
            for i=1,40 do
                b.Position -= UDim2.new(0,0,0.025,0)
                b.BackgroundTransparency += 0.02
                task.wait(0.03)
            end
            b:Destroy()
        end)

        task.wait(0.2)
    end
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
        task.wait(0.3)
    end
end)

-- 👁️ XRAY
xrayBtn.MouseButton1Click:Connect(function()
    xrayOn = not xrayOn
    xrayBtn.Text = xrayOn and "XRAY ON" or "XRAY OFF"

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local n = v.Name:lower()
            if n:find("wall") or n:find("house") then
                v.LocalTransparencyModifier = xrayOn and 0.6 or 0
            end
        end
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
    print("⚡ Lag fixed")
end)

-- 🧪 FAKE EVENT
testBtn.MouseButton1Click:Connect(function()
    if fakePart then
        fakePart:Destroy()
        fakePart = nil
        testBtn.Text = "CREATE TEST"
    else
        local part = Instance.new("Part")
        part.Name = "EasterBaseSkinPedestal"
        part.Size = Vector3.new(40,80,40)
        part.Position = player.Character.HumanoidRootPart.Position + Vector3.new(0,200,0)
        part.Anchored = true
        part.Parent = workspace

        local prompt = Instance.new("ProximityPrompt", part)
        prompt.HoldDuration = 0

        fakePart = part
        testBtn.Text = "REMOVE TEST"
    end
end)

-- 🚀 TELE
local function smoothTeleport(pos)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local start = hrp.Position
    local dist = (pos - start).Magnitude
    local steps = math.clamp(math.floor(dist/25),10,40)

    for i=1,steps do
        local p = start:Lerp(pos,i/steps)
        hrp.CFrame = CFrame.new(p + Vector3.new(0,2,0))
        hrp.Velocity = Vector3.zero
        task.wait(0.03)
    end

    local t = tick()
    while tick()-t < 2 do
        hrp.Velocity = Vector3.zero
        task.wait(0.1)
    end
end

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
