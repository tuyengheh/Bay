local player = game.Players.LocalPlayer

-- 🌟 UI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "AutoEventUI"

local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0,170,0,50)
btn.Position = UDim2.new(0.5,-85,0.8,0)
btn.Text = "AUTO EVENT"
btn.BackgroundColor3 = Color3.fromRGB(0,170,255)

local enabled = false

btn.MouseButton1Click:Connect(function()
    enabled = not enabled
    btn.Text = enabled and "STOP" or "AUTO EVENT"
end)

-- 🚀 Auto bay tới pedestal
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
                            print("🎯 FOUND")

                            -- 📍 target cao hơn để không bị thấp
                            local target = part.Position + Vector3.new(0,10,0)

                            -- 🚀 bay nhanh + mượt
                            for i = 1,15 do
                                hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(target), 0.35)
                                hrp.Velocity = Vector3.zero
                                task.wait(0.02)
                            end

                            -- 🛑 chống rơi
                            hum.PlatformStand = true
                            hrp.Velocity = Vector3.zero
                            task.wait(0.15)

                            -- 🔘 auto prompt
                            for _,p in pairs(v:GetDescendants()) do
                                if p:IsA("ProximityPrompt") then
                                    p.HoldDuration = 0
                                    fireproximityprompt(p)
                                    print("✅ PROMPT")
                                end
                            end

                            -- 🔘 click phụ
                            local click = v:FindFirstChildOfClass("ClickDetector")
                            if click then
                                fireclickdetector(click)
                                print("✅ CLICK")
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
