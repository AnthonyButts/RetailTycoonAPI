local API = {}

local Workspace = game:GetService('Workspace')
local Players = game:GetService('Players')
local FunctionsFolder = Workspace:FindFirstChild('Functions')
local NPCModel = Workspace:FindFirstChild('NPCModel')

Functions =
{
    ['GetTycoon'] = FunctionsFolder.GetTycoon,
    ['LoadTycoon'] = FunctionsFolder.LoadTycoon,
    ['SaveTycoon'] = FunctionsFolder.SaveTycoon,
    ['DeleteTycoon'] = FunctionsFolder.DeleteTycoon,
    ['EditTycoon'] = FunctionsFolder.EditTycoon,
    ['SetWorker'] = FunctionsFolder.SetWorker,
    ['UpgradeSign'] = FunctionsFolder.NewSign,
    ['UpgradeParkingLot'] = FunctionsFolder.NewParking,
    ['CleanSpill'] = FunctionsFolder.CleanSpill,
    ['Restock'] = FunctionsFolder.Restock,
    ['CatchRobber'] = FunctionsFolder.CatchRobber,
    ['DestroyWall'] = FunctionsFolder.Wall,
    ['DestroyFloor'] = FunctionsFolder.Flooring,
    ['DestroyCeiling'] = FunctionsFolder.Ceiling,
    ['SellFurniture'] = FunctionsFolder.SellFurniture
}

API.WorkerMaximums =
{
    ['Cashier'] = 20,
    ['Janitor'] = 20,
    ['Restocker'] = 20,
    ['Guard'] = 1,
    ['Manager'] = 20
}

API.WorkerType =
{
    ['Cashier'] = 'Cashier',
    ['Janitor'] = 'Janitor',
    ['Restocker'] = 'Restocker',
    ['Guard'] = 'Guard',
    ['Manager'] = 'Manager'
}


local currentTycoon = Functions.GetTycoon:InvokeServer()
local localPlayer = Players.LocalPlayer

API.LoadFromSlot = function( slotNumber )

    slotNumber = tonumber(slotNumber)

    if (not currentTycoon) then return end
    if (slotNumber < 0 or slotNumber > 4) then return end

    Functions.LoadTycoon:FireServer(currentTycoon, slotNumber)
end

API.SaveToSlot = function( slotNumber )

    slotNumber = tonumber(slotNumber)

    if (not currentTycoon) then return end
    if (slotNumber < 1 or slotNumber > 4) then return end

    Functions.SaveTycoon:FireServer(currentTycoon, slotNumber)

end

API.DeleteSlot = function( slotNumber )

    slotNumber = tonumber(slotNumber)

    if (not currentTycoon) then return end
    if (slotNumber < 1 or slotNumber > 4) then return end

    Functions.DeleteTycoon:FireServer(currentTycoon, slotNumber)

end

API.ChangeStoreName = function( storeName )

    if (storeName == nil or storeName == '') then return end

    Functions.EditTycoon:FireServer(currentTycoon, "StoreName", storeName)

end

API.OpenStore = function( )

    Functions.EditTycoon:FireServer(currentTycoon, "Open", true)

end

API.CloseStore = function( )

    Functions.EditTycoon:FireServer(currentTycoon, "Open", false)

end

API.SetWorkerAmount = function( workerType, workerAmount )
   
    if (not API.WorkerType[workerType]) then return end
    if (API.WorkerMaximums[workerType] < workerAmount) then return end

    Functions.SetWorker:FireServer(currentTycoon, workerType, workerAmount)

end

API.UpgradeSign = function( upgradeLevel )

    if (not upgradeLevel) then return end
    if (upgradeLevel > 5) then return end

    Functions.UpgradeSign:InvokeServer(currentTycoon, upgradeLevel)

end

API.UpgradeParkingLot = function( upgradeLevel )
    
    if (not upgradeLevel) then return end
    if (upgradeLevel > 5) then return end

    Functions.UpgradeParkingLot:InvokeServer(currentTycoon, upgradeLevel)

end

API.ChangeStoreColor = function( color )
    Functions.EditTycoon:FireServer(currentTycoon, "Color", color)
end

API.GetStoreOpened = function()
    return currentTycoon.Info.Open.Value
end

API.CleanStore = function( )
    
    for _,tile in pairs(currentTycoon.Tiles:GetChildren()) do

        if (not tile:FindFirstChild('Spill')) then continue end
        
        task.spawn(
            function()
                repeat
                    FunctionsFolder.CleanSpill:FireServer(tile:FindFirstChild('Spill'))
                    task.wait()
                until (not tile:FindFirstChild('Spill'))
            end
        )

    end

end

API.Restock = function()
    
    if (not currentTycoon) then return end

    for _,tile in pairs(currentTycoon.Tiles:GetChildren()) do

        for _,tileChild in pairs(tile:GetDescendants()) do
            if tileChild.Name == "Item" and tileChild.ClassName == "StringValue" then
                Functions.Restock:InvokeServer(currentTycoon, tileChild.Parent)
            end
        end

    end

end

API.CatchRobbers = function()
    
    for _,hitBoxPart in pairs(NPCModel:GetDescendants()) do
        if (hitBoxPart.Name == 'HitBotPart') then
            if (hitBoxPart.Parent:FindFirstChild('Num')) then
                for f=0, 6 do
                    Functions.CatchRobber:FireServer(unpack({f,hitBoxPart.Parent:FindFirstChild('Num')}))
                end
            end
        end
    end

end

API.ClearStore = function()
    
    if (not currentTycoon) then return end 

    for _,wall in pairs(currentTycoon.Walls:GetChildren()) do
        
        Functions.DestroyWall:FireServer(false, wall)

    end

    for _,tile in pairs(currentTycoon.Tiles:GetChildren()) do
        
        for _,tileChild in pairs(tile:GetDescendants()) do
            if (tileChild.Name == 'Claimed' or tileChild.Name == 'Busy') then
                Functions.SellFurniture:FireServer(tileChild.Parent)
            end
        end

        Functions.DestroyFloor:FireServer(false, tile)
        Functions.DestroyCeiling:FireServer(false, tile)
    end

end

return API
