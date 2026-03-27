local player = game.Players.LocalPlayer
local flying = false
local conn

local gui = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", gui)

btn.Size = UDim2.new(0,120,0,50)
btn.Position = UDim2.new(0,20,0,200)
btn.Text = "Fly: OFF"

btn.Active = true
btn.Draggable = true

btn.Activated:Connect(function()
    flying = not flying
    btn.Text = flying and "Fly: ON" or "Fly: OFF"

    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    if flying then
        conn = game:GetService("RunService").Heartbeat:Connect(function()
            -- đẩy lên nhẹ liên tục
            hrp.Velocity = Vector3.new(0, 5, 0)
        end)
    else
        if conn then
            conn:Disconnect()
        end
    end
end)
