-- chống load nhiều lần
if getgenv().Float3M then return end
getgenv().Float3M = true

local player = game.Players.LocalPlayer
local active = false
local conn

-- xóa UI cũ
pcall(function()
    game.CoreGui:FindFirstChild("FloatGui"):Destroy()
end)

-- tạo UI
local gui = Instance.new("ScreenGui")
gui.Name = "FloatGui"
gui.Parent = game.CoreGui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0,140,0,60)
btn.Position = UDim2.new(0,20,0,200)
btn.Text = "FLOAT: OFF"
btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
btn.TextColor3 = Color3.new(1,1,1)
btn.Parent = gui

btn.Active = true
btn.Draggable = true

-- chức năng
btn.Activated:Connect(function()
    active = not active
    btn.Text = active and "FLOAT: ON" or "FLOAT: OFF"

    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")

    if active then
        local targetY = hrp.Position.Y + 3 -- cao ~3m

        conn = game:GetService("RunService").Heartbeat:Connect(function()
            if not active then return end

            -- giả lập “đứng trên không” nhẹ
            local pos = hrp.Position
            hrp.CFrame = CFrame.new(pos.X, targetY, pos.Z)

            -- giữ trạng thái giống người thật
            hum:ChangeState(Enum.HumanoidStateType.Freefall)
        end)

    else
        if conn then
            conn:Disconnect()
            conn = nil
        end
    end
end)
