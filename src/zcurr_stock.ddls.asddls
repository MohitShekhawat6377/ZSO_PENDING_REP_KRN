@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Current Stock'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCURR_STOCK
  as select from I_StockQuantityCurrentValue_2( P_DisplayCurrency: 'INR' ) as A
{
  key A.Plant,
  key A.Product,
      A.MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( A.MatlWrhsStkQtyInMatlBaseUnit ) as STOCK_QTY
}
where
      A.MatlWrhsStkQtyInMatlBaseUnit >  0
  and A.InventoryStockType           =  '01'
  and A.ValuationAreaType            =  '1'

group by
  A.Plant,
  A.Product,
  A.MaterialBaseUnit
