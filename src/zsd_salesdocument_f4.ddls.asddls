@AbapCatalog.sqlViewName: 'ZCDSFORF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Sales Document F4'
define view ZSD_SALESDOCUMENT_F4 as select from I_SalesDocument
{
    key SalesDocument,
        SalesDocumentType
   
}

group by SalesDocument,
        SalesDocumentType
        
