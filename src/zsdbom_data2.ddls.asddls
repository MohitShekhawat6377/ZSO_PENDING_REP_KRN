@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZSDBOM_DATA2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSDBOM_DATA2
  as select from ZSDBOM_DATA as a
{
  key a.Plant,
      a.BillOfMaterialItemUnit,
      a.BillOfMaterialComponent,
      @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
      sum(a.ComQty) as ComQty

}
group by
  a.Plant,
  a.BillOfMaterialItemUnit,
  a.BillOfMaterialComponent
