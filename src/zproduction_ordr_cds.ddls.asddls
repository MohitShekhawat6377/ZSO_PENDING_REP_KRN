@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI: { headerInfo: { typeName: 'Report', typeNamePlural: 'Production Data' },
    presentationVariant: [{ sortOrder: [{ by: 'Material', direction: #ASC
        }],
        visualizations: [{ type: #AS_LINEITEM }]
       }]
      }


define view entity ZPRODUCTION_ORDR_CDS

  as select from ZPRODUCTION_ORDR_DATA as a

  association [1] to ZSO_PEND_CUBE as head on  a.SalesDocument     = head.SalesDocument
                                           and a.SalesDocumentItem = head.Item

{


       @UI.selectionField: [{ position: 10 }]
       @UI.lineItem: [{ label: 'Sales Order'}]
  key  a.SalesDocument                             as salesorder,
       @UI.selectionField: [{ position: 20 }]
       @UI.lineItem: [{  label: 'Sales Order Item'}]
  key  a.SalesDocumentItem                         as salesorderitem,

       @UI.lineItem: [{ position: 30, label: 'Order'}]
  key  a.ManufacturingOrder,
       @UI.lineItem: [{ position: 40, label: 'Order Type'}]
       a.OrderType,
       @UI.lineItem: [{ position: 50, label: 'Material'}]
       a.Material,
       @UI.lineItem: [{ position: 60, label: 'Material Description'}]
       a.ProductDescription ,
//       @UI.lineItem: [{ position: 70, label: 'Plant'}]
//       a.Plant,
       @UI.lineItem: [{ position: 80, label: 'Order Quantity'}]
       @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
       a.OrderQty,
       @UI.lineItem: [{ position: 90, label: 'GR Quantity'}]
       @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
       a.ConfirmedQty,
       
       @UI.lineItem: [{ position: 100, label: 'FG Equal Order Quantity'}]
       case when a.ComQty is not initial
       then
       division( a.ConfirmedQty, a.ComQty, 2 ) end as FGEqualOrderQty,
       

       @UI.lineItem: [{ label: 'Dispatch Quantity'}]
       @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
       a.Delivery_Quantity,
       
       @UI.lineItem: [{ label: 'BOM Ratio Quantity'}]
       @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
       a.ComQty,
       
       
       a.DeliveryQuantityUnit,
       a.BillOfMaterialItemUnit,
       a.ProductionUnit,
       
//       a.Delivery_Quantity ,


       head
}
where
  a.SalesDocument is not initial
