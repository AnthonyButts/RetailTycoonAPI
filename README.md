# Slot Functions
```lua
<void> LoadFromSlot(<int> slotNumber)
```
Loads the player's store from `slotNumber`.
```lua
<void> SaveToSlot(<int> slotNumber)
```
Saves the player's store to `slotNumber`.
```lua
<void> DeleteSlot(<int> slotNumber)
```
Deletes the player's save from `slotNumber`.

***

# Store Functions
```lua
<void> ChangeStoreNae(<string> storeName)
```
Sets the player's store name to `storeName`.
```lua
<void> OpenStore(<void>)
```
Opens the player's store.
```lua
<void> CloseStore(<void>)
```
Closes the player's Store.
```lua
<void> SetWorkerAmount( <WorkerType> workerType, <int> workerAmount )
```
Sets the amount of workers for `workerType` to `workerAmount`.
```lua
<void> UpgradeSign( <int> upgradeLevel )
```
Upgrades the players sign to `upgradeLevel`.
```lua
<void> UpgradeParkingLot( <int> upgradeLevel )
```
Upgrades the players parking lot to `upgradeLevel`.
```lua
<void> ChangeStoreColor( <Color3> storeColor )
```
Sets the stores color to `storeColor`
```lua
<bool> GetStoreOpened( <void> )
```
Returns a boolean depending if the player's store is open.
```lua
<void> RestockStore( <void> )
```
Restocks all shelves, freezers, etc in the player's store.
```lua
<void> CatchRobber( <void> )
```
Catches any robber that is inside of the player's store.
```lua
<void> ClearStore( <void> )
```
Sells all furniture, bulldozes all floors, walls and ceilings.


***


## WorkerType
* `Cashier`
* `Janitor`
* `Restocker`
* `Guard`
* `Manager`

***

## WorkerMaximums
* Cashier `20`
* Janitor `20`
* Restocker `20`
* Guard `1`
* Manager `20`
