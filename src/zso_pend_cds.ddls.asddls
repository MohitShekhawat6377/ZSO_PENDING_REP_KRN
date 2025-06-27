@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SO Pending Report CDS'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSO_PEND_CDS
  as select from    I_SalesDocument               as a
    left outer join I_SalesDocumentItem           as b    on(
         b.SalesDocument = a.SalesDocument
       )
    left outer join I_SalesDocument               as Inq  on(
       Inq.SalesDocument = a.ReferenceSDDocument
     )
//    left outer join I_DeliveryDocumentItem        as DELI on( // One SO One Delivery KULDEEP JI
//      DELI.ReferenceSDDocument         = b.SalesDocument
//      and DELI.ReferenceSDDocumentItem = b.SalesDocumentItem
//    )
//    left outer join I_DeliveryDocument            as DELH on(
//      DELH.DeliveryDocument = DELI.DeliveryDocument
//    )
    left outer join I_Customer                    as c    on(
         c.Customer = a.SoldToParty
       )
    left outer join I_DistributionChannelText     as e    on(
         e.DistributionChannel = a.DistributionChannel
         and e.Language        = 'E'
       )
    left outer join I_DivisionText                as f    on(
         f.Division     = a.OrganizationDivision
         and e.Language = 'E'
       )
    left outer join ZBILLING_AMOUNT               as I    on(
         I.SalesDocument         = b.SalesDocument
         and I.SalesDocumentItem = b.SalesDocumentItem
       )
    left outer join I_SalesDocItemPricingElement  as j    on(
         j.SalesDocument         = b.SalesDocument
         and j.SalesDocumentItem = b.SalesDocumentItem
         and j.ConditionType       = 'ZR00'
         and j.ConditionInactiveReason <> 'X'
       )
    left outer join YDELIVERY_QUANTITY            as g    on(
         g.SalesDocument         = b.SalesDocument
         and g.SalesDocumentItem = b.SalesDocumentItem
       )
    left outer join ZCURR_STOCK                   as st   on(
        st.Product   = b.Product
        and st.Plant = b.Plant
      )

    left outer join I_Product                     as p    on(
         p.Product = b.Product
       )

    left outer join I_ExtProdGrpText              as ext  on(
       ext.ExternalProductGroup = p.ExternalProductGroup
       and ext.Language         = 'E'
     )
    left outer join I_SalesDocumentRjcnReasonText as sor  on(
       sor.SalesDocumentRjcnReason = b.SalesDocumentRjcnReason
       and sor.Language            = 'E'
     )
    left outer join ZBOM_ACTIVITY_CDS             as BOM  on(
       BOM.Product   = b.Product
       and BOM.Plant = b.Plant
     )
      left outer join ZPLANORDER               as ZPL    on(
         ZPL.SalesOrder         = b.SalesDocument
         and ZPL.SalesOrderItem = b.SalesDocumentItem
         and ZPL.Product = b.Product
       )
       left outer join I_SalesDocumentTypeText as sot on ( sot.SalesDocumentType = a.SalesDocumentType and sot.Language = 'E' )

{

  key    Inq.ReferenceSDDocument                                     as Inquiry,
  key    a.ReferenceSDDocument                                       as Quotations,
  key    a.SalesDocument,
  key    b.SalesDocumentItem                                         as Item,
         a.SoldToParty,
         a.SalesDocumentType,
         sot.SalesDocumentTypeName ,
         a.RequestedDeliveryDate,
//         DELH.ActualGoodsMovementDate,
         c.CustomerName,
         a.PurchaseOrderByCustomer,
         a.CustomerPurchaseOrderDate,
         a.DistributionChannel,
         b.OrganizationDivision,
         a.TransactionCurrency,
         b.SalesDocumentItemText,
         b.Plant,
         a.CreationDate,
         a.CustomerPaymentTerms,
         b.MaterialByCustomer,
         e.DistributionChannelName,
         f.DivisionName,
         b.TransactionCurrency as Currency ,
         b.PriceDetnExchangeRate ,
         cast(b.NetPriceAmount as abap.dec( 23, 3 ) )                as NetPriceAmount,
         cast(b.OrderQuantity as abap.dec( 23, 3 ) )                 as OrderQuantity,
         b.OrderQuantityUnit                                         as OrderQuantityUnit,
         cast(g.Delivery_Quantity as abap.dec( 23, 3 ))              as Delivery_Quantity,
         g.DeliveryQuantityUnit                                      as DeliveryQuantityUnit,
         cast( case when g.Delivery_Quantity is not initial
         then b.OrderQuantity - g.Delivery_Quantity
         else b.OrderQuantity end as abap.dec( 23, 3 ))              as Pending_Order_Qty,
         cast( j.ConditionAmount as abap.dec( 23, 3 ) )              as ConditionAmount,
         cast( I.DespatchValue as abap.dec( 23, 3 ))                 as DespatchValue,
         case when I.DespatchValue is not initial
             then cast( j.ConditionAmount as abap.dec( 13, 2 ) ) - I.DespatchValue
             else cast( j.ConditionAmount as abap.dec( 13, 2 ) ) end as BalanceValue,
         b.Product,
         st.MaterialBaseUnit,
         @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
         st.STOCK_QTY,

         b.SDProcessStatus,
         a.LastChangeDate,
//         BOM.Currency,
         @Semantics.amount.currencyCode: 'Currency'
         BOM.StandardPrice,
         BOM.BOMAvl,
         BOM.ProductionVersion,
         BOM.ROUTING,

         p.ExternalProductGroup,
         ext.ExternalProductGroupName,

         case when b.SalesDocumentRjcnReason is initial
           then 'NO'
           else  b.SalesDocumentRjcnReason end                       as SalesDocumentRjcnReason,
         sor.SalesDocumentRjcnReasonName,
         
         ZPL.PlannedOrder ,
         case when ZPL.PlannedOrder is not initial 
         then 'YES'
         else 'NO' end as MRPRunStatus




}
where
  //  (
  //       a.SalesDocumentType         =  'TA'
  //    or a.SalesDocumentType         =  'CBRE'
  //  )
      a.SDDocumentReason          =  ' '
  and a.CompleteDeliveryIsDefined != 'X'
  and b.PartialDeliveryIsAllowed  <> 'A'
//and g.PENDQTY <> 0
