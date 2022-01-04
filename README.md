## Info
This is an API for [Retail Tycoon]
(https://www.roblox.com/games/284076212/)
***

## Example Usage (Auto Farm)
Import the API & Run Serivce:
```lua
local API = loadstring(game:HttpGet('https://raw.githubusercontent.com/BigBoyKlem/RetailTycoonAPI/main/api.lua'))()
local RunService = game:GetService('RunService')
```


```lua
RunService.RenderStepped:Connect(function()

  API.CleanStore() -- Clean the store.
  API.RestockStore() -- Restock the store.
  API.CatchRobbers() -- Catch all robbers.

end)
```

Rainbow store, because why not...
```lua
while (true) do       
  for i=0,1,0.01 do
    API.ChangeStoreColor(Color3.fromHSV(i,1,1))
    task.wait()
  end
end
```

***

## Need More Help?
If you need more help, you can view the documentation [here](https://github.com/BigBoyKlem/RetailTycoonAPI/wiki/Documentation).
