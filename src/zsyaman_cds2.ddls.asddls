@AbapCatalog.sqlViewName: 'ZSYAMAN_CDSEGT2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds2'
define view ZSYAMAN_CDS2
  as select from ZSYAMAN_CDS1 as table
{
  table.Fatura_No,
  
  sum(table.conversion_netwr)                                                                  as Toplam_Net_Deger,
  
  table.Siparis_Veren_Ad,
  
  count(*)                                                                                     as Toplam_Fatura_Adedi,
  
  division(cast(sum(conversion_netwr) as abap.curr( 10, 3 )), cast(count(*) as abap.int1), 3 ) as Ortalama_Miktar,
  
  left(table.fkdat,4)                                                                          as Faturalama_Yili,
  substring(table.fkdat,5,2)                                                                   as Faturalama_Ayi,
  substring(table.fkdat,7,2)                                                                   as Faturalama_Gunu,
  substring(table.inco2_l,1,3)                                                                 as Incoterm_Yeri,
  table.fkdat

}

group by
  Fatura_No,
  Siparis_Veren_Ad,
  fkdat,
  inco2_l
