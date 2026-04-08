-- 🧠 PLAYER
local player = game.Players.LocalPlayer

-- 📍 BASE
local basePosition = nil

player.CharacterAdded:Connect(function(char)
    local hrp = char:WaitForChild("HumanoidRootPart")
    task.wait(0.5)
    basePosition = hrp.Position
end)

-- ⚙️ AUTO ON
local enabled = true
local speedOn = true
local xrayEnabled = true

-- 🧪 FAKE EVENT (TEST)
task.spawn(function()
    task.wait(2)

    if not workspace:FindFirstChild("EasterBaseSkinPedestal") then
        local part = Instance.new("Part")
        part.Name = "EasterBaseSkinPedestal"
        part.Size = Vector3.new(4,8,4)
        part.Position = Vector3.new(0,300,0)
        part.Anchored = true
        part.Parent = workspace

        local prompt = Instance.new("ProximityPrompt", part)
        prompt.HoldDuration = 0
        prompt.RequiresLineOfSight = false

        print("🧪 Fake event created")
    end
end)

-- 🚶 SPEED 30 AUTO
task.spawn(function()
    while true do
        local hum = player.Character and player.Character:FindFirstChild("Humanoid")
        if hum and speedOn then
            hum.WalkSpeed = 30
        end
        task.wait(0.3)
    end
end)

-- 🚀 TELE MƯỢT
local function smoothTeleport(targetPos)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local start = hrp.Position
    local dist = (targetPos - start).Magnitude
    local steps = math.clamp(math.floor(dist/25), 10, 40)

    for i = 1, steps do
        local pos = start:Lerp(targetPos, i/steps)
        hrp.CFrame = CFrame.new(pos + Vector3.new(0,2,0))
        hrp.Velocity = Vector3.zero
        task.wait(0.03)
    end

    -- đứng yên cho game nhận
    local t = tick()
    while tick() - t < 2 do
        hrp.Velocity = Vector3.zero
        task.wait(0.1)
    end
end

-- 👁️ XRAY AUTO
task.spawn(function()
    while true do
        if xrayEnabled then
            for _,v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    local n = v.Name:lower()
                    if n:find("wall") or n:find("house") then
                        v.LocalTransparencyModifier = 0.6
                    end
                end
            end
        end
        task.wait(2)
    end
end)

-- ⚡ FIX LAG AUTO
task.spawn(function()
    task.wait(1)

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end

    game.Lighting.GlobalShadows = false
    print("⚡ Fix lag applied")
end)

-- 🔁 AUTO EVENT
task.spawn(function()
    while true do
        if enabled then
            for _,v in pairs(workspace:GetDescendants()) do
                if v.Name == "EasterBaseSkinPedestal" then

                    local part = v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart")

                    if part then
                        print("🎯 FOUND EVENT")

                        smoothTeleport(part.Position)

                        -- auto E
                        for _,p in pairs(v:GetDescendants()) do
                            if p:IsA("ProximityPrompt") then
                                fireproximityprompt(p)
                                print("✅ PROMPT USED")
                            end
                        end

                        task.wait(1)
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)
