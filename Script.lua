local player = game.Players.LocalPlayer

-- 🌟 UI đẹp
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "AutoEventUI"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,200,0,120)
main.Position = UDim2.new(0.5,-100,0.7,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)

-- viền xanh
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(0,170,255)
stroke.Thickness = 2

-- bo góc
Instance.new("UICorner", main)

-- 🔘 nút auto event
local btn = Instance.new("TextButton", main)
btn.Size = UDim2.new(0,160,0,40)
btn.Position = UDim2.new(0.5,-80,0,10)
btn.Text = "AUTO EVENT"
btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
btn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", btn)

-- 🔘 nút tạo fake
local testBtn = Instance.new("TextButton", main)
testBtn.Size = UDim2.new(0,160,0,40)
testBtn.Position = UDim2.new(0.5,-80,0,60)
testBtn.Text = "CREATE TEST"
testBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
testBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", testBtn)

local enabled = false
local fakePedestal = nil

-- 🎯 bật/tắt auto
btn.MouseButton1Click:Connect(function()
    enabled = not enabled
    btn.Text = enabled and "STOP" or "AUTO EVENT"
end)

-- 🧪 tạo/destroy fake pedestal
testBtn.MouseButton1Click:Connect(function()
    if fakePedestal then
        fakePedestal:Destroy()
        fakePedestal = nil
        testBtn.Text = "CREATE TEST"
        print("❌ Removed fake")
    else
        local part = Instance.new("Part")
        part.Name = "EasterBaseSkinPedestal"
        part.Size = Vector3.new(4,8,4)
        part.Position = player.Character.HumanoidRootPart.Position + Vector3.new(0,30,0)
        part.Anchored = true
        part.Parent = workspace

        -- prompt test
        local prompt = Instance.new("ProximityPrompt", part)
        prompt.HoldDuration = 0
        prompt.RequiresLineOfSight = false

        fakePedestal = part
        testBtn.Text = "REMOVE TEST"
        print("✅ Created fake pedestal")
    end
end)

-- 🚀 auto bay
task.spawn(function()
    while true do
        if enabled then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")

            if hrp and hum then
                for _,v in pairs(workspace:GetDescendants()) do
                    if v.Name == "EasterBaseSkinPedestal" then
                        local part = v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart")

                        if part then
                            local target = part.Position + Vector3.new(0,10,0)

                            for i = 1,15 do
                                hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(target), 0.35)
                                hrp.Velocity = Vector3.zero
                                task.wait(0.02)
                            end

                            hum.PlatformStand = true
                            hrp.Velocity = Vector3.zero
                            task.wait(0.15)

                            for _,p in pairs(v:GetDescendants()) do
                                if p:IsA("ProximityPrompt") then
                                    fireproximityprompt(p)
                                    print("✅ PROMPT")
                                end
                            end

                            hum.PlatformStand = false
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)
