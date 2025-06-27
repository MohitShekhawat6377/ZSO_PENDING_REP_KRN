@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPRODUCTION_ORDR_DATA'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPRODUCTION_ORDR_DATA
  as select from    I_SalesDocumentItem    as a
    left outer join I_ManufacturingOrder   as b   on(
        b.SalesOrder         = a.SalesDocument
        and b.SalesOrderItem = a.SalesDocumentItem
      )

    left outer join YDELIVERY_QUANTITY     as g   on(
        g.SalesDocument         = a.SalesDocument
        and g.SalesDocumentItem = a.SalesDocumentItem
      )

    left outer join ZSDBOM_DATA2            as BOM on(
      //      BOM.Material  = b.Material
      BOM.BillOfMaterialComponent = b.Material
      and BOM.Plant               = b.ProductionPlant
    )
    left outer join I_ProductDescription_2 as c   on(
        c.Product      = b.Material
        and c.Language = 'E'
      )
{

  key  a.SalesDocument,
  key  a.SalesDocumentItem,
  key  b.ManufacturingOrder,
       b.Material,
       b.MfgOrderPlannedStartDate                            as StartDate,
       b.ProductionPlant                                     as Plant,
       b.ManufacturingOrderType                              as OrderType,
       b.ProductionUnit,
       @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
       b.MfgOrderPlannedTotalQty                             as OrderQty,
       //       @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
       cast(b.ActualDeliveredQuantity as abap.dec( 16, 3 ) ) as ConfirmedQty,

       BOM.BillOfMaterialItemUnit,
       //      @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
       cast(BOM.ComQty  as abap.dec( 16, 3 ) )               as ComQty,

       c.ProductDescription,

       g.DeliveryQuantityUnit,
       @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
       g.Delivery_Quantity


}

where
  a.SalesDocument is not initial
