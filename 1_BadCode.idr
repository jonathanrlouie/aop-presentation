data DiscountedProduct = MkDiscountedProduct
data Guid = MkGuid
data Product = MkProduct
data Paged t = MkPaged t
data ProductReview = MkProductReview

data ProductL : Type -> Type where
  GetFeaturedProducts : ProductL (List DiscountedProduct)
  DeleteProduct : (productId : Guid) -> ProductL ()
  GetProductById : (productId : Guid) -> ProductL Product
  InsertProduct : (product : Product) -> ProductL ()
  UpdateProduct : (product : Product) -> ProductL ()
  SearchProducts : 
    (pageIndex : Nat) -> (pageSize : Nat) -> 
    (manufacturerId : Maybe Guid) -> (searchText : String) -> ProductL (Paged Product)
  UpdateProductReviewTotals : 
    (productId : Guid) -> (reviews : List ProductReview) -> ProductL ()
  AdjustInventory : (productId : Guid) -> (decrease : Bool) -> (quantity : Nat) -> ProductL ()
  UpdateHasTierPricesProperty : (product : Product) -> ProductL ()
  UpdateHasDiscountsApplied :
    (productId : Guid) -> (discountDescription : String) -> ProductL ()

  Pure : ty -> ProductL ty
  Bind : ProductL a -> (a -> ProductL b) -> ProductL b

Functor ProductL where
  map f m = Bind m (Pure . f)

Applicative ProductL where
  pure = Pure

Monad ProductL where
  c >>= f = Bind c f


-- example scripts
script1 : ProductL ()
script1 = do
  UpdateHasTierPricesProperty MkProduct
  UpdateHasDiscountsApplied MkGuid ""

interp1 : ProductL a -> IO a
interp1 GetFeaturedProducts = do
  printLn "getting featured products"
  pure []
interp1 (DeleteProduct productId) = printLn ""
interp1 (GetProductById productId) = do
  printLn "getting product"
  pure MkProduct
interp1 (InsertProduct product) = printLn ""
interp1 (UpdateProduct product) = printLn ""
interp1 (SearchProducts pageIndex pageSize manufacturerId searchText) = do
  printLn "searching products"
  pure (MkPaged MkProduct)
interp1 (UpdateProductReviewTotals productId reviews) = printLn ""
interp1 (AdjustInventory productId decrease quantity) = printLn "Adjusting inventory"
interp1 (UpdateHasTierPricesProperty product) = printLn "Updat"
interp1 (UpdateHasDiscountsApplied productId discountDescription) = printLn ""
interp1 (Pure val) = pure val
interp1 (Bind c f) = do
  res <- interp1 c
  interp1 (f res)

mockInterp : ProductL a -> IO a
mockInterp GetFeaturedProducts = pure []
mockInterp (DeleteProduct productId) = pure ()
mockInterp (GetProductById productId) = pure MkProduct
mockInterp (InsertProduct product) = pure ()
mockInterp (UpdateProduct product) = pure ()
mockInterp (SearchProducts pageIndex pageSize manufacturerId searchText) = pure (MkPaged MkProduct)
mockInterp (UpdateProductReviewTotals productId reviews) = pure ()
mockInterp (AdjustInventory productId decrease quantity) = pure ()
mockInterp (UpdateHasTierPricesProperty product) = pure ()
mockInterp (UpdateHasDiscountsApplied productId discountDescription) = pure ()
mockInterp (Pure val) = pure val
mockInterp (Bind c f) = do
  res <- mockInterp c
  mockInterp (f res)
