data Guid = MkGuid
data InventoryRepository = MkInventoryRepository

-- Re-stating definition of AdjustInventory here for readability
record AdjustInventory where
  constructor MkAdjustInventory
  productId : Guid
  decrease : Bool
  quantity : Nat

-- Type alias for command services
-- All command services take a command of generic type and return Unit
CommandService : Type -> Type
CommandService ty = ty -> IO ()

-- For the sake of simplicity, I assume InventoryRepository is a plain data type.
-- It could instead be some type that implements an IInventoryRepository type class.
mkAdjustInventoryService : InventoryRepository -> CommandService AdjustInventory
mkAdjustInventoryService repository = \adjustInventory => do
  let productId = adjustInventory.productId
  -- We’re free to do anything we want with the repository and adjustInventory command!
  pure ()

-- Our decorator for the transaction aspect
mkTransactionCommandService : CommandService ty -> CommandService ty
mkTransactionCommandService service = \cmd => 
  -- Now we’re free to insert whatever logic we want here!
  -- We probably use the bracket pattern here to ensure resources are closed properly
  ?transaction_scope_logic

