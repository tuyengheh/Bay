-- Simple Lag UI (Client-side only)

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Tạo GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "LagUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0.1, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "Lag Control"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(0.8,0,0,30)
toggleBtn.Position = UDim2.new(0.1,0,0.4,0)
toggleBtn.Text = "Lag: OFF"

local levelBtn = Instance.new("TextButton", frame)
levelBtn.Size = UDim2.new(0.8,0,0,30)
levelBtn.Position = UDim2.new(0.1,0,0.7,0)
levelBtn.Text = "Level: 1"

-- Logic
local lag = false
local level = 1

local delays = {
    [1] = 0.05,
    [2] = 0.1,
    [3] = 0.2,
    [4] = 0.35
}

toggleBtn.MouseButton1Click:Connect(function()
    lag = not lag
    toggleBtn.Text = "Lag: " .. (lag and "ON" or "OFF")
end)

levelBtn.MouseButton1Click:Connect(function()
    level = level + 1
    if level > 4 then level = 1 end
    levelBtn.Text = "Level: " .. level
end)

RunService.RenderStepped:Connect(function()
    if lag then
        task.wait(delays[level])
    end
end)
