@AbapCatalog.sqlViewName: 'ZSYAMAN_CDSEGT1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds1'
define view ZSYAMAN_CDS1
  as select from    vbrp
    inner join      vbrk on vbrk.vbeln = vbrp.vbeln
    inner join      mara on mara.matnr = vbrp.matnr
    left outer join vbak on vbak.vbeln = vbrp.aubel
    left outer join kna1 on kna1.kunnr = vbak.kunnr
    left outer join makt on  makt.matnr = mara.matnr
                         and makt.spras = $session.system_language

{
  key vbrp.vbeln                                             as Fatura_No,
  key vbrp.posnr                                             as Fatura_Kalem_No,
      vbrp.aubel                                             as Satis_Belgesi,
      vbrp.aupos                                             as Satis_Belge_Kalem,
      vbak.kunnr                                             as Siparis_Veren,

      concat_with_space(kna1.name1, kna1.name2,1)            as Siparis_Veren_Ad,

      currency_conversion(amount => vbrp.netwr,
                          source_currency => vbrk.waerk,
                          target_currency => cast ('EUR' as abap.cuky(5) ),
                          exchange_rate_Date => vbrk.fkdat ) as conversion_netwr,

      left(kna1.kunnr,3 )                                    as left_kunnr,

      length(mara.matnr)                                     as matnr_length,

      case vbrk.fkdat
      when 'FAS' then 'Peşinat Talebi İptali'
      when 'FAZ' then 'Peşinat Talebi'
      else 'Fatura' end                                      as Faturalama_Turu,

      vbrk.fkdat,
      vbrk.inco2_l

}
