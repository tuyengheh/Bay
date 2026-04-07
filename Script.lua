local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- 🌟 GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "AutoEventUI"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,200,0,120)
main.Position = UDim2.new(0.5,-100,0.7,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true -- ✅ kéo được

-- viền xanh đẹp
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
testBtn.Text = "CREATE TEST"
testBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
testBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", testBtn)

local enabled = false
local fakePedestal = nil

btn.MouseButton1Click:Connect(function()
    enabled = not enabled
    btn.Text = enabled and "STOP" or "AUTO EVENT"
end)

-- 🧪 tạo fake để test
testBtn.MouseButton1Click:Connect(function()
    if fakePedestal then
        fakePedestal:Destroy()
        fakePedestal = nil
        testBtn.Text = "CREATE TEST"
    else
        local part = Instance.new("Part")
        part.Name = "EasterBaseSkinPedestal"
        part.Size = Vector3.new(4,8,4)
        part.Position = player.Character.HumanoidRootPart.Position + Vector3.new(0,20,0)
        part.Anchored = true
        part.Parent = workspace

        local prompt = Instance.new("ProximityPrompt", part)
        prompt.HoldDuration = 0
        prompt.RequiresLineOfSight = false

        fakePedestal = part
        testBtn.Text = "REMOVE TEST"
    end
end)

-- 🚀 bay an toàn (Tween)
local function flyTo(pos)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local tween = TweenService:Create(
        hrp,
        TweenInfo.new(1.5, Enum.EasingStyle.Linear), -- bay chậm hơn => tránh anti cheat
        {CFrame = CFrame.new(pos)}
    )
    tween:Play()
    tween.Completed:Wait()
end

-- 🔁 loop
task.spawn(function()
    while true do
        if enabled then
            for _,v in pairs(workspace:GetDescendants()) do
                if v.Name == "EasterBaseSkinPedestal" then
                    local part = v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart")

                    if part then
                        print("🎯 FOUND")

                        -- bay tới (mượt)
                        flyTo(part.Position + Vector3.new(0,5,0))

                        task.wait(0.3)

                        -- trigger prompt
                        for _,p in pairs(v:GetDescendants()) do
                            if p:IsA("ProximityPrompt") then
                                fireproximityprompt(p)
                                print("✅ PROMPT")
                            end
                        end
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)
