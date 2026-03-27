local player = game.Players.LocalPlayer
local flying = false
local bv

-- Tạo UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 120, 0, 50)
button.Position = UDim2.new(0, 20, 0, 200)
button.Text = "Fly: OFF"
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.TextColor3 = Color3.new(1,1,1)
button.Parent = screenGui

-- Hàm bật/tắt bay
local function toggleFly()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    if not flying then
        flying = true
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.Velocity = Vector3.new(0, 3, 0) -- bay nhẹ
        bv.Parent = hrp
        button.Text = "Fly: ON"
    else
        flying = false
        if bv then bv:Destroy() end
        button.Text = "Fly: OFF"
    end
end

button.MouseButton1Click:Connect(toggleFly)
