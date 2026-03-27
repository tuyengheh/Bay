local player = game.Players.LocalPlayer
local height = 3
local active = false

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", gui)

btn.Size = UDim2.new(0,120,0,50)
btn.Position = UDim2.new(0,20,0,200)
btn.Text = "Float: OFF"

btn.Active = true
btn.Draggable = true

local function toggle()
    active = not active
    btn.Text = active and "Float: ON" or "Float: OFF"

    if active then
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        local pos = hrp.Position + Vector3.new(0, height, 0)

        -- giữ vị trí nhẹ
        while active do
            hrp.CFrame = CFrame.new(pos)
            task.wait(0.2) -- delay để tránh bị phát hiện
        end
    end
end

btn.Activated:Connect(toggle)
