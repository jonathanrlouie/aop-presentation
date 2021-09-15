data Guid = MkGuid

-- This function returns a function type which takes 3 arguments of type Guid, Bool and Nat, and returns a value of type f (). We don’t have to commit to the IO monad. We can be generic over the type constructor used.
-- This is just a type alias for our service type to make things convenient.
AdjustInventoryService : (Type -> Type) -> Type
AdjustInventoryService f = Guid -> Bool -> Nat -> f ()

-- Define the AdjustInventoryService implementation here
adjustInventory : AdjustInventoryService f
adjustInventory productId decrease quantity = ?function_impl

-- This is the function that uses our AdjustInventoryService. It doesn’t know anything about the service implementation that we pass in. To use the service, call it with its 3 arguments.
useAdjustInventoryService : HasIO io => (service : AdjustInventoryService io) -> io ()
useAdjustInventoryService service = ?use_impl

