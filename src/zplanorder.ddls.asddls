@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPLANORDER'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPLANORDER
  as select from I_ManufacturingOrderItem as A
{
  key A.SalesOrder,
  key A.SalesOrderItem,
  key A.Product,
      max(A.PlannedOrder) as PlannedOrder
}
group by
  A.SalesOrder,
  A.SalesOrderItem,
  A.Product
