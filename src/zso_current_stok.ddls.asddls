@AbapCatalog.sqlViewName: 'YSOCURRENTSTK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Stock Current Stock'
define view ZSO_CURRENT_STOK as select from I_MaterialStock_2 as A 
{
    key A.SDDocument,
    key A.SDDocumentItem,
    key A.Material,
       A.StorageLocation,
       case when A.StorageLocation = 'WGF1' 
       then sum( A.MatlWrhsStkQtyInMatlBaseUnit ) end as FreshStock  ,
       case when A.StorageLocation = 'WGF2' 
       then sum( A.MatlWrhsStkQtyInMatlBaseUnit ) end as Damagestock,
      case when A.StorageLocation <> 'WGF1' and  A.StorageLocation <> 'WGF2'
       then sum( A.MatlWrhsStkQtyInMatlBaseUnit ) end as Otherstock
}
group by 

  A.SDDocument,
  A.StorageLocation,
  A.Material, 
  A.SDDocumentItem
