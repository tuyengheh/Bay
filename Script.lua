print("SCRIPT OK")

local player = game.Players.LocalPlayer
local flying = false
local conn

-- UI
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0,120,0,50)
btn.Position = UDim2.new(0,20,0,200)
btn.Text = "Fly: OFF"
btn.Parent = gui

btn.Active = true
btn.Draggable = true

btn.Activated:Connect(function()
    flying = not flying
    print("TRANG THAI:", flying)

    if flying then
        btn.Text = "Fly: ON"

        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        conn = game:GetService("RunService").Heartbeat:Connect(function()
            if flying and hrp then
                hrp.Velocity = Vector3.new(0, 5, 0)
            end
        end)

    else
        btn.Text = "Fly: OFF"

        if conn then
            conn:Disconnect()
            conn = nil
        end
    end
end)
