local API = loadstring(game:HttpGet('https://raw.githubusercontent.com/BigBoyKlem/RetailTycoonAPI/main/API.lua'))()
local RunService = game:GetService('RunService')

task.spawn(
    RunService.RenderStepped:Connect(function()
        
        API.CleanStore() -- Clean the store.
        API.RestockStore() -- Restock the store.
        API.CatchRobbers() -- Catch all robbers.

    end)
)

-- Rainbow Store
task.spawn(
    function()
        while (true) do           
            for i=0,1,0.01 do
                API.ChangeStoreColor(Color3.fromHSV(i,1,1))
                task.wait()
            end
        end
    end
)