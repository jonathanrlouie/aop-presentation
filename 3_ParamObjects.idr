data Guid = MkGuid

record AdjustInventory where
  constructor MkAdjustInventory
  productId : Guid
  decrease : Bool
  quantity : Nat

AdjustInventoryService : (Type -> Type) -> Type
AdjustInventoryService f = AdjustInventory -> f ()

adjustInventory : AdjustInventoryService f
adjustInventory (MkAdjustInventory productId decrease quantity) = ?function_impl

useAdjustInventoryService : HasIO io => (service : AdjustInventoryService io) -> io ()
useAdjustInventoryService service = ?use_impl

