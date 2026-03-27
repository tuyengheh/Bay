-- chống load lại
if getgenv().FlyLoaded then return end
getgenv().FlyLoaded = true

local player = game.Players.LocalPlayer
local active = false
local conn

-- UI
pcall(function()
    game.CoreGui:FindFirstChild("FlyGui"):Destroy()
end)

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FlyGui"

local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0,120,0,50)
btn.Position = UDim2.new(0,20,0,200)
btn.Text = "Fly: OFF"

btn.Active = true
btn.Draggable = true

btn.Activated:Connect(function()
    active = not active
    btn.Text = active and "Fly: ON" or "Fly: OFF"

    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")

    if active then
        conn = game:GetService("RunService").Heartbeat:Connect(function()
            -- kiểu "nhảy nhẹ liên tục"
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
            hrp.Velocity = Vector3.new(0, 6, 0)
        end)
    else
        if conn then conn:Disconnect() end
    end
end)
