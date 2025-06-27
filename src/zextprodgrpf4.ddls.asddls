@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_ExtProdGrpText'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZExtProdGrpF4
  as select from I_ExtProdGrpText as A
{
  key A.ExternalProductGroup,
      A.ExternalProductGroupName
}
where
  A.Language = 'E'
