local RunService = game:GetService("RunService")
local lag = true

RunService.RenderStepped:Connect(function()
    if lag then
        task.wait(0.2)
    end
end)


local lag = false

game:GetService("UserInputService").InputBegan:Connect(function(i,g)
    if not g and i.KeyCode == Enum.KeyCode.L then
        lag = not lag
        print("Lag:", lag)
    end
end)

task.spawn(function()
    while true do
        if lag then
            -- spam tính toán nặng
            for i = 1, 500000 do
                local a = math.sqrt(i)
            end
        end
        task.wait()
    end
end)
