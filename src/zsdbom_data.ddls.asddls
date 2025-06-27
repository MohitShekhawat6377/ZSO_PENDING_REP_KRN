@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZSDBOM_DATA'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSDBOM_DATA
  as select from    I_MaterialBOMLink           as A
    left outer join I_BillOfMaterialHeaderDEX_2 as B on(
      B.BillOfMaterial                 = A.BillOfMaterial
      and B.BillOfMaterialVariant      = A.BillOfMaterialVariant
      and B.BillOfMaterialVariantUsage = A.BillOfMaterialVariantUsage
      and B.BillOfMaterialCategory     = 'M'
    )
    left outer join I_BillOfMaterialItemBasic   as C on(
      C.BillOfMaterial             = A.BillOfMaterial
      //      and C.BillOfMaterialComponent = A.Material
      and C.BillOfMaterialCategory = 'M'
    )


{
  key A.Plant,
      A.Material,
//      B.BOMHeaderBaseUnit,
//      @Semantics.quantity.unitOfMeasure: 'BOMHeaderBaseUnit'
//      B.BOMHeaderQuantityInBaseUnit as BOMBaseQty,
      C.BillOfMaterialItemUnit,
      C.BillOfMaterialComponent,
      @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
      C.BillOfMaterialItemQuantity  as ComQty




}
where
      A.BillOfMaterialVariantUsage = '1'
  and A.BillOfMaterialVariant      = '01'
