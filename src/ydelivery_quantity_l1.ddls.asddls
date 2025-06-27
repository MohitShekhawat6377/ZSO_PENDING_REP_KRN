@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Delivery Quantity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YDELIVERY_QUANTITY_L1  as select from I_SalesDocumentItem as b
left outer join I_DeliveryDocumentItem as a  on ( b.SalesDocument = a.ReferenceSDDocument and b.SalesDocumentItem = a.ReferenceSDDocumentItem )
{
  b.SalesDocument,
  b.SalesDocumentItem,
  a.ReferenceSDDocument,
  a.ReferenceSDDocumentItem,
  a.TransactionCurrency,
  a.BaseUnit as DeliveryQuantityUnit, 
  @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
  b.OrderQuantity,
  @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
  sum( a.ActualDeliveryQuantity ) as Delivery_Quantity
}
group by
  a.ReferenceSDDocument,
  a.ReferenceSDDocumentItem,
  a.TransactionCurrency,
  a.BaseUnit,
  b.OrderQuantity,
  b.SalesDocument,
  b.SalesDocumentItem
