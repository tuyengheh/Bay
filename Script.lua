local player = game.Players.LocalPlayer
local active = false
local height = 3
local connection

-- UI
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0,120,0,50)
btn.Position = UDim2.new(0,20,0,200)
btn.Text = "Float: OFF"
btn.Parent = gui

btn.Active = true
btn.Draggable = true

local function startFloat()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local pos = hrp.Position + Vector3.new(0, height, 0)

    connection = game:GetService("RunService").Heartbeat:Connect(function()
        if active then
            hrp.CFrame = CFrame.new(pos)
        end
    end)
end

local function stopFloat()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

btn.Activated:Connect(function()
    active = not active
    btn.Text = active and "Float: ON" or "Float: OFF"

    if active then
        startFloat()
    else
        stopFloat()
    end
end)
