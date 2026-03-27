local RunService = game:GetService("RunService")
local lag = true

RunService.RenderStepped:Connect(function()
    if lag then
        task.wait(0.2)
    end
end)
