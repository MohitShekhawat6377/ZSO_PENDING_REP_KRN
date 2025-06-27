@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZBILLING_AMOUNT'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZBILLING_AMOUNT
  as select from    I_BillingDocumentItem          as a
    left outer join I_BillingDocumentItemPrcgElmnt as b on(
      b.BillingDocument         = a.BillingDocument
      and b.BillingDocumentItem = a.BillingDocumentItem
    )
{
  key a.SalesDocument,
  key a.SalesDocumentItem,
      sum(cast(b.ConditionAmount as abap.dec( 20, 2 ) ) ) as DespatchValue
}
where
      b.ConditionInactiveReason != 'X'
  and b.ConditionType           =  'ZR00'
group by
  a.SalesDocument,
  a.SalesDocumentItem
