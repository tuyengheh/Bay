-- chống load lại
if getgenv().TestUI then return end
getgenv().TestUI = true

print("UI DA CHAY")

-- xóa UI cũ
pcall(function()
    game.CoreGui:FindFirstChild("TestGui"):Destroy()
end)

-- tạo UI
local gui = Instance.new("ScreenGui")
gui.Name = "TestGui"
gui.Parent = game.CoreGui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0,140,0,60)
btn.Position = UDim2.new(0,20,0,200)
btn.Text = "CLICK ME"
btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- đỏ
btn.TextColor3 = Color3.new(1,1,1)
btn.Parent = gui

btn.Active = true
btn.Draggable = true

-- bấm đổi màu
btn.Activated:Connect(function()
    print("DA BAM")

    btn.BackgroundColor3 = Color3.fromRGB(
        math.random(0,255),
        math.random(0,255),
        math.random(0,255)
    )
end)
