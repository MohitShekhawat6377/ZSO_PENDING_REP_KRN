@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Sales Order Panding Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YDELIVERY_QUANTITY as select from YDELIVERY_QUANTITY_L1
{
    SalesDocument,
    SalesDocumentItem,
    ReferenceSDDocument,
    ReferenceSDDocumentItem,
    TransactionCurrency,
    DeliveryQuantityUnit,
    @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
    Delivery_Quantity,
    @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
   case when Delivery_Quantity is not initial
   then OrderQuantity - Delivery_Quantity
   else OrderQuantity end as PENDQTY
     
}
