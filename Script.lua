-- ⚡ Loadstring demo EasterBaseSkinPedestal
local player = game.Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- 🔹 Tạo pedestal demo
local pedestalName = "EasterBaseSkinPedestal"
if Workspace:FindFirstChild(pedestalName) then
    Workspace[pedestalName]:Destroy()
end

local pedestal = Instance.new("Part")
pedestal.Name = pedestalName
pedestal.Size = Vector3.new(4,8,4)      -- chiều cao 8
pedestal.Position = Vector3.new(0,15,0) -- cao hơn mặt đất để test bay
pedestal.Anchored = true
pedestal.Parent = Workspace

-- 🔹 Thêm ProximityPrompt demo
local prompt = Instance.new("ProximityPrompt")
prompt.ActionText = "Collect"
prompt.ObjectText = "Easter Egg"
prompt.MaxActivationDistance = 20
prompt.RequiresLineOfSight = false
prompt.HoldDuration = 0
prompt.Parent = pedestal

-- 🔹 Thêm ClickDetector demo
local click = Instance.new("ClickDetector")
click.Parent = pedestal

print("✅ Demo EasterBaseSkinPedestal đã tạo xong!")

-- 🔹 AUTO EVENT SCRIPT để test bay + fire prompt
local autoEventBtn = Instance.new("BoolValue") -- demo button state
autoEventBtn.Name = "AutoEventBtn"
autoEventBtn.Value = true -- bật auto
autoEventBtn.Parent = player

task.spawn(function()
    while true do
        if autoEventBtn and autoEventBtn.Value then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            if hrp and hum then
                local target = pedestal.Position + Vector3.new(0,8,0)
                for i = 1,15 do
                    hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(target), 0.3)
                    hrp.Velocity = Vector3.zero
                    task.wait(0.03)
                end
                hrp.Velocity = Vector3.zero
                hum.PlatformStand = true
                task.wait(0.2)

                -- fire ProximityPrompt
                for _,p in pairs(pedestal:GetDescendants()) do
                    if p:IsA("ProximityPrompt") then
                        fireproximityprompt(p)
                        print("✅ PROMPT fired!")
                    end
                end

                -- fire ClickDetector
                local click = pedestal:FindFirstChildOfClass("ClickDetector")
                if click then
                    fireclickdetector(click)
                    print("✅ Click fired!")
                end

                hum.PlatformStand = false
            end
        end
        task.wait(0.1)
    end
end)
