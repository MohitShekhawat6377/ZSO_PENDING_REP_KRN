@AbapCatalog.sqlViewName: 'YSALESCUREENNT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Current Stock'
define view ZSO_CURRENT_STOK_2 as select from ZSO_CURRENT_STOK
{
    key SDDocument,
    key SDDocumentItem,
    key Material,
    sum(FreshStock) as FreshStock,
    sum(Damagestock) as Damagestock,
    sum(Otherstock) as Otherstock
}
group by 
       SDDocument,
       SDDocumentItem,
       Material
