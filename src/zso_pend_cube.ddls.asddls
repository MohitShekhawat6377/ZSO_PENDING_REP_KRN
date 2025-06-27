// ************************************** CREATED BY MOHIT SHEKHAWAT ****************************************************
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZSO_PEND_CUBE'
//@Metadata.ignorePropagatedAnnotations: true
@UI: { headerInfo: { typeName: 'Report', typeNamePlural: 'SO Pending Report'  } }

//@UI:{
//    headerInfo:{
//        typeName: 'Header',
//        typeNamePlural: 'Header Data',
//        imageUrl: 'attachment'
//    } }

@Search.searchable: false
@Metadata.allowExtensions: true
@AbapCatalog.dataMaintenance: #DISPLAY_ONLY
//@DataAging.noAgingRestriction: true
@ObjectModel.supportedCapabilities: [ #CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE ]

define root view entity ZSO_PEND_CUBE
  as select from ZSO_PEND_CDS as a
  association [1..*] to ZPRODUCTION_ORDR_CDS as _item on  a.SalesDocument = _item.salesorder
                                                      and a.Item          = _item.salesorderitem

{

         @UI.facet: [{ id: 'Connection' ,purpose:#STANDARD, type: #IDENTIFICATION_REFERENCE, position: 10, label: 'Header Data' },

//                     { id: 'Header', purpose: #STANDARD, type: #LINEITEM_REFERENCE, position: 20, label: 'Item Data', targetElement: '_item' },
                     { id: 'Header', purpose: #STANDARD, type: #LINEITEM_REFERENCE, position: 20, label: 'Item Data', targetElement: '_item' }
                      ]
         @UI.multiLineText: true
         @UI.lineItem: [  { position: 5  }, { position: 10, label: 'Sales Document'}]
          @UI.identification: [{ position:10 } ]
         @ObjectModel.text.association: '_item'
         @UI.selectionField: [{ position: 10 }]
         @Search.defaultSearchElement: true
         @EndUserText.label: 'Sales Document'
         @Consumption.valueHelpDefinition: [ { entity: { name: 'ZSD_SALESDOCUMENT_F4', element: 'SalesDocument' }}]

  key    a.SalesDocument,


                  @UI.lineItem: [{ position: 40 }]
                   @UI.identification: [{ position:40 }]
                  @EndUserText.label: 'Sales Document Item'
                  @ObjectModel.text.association: '_item'
  key    a.Item,

         @UI.lineItem: [{ position: 10, label: 'Inquiry'}]
//          @UI.identification: [{ position:10 }]
         @EndUserText.label: 'Inquiry'
         @ObjectModel.text.association: '_item'
         a.Inquiry,

         @UI.lineItem: [{ position: 20, label: 'Quotations'}]
         // @UI.identification: [{ position:20 }]
         @EndUserText.label: 'Quotations'
         @ObjectModel.text.association: '_item'
         a.Quotations,



         @UI.lineItem: [{ position: 50, label: 'SoldToParty'}]
         // @UI.identification: [{ position:50 }]
         @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Customer_VH', element: 'Customer' } }]
         @EndUserText.label: 'SoldToParty'
         a.SoldToParty,
         // @UI.lineItem: [{ position: 60, label: 'Customer Name'}]
         // @UI.identification: [{ position:60 }]
         @EndUserText.label: 'Customer Name'
         @UI.selectionField: [{ position: 20 }]
         @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Customer_VH', element: 'CustomerName' } }]
         a.CustomerName,
         @UI.lineItem: [{ position: 70, label: 'Purchase Order By Customer'}]
         // @UI.identification: [{ position:70 }]
         @EndUserText.label: 'Purchase Order By Customer'
         a.PurchaseOrderByCustomer,
         @UI.lineItem: [{ position: 80, label: 'Customer Purchase Order Date'}]
         // @UI.identification: [{ position:80 }]
         @EndUserText.label: 'Customer Purchase Order Date'
         a.CustomerPurchaseOrderDate,
         @UI.lineItem: [{ position: 110, label: 'Distribution Channel'}]
         // @UI.identification: [{ position:110 }]
         @EndUserText.label: 'Distribution Channel'
         @UI.selectionField: [{position: 100 }]
         @Consumption.valueHelpDefinition: [ { entity:   { name: 'ZSD_Distchnl_f4' , element:  'DistributionChannel' } }]
         a.DistributionChannel,

         @UI.lineItem: [{ position: 120, label: 'Division'}]
         // @UI.identification: [{ position:120 }]
         @EndUserText.label: 'Division'
         a.OrganizationDivision,

         @UI.lineItem: [{ position: 130, label: 'Transaction Currency'}]
         // @UI.identification: [{ position:130 }]
         @EndUserText.label: 'Transaction Currency'
         a.TransactionCurrency,

         @UI.lineItem: [{ position: 140 }]
         // @UI.identification: [{ position:140 }]
         @EndUserText.label: 'Quality Description'
         a.SalesDocumentItemText,


         @UI.lineItem: [{ position: 141 }]
         // @UI.identification: [{ position:141 }]
         @EndUserText.label: 'Pitch'
         @UI.selectionField: [{ position: 40 }]
         @Consumption.valueHelpDefinition: [ { entity:  { name:    'ZExtProdGrpF4', element: 'ExternalProductGroup' } }]
         a.ExternalProductGroup,

         @UI.lineItem: [{ position: 142 }]
         // @UI.identification: [{ position:142 }]
         @EndUserText.label: 'Pitch Name'
         a.ExternalProductGroupName,

         @UI.lineItem: [{ position: 150 }]
          @UI.identification: [{ position:150 }] 
         @EndUserText.label: 'Plant'
         @UI.selectionField: [{ position: 30 }]
         @Consumption.valueHelpDefinition: [ { entity:  { name:    'I_PLANT', element: 'Plant' } }]
         a.Plant,


         @UI.lineItem: [{ position: 170, label: 'Creation Date'}]
         // @UI.identification: [{ position:170 }]
         @EndUserText.label: 'Creation Date'
         @UI.selectionField: [{ position: 50 }]
         a.CreationDate,
         @UI.lineItem: [{ position: 170, label: 'Change Date'}]
         @EndUserText.label: 'Last Change Date'
         // @UI.identification: [{ position:1 }]
         a.LastChangeDate,


         @UI.lineItem: [{ position: 190, label: 'CustomerPaymentTerms'}]
         // @UI.identification: [{ position:190 }]
         @EndUserText.label: 'CustomerPaymentTerms'
         a.CustomerPaymentTerms,
         @UI.lineItem: [{ position: 200, label: 'Material By Customer'}]
         // @UI.identification: [{ position:200 }]
         @EndUserText.label: 'Material By Customer'
         a.MaterialByCustomer,
         @UI.lineItem: [{ position: 210 }]
         // @UI.identification: [{ position:210 }]
         @EndUserText.label: 'Distribution Channel Name'
         @UI.selectionField: [{ position: 70 }]
         @Consumption.valueHelpDefinition: [{ entity:{ name:'I_DistributionChannelText', element: 'DistributionChannelName' } }]

         a.DistributionChannelName,
         @UI.lineItem: [{ position: 220 }]
         // @UI.identification: [{ position:220 }]
         @EndUserText.label: 'Division Name'
         @UI.selectionField: [{ position: 80 }]
         @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_DivisionText', element: 'DivisionName' } }]
         a.DivisionName,

         @UI.lineItem: [{ position: 230, label: 'Basic Rate'}]
         // @UI.identification: [{ position:230 }]
         @EndUserText.label: 'Basic Rate'
         a.NetPriceAmount,
         @UI.lineItem: [{ position: 230  }]
         // @UI.identification: [{ position:230 }]
         @EndUserText.label: 'Basic Rate(INR)'
         cast( a.NetPriceAmount * a.PriceDetnExchangeRate as abap.dec( 20, 3 ) ) as NetPriceAmount_INR,

         @UI.lineItem: [{ position: 240, label: 'Order Quantity'}]
         // @UI.identification: [{ position:240 }]
         @EndUserText.label: 'Order Quantity'
         @Aggregation.default: #SUM
         a.OrderQuantity,


         @UI.lineItem: [{ position: 250, label: 'Order Quantity Unit'}]
         // @UI.identification: [{ position:250 }]
         @EndUserText.label: 'Order Quantity Unit'
         a.OrderQuantityUnit,

         @UI.lineItem: [{ position: 260, label: 'Dispatch Quantity'}]
         // @UI.identification: [{ position:260 }]
         @EndUserText.label: 'Dispatch Quantity'
         @Aggregation.default: #SUM
         a.Delivery_Quantity,

         a.DeliveryQuantityUnit,

         @UI.lineItem: [{ position: 270, label: 'Pending Quantity'}]
         // @UI.identification: [{ position:270 }]
         @EndUserText.label: 'Pending Quantity'
         @Aggregation.default: #SUM
         a.Pending_Order_Qty,

         @UI.lineItem: [{ position: 280, label: 'Order Value'}]
         // @UI.identification: [{ position:280 }]
         @Aggregation.default: #SUM
         a.ConditionAmount,
         @UI.lineItem: [{ position: 280  }]
         // @UI.identification: [{ position:280 }]
         @EndUserText.label: 'Order Value(INR)'
         @Aggregation.default: #SUM
         cast( a.ConditionAmount * a.PriceDetnExchangeRate as  abap.dec( 20, 3 ) ) as ConditionAmount_INR,

         @UI.lineItem: [{ position: 290, label: 'Dispatch Value'}]
         // @UI.identification: [{ position:290 }]
         @EndUserText.label: 'Dispatch Value'
         @Aggregation.default: #SUM
         a.DespatchValue,

         @UI.lineItem: [{ position: 300, label: 'Pending Value'}]
         // @UI.identification: [{ position:300 }]
         @EndUserText.label: 'Pending Value'
         @Aggregation.default: #SUM
         a.BalanceValue,
         @UI.lineItem: [{ position: 300 }]
         // @UI.identification: [{ position:300 }]
         @EndUserText.label: 'Pending Value(INR)'
         @Aggregation.default: #SUM
         cast( a.BalanceValue * a.PriceDetnExchangeRate as  abap.dec( 20, 3 ) ) as BalanceValue_INR,

         @UI.lineItem: [{ position: 300, label: 'Material'}]
         // @UI.identification: [{ position:300 }]
         @EndUserText.label: 'Material'
         a.Product,

         @UI.lineItem: [{ position: 300 }]
         // @UI.identification: [{ position:310 }]
         @EndUserText.label: 'Stock'
         @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
         @UI.hidden: true
         a.STOCK_QTY,

         @UI.lineItem: [{ position: 310 }]
         @EndUserText.label: 'Required Del. Date'
         a.RequestedDeliveryDate,

         //         @UI.lineItem: [{ position: 320 }]
         //         @EndUserText.label: 'PGI Date'
         //  key    A.ActualGoodsMovementDate,


         a.MaterialBaseUnit,
         a.SDProcessStatus,
         @UI.lineItem: [{ position: 350 }]
         @UI.selectionField: [{ position: 10 }]

         @Consumption.filter.defaultValue: 'NO'
         @EndUserText.label: 'Rejection Reason'
         a.SalesDocumentRjcnReason,
         @UI.lineItem: [{ position: 350 }]
         @EndUserText.label: 'Rejection Reason Text'
         a.SalesDocumentRjcnReasonName,


         @UI.lineItem       : [{position: 360}]
         @EndUserText.label: 'BOM SAP'
         a.BOMAvl,
         @UI.lineItem       : [{position: 361}]
         @EndUserText.label: 'MRP Run Status'
         a.MRPRunStatus,
         @UI.lineItem       : [{position: 370}]
         @EndUserText.label: 'Routing'
         case when a.ROUTING = 'YES' and a.BOMAvl = 'NO'
           then 'To Check'
           else a.ROUTING end           as ROUTING,

         @UI.lineItem       : [{position: 380}]
         @EndUserText.label: 'Version'
         case when a.ProductionVersion = 'YES' and a.BOMAvl = 'NO'
           then 'To Check'
           else a.ProductionVersion end as ProductionVersion,

         @UI.lineItem: [{ position: 390 }]
         @EndUserText.label: 'Standard Price'
         @Semantics.amount.currencyCode: 'Currency'
         a.StandardPrice,
         @UI.lineItem: [{ position: 391 }]
         @EndUserText.label: 'SO Type'
         a.SalesDocumentType,
         @UI.lineItem: [{ position: 392 }]
         @EndUserText.label: 'SO Type Text'
         a.SalesDocumentTypeName,
         
         a.Currency,

//     'https://sapui5.hana.ondemand.com/test-resources/sap/suite/ui/generic/template/demokit/test/service/images/HT-2001.jpg' as attachment,
     
         _item

}
