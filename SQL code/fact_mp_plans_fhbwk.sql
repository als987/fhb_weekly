CREATE OR REPLACE VIEW beam_prod.finance_azlab_prod.fact_mp_plans_fhbwk AS
WITH mp AS (
    -- Mainchain
        SELECT 'RF' AS plan
        ,'01' AS channel
        ,cast(Right(calendar,8) AS int) AS calendar
        ,concat('G5-', substring(product,4,3)) AS product
        ,sum(ifnull(fppposv_rf,0)+ifnull(redposv_rf,0)+ifnull(fppstdv_rf,0)+ifnull(redstdv_rf,0)+ifnull(realmdv_rf,0)) AS DiscMDV
        ,sum(ifnull(fpgslsxv_rf,0)) AS FPGSlsxV 
        ,sum(ifnull(fppgslsxv_rf,0)) AS FPPGSlsxV 
        ,sum(ifnull(fppslsv_rf,0)) AS FPPSlsV
        ,sum(ifnull(fppslsxv_rf,0)) AS FPPSlsxV
        ,sum(ifnull(fpslsv_rf,0)) AS FPSlsV
        ,sum(ifnull(prgslsxv_rf,0)) AS PrGSlsxV
        ,sum(ifnull(prslsv_rf,0) + ifnull(redslsv_rf,0)) AS PrRedSlsV
        ,sum(ifnull(prslsv_rf,0)) AS PrSlsV
        ,sum(ifnull(realmdv_rf,0)) AS RealMDV
        ,sum(ifnull(realmdxv_rf,0)) AS RealMDxV
        ,sum(ifnull(redgslsxv_rf,0)) AS RedGSlsxV
        ,sum(ifnull(redslsv_rf,0)) AS RedSlsV
        ,sum(ifnull(fppgslsxv_rf,0) +ifnull(redgslsxv_rf,0)+ifnull(realmdxv_rf,0)) - sum(ifnull(fppslsc_rf,0) + ifnull(redslsc_rf,0)) AS TotBIMAV
        ,sum(ifnull(fppgslsxv_rf,0) +ifnull(redgslsxv_rf,0)+ifnull(realmdxv_rf,0)) AS TotBIMBV
        ,CASE WHEN (sum(ifnull(fppgslsxv_rf,0) +ifnull(redgslsxv_rf,0)+ifnull(realmdxv_rf,0)))=0 THEN 0 ELSE
        (sum(ifnull(fppgslsxv_rf,0) +ifnull(redgslsxv_rf,0)+ifnull(realmdxv_rf,0)) - sum(ifnull(fppslsc_rf,0) + ifnull(redslsc_rf,0)))/(sum(ifnull(fppgslsxv_rf,0) +ifnull(redgslsxv_rf,0)+ifnull(realmdxv_rf,0)))*100 end AS TotBIMP
        ,sum(ifnull(fppgsmv_rf,0)+ifnull(redgsmv_rf,0)) AS TotGSMV
        ,sum(ifnull(fppposv_rf,0)+ifnull(redposv_rf,0)) AS TotPoSV
        ,sum(ifnull(fppslsc_rf,0) + ifnull(redslsc_rf,0)) AS TotSlsC
        ,sum(ifnull(fppslsv_rf,0)+ifnull(redslsv_rf,0)) AS TotSlsV
        ,sum(ifnull(fppslsxv_rf,0)+ifnull(redslsxv_rf,0)) AS TotSlsxV
        ,sum(ifnull(fppstdv_rf,0)+ifnull(redstdv_rf,0)) TotStDV
        ,sum(ifnull(fppposv_rf,0)+ifnull(redposv_rf,0)+ifnull(fppstdv_rf,0)+ifnull(redstdv_rf,0)) AS TotPromoActV
        ,sum(ifnull(fpprevintu_rf,0)) as fpp_rev_intake_units
        ,sum(ifnull(fpprevintv_rf,0)) as fpp_rev_intake_val
        FROM beam_prod.mp_analyse_prod.mns_pl_rf_t_nsaz_tbl rf
        GROUP BY
            cast(Right(calendar,8) AS int)
            ,concat('G5-', substring(product,4,3))

    UNION ALL

        SELECT 'BUDGET' AS plan
        ,'01' AS channel
        ,cast(Right(calendar,8) AS int) AS calendar
        ,concat('G5-', substring(product,4,3)) AS product
        ,sum(ifnull(fppposv_opkpi,0)+ifnull(redposv_opkpi,0)+ifnull(fppstdv_opkpi,0)+ifnull(redstdv_opkpi,0)+ifnull(realmdv_opkpi,0)) AS DiscMDV
        ,sum(ifnull(fpgslsxv_opkpi,0)) AS FPGSlsxV 
        ,sum(ifnull(fppgslsxv_opkpi,0)) AS FPPGSlsxV 
        ,sum(ifnull(fppslsv_opkpi,0)) AS FPPSlsV
        ,sum(ifnull(fppslsxv_opkpi,0)) AS FPPSlsxV
        ,sum(ifnull(fpslsv_opkpi,0)) AS FPSlsV
        ,sum(ifnull(prgslsxv_opkpi,0)) AS PrGSlsxV
        ,sum(ifnull(prslsv_opkpi,0) + ifnull(redslsv_opkpi,0)) AS PrRedSlsV
        ,sum(ifnull(prslsv_opkpi,0)) AS PrSlsV
        ,sum(ifnull(realmdv_opkpi,0)) AS RealMDV
        ,sum(ifnull(realmdxv_opkpi,0)) AS RealMDxV
        ,sum(ifnull(redgslsxv_opkpi,0)) AS RedGSlsxV
        ,sum(ifnull(redslsv_opkpi,0)) AS RedSlsV
        ,sum(ifnull(fppgslsxv_opkpi,0) +ifnull(redgslsxv_opkpi,0)+ifnull(realmdxv_opkpi,0)) - sum(ifnull(fppslsc_opkpi,0) + ifnull(redslsc_opkpi,0)) AS TotBIMAV
        ,sum(ifnull(fppgslsxv_opkpi,0) +ifnull(redgslsxv_opkpi,0)+ifnull(realmdxv_opkpi,0)) AS TotBIMBV
        ,CASE WHEN (sum(ifnull(fppgslsxv_opkpi,0) +ifnull(redgslsxv_opkpi,0)+ifnull(realmdxv_opkpi,0)))=0 THEN 0 ELSE
        (sum(ifnull(fppgslsxv_opkpi,0) +ifnull(redgslsxv_opkpi,0)+ifnull(realmdxv_opkpi,0)) - sum(ifnull(fppslsc_opkpi,0) + ifnull(redslsc_opkpi,0)))/(sum(ifnull(fppgslsxv_opkpi,0) +ifnull(redgslsxv_opkpi,0)+ifnull(realmdxv_opkpi,0)))*100 end AS TotBIMP
        ,sum(ifnull(fppgsmv_opkpi,0)+ifnull(redgsmv_opkpi,0)) AS TotGSMV
        ,sum(ifnull(fppposv_opkpi,0)+ifnull(redposv_opkpi,0)) AS TotPoSV
        ,sum(ifnull(fppslsc_opkpi,0) + ifnull(redslsc_opkpi,0)) AS TotSlsC
        ,sum(ifnull(fppslsv_opkpi,0)+ifnull(redslsv_opkpi,0)) AS TotSlsV
        ,sum(ifnull(fppslsxv_opkpi,0)+ifnull(redslsxv_opkpi,0)) AS TotSlsxV
        ,sum(ifnull(fppstdv_opkpi,0)+ifnull(redstdv_opkpi,0)) TotStDV
        ,sum(0) AS TotPromoActV
        ,sum(ifnull(fpprevintu_opkpi,0)) as fpp_rev_intake_units
        ,sum(ifnull(fpprevintv_opkpi,0)) as fpp_rev_intake_val
        FROM beam_prod.mp_analyse_prod.mns_pl_opkpi_t_nsaz_tbl opkpi
        GROUP BY  cast(Right(calendar,8) AS int)
            ,concat('G5-', substring(product,4,3))

    UNION ALL

        SELECT 'QRF' AS plan
        ,'01' AS channel
        ,cast(Right(calendar,8) AS int) AS calendar
        ,concat('G5-', substring(product,4,3)) AS product
        ,sum(ifnull(fppposv_qrf,0)+ifnull(redposv_qrf,0)+ifnull(fppstdv_qrf,0)+ifnull(redstdv_qrf,0)+ifnull(realmdv_qrf,0)) AS DiscMDV
        ,sum(ifnull(fpgslsxv_qrf,0)) AS FPGSlsxV 
        ,sum(ifnull(fppgslsxv_qrf,0)) AS FPPGSlsxV 
        ,sum(ifnull(fppslsv_qrf,0)) AS FPPSlsV
        ,sum(ifnull(fppslsxv_qrf,0)) AS FPPSlsxV
        ,sum(ifnull(fpslsv_qrf,0)) AS FPSlsV
        ,sum(ifnull(prgslsxv_qrf,0)) AS PrGSlsxV
        ,sum(ifnull(prslsv_qrf,0) + ifnull(redslsv_qrf,0)) AS PrRedSlsV
        ,sum(ifnull(prslsv_qrf,0)) AS PrSlsV
        ,sum(ifnull(realmdv_qrf,0)) AS RealMDV
        ,sum(ifnull(realmdxv_qrf,0)) AS RealMDxV
        ,sum(ifnull(redgslsxv_qrf,0)) AS RedGSlsxV
        ,sum(ifnull(redslsv_qrf,0)) AS RedSlsV
        ,sum(ifnull(fppgslsxv_qrf,0) +ifnull(redgslsxv_qrf,0)+ifnull(realmdxv_qrf,0)) - sum(ifnull(fppslsc_qrf,0) + ifnull(redslsc_qrf,0)) AS TotBIMAV
        ,sum(ifnull(fppgslsxv_qrf,0) +ifnull(redgslsxv_qrf,0)+ifnull(realmdxv_qrf,0)) AS TotBIMBV
        ,CASE WHEN (sum(ifnull(fppgslsxv_qrf,0) +ifnull(redgslsxv_qrf,0)+ifnull(realmdxv_qrf,0)))=0 THEN 0 
        ELSE(sum(ifnull(fppgslsxv_qrf,0) +ifnull(redgslsxv_qrf,0)+ifnull(realmdxv_qrf,0)) - sum(ifnull(fppslsc_qrf,0) + ifnull(redslsc_qrf,0)))/(sum(ifnull(fppgslsxv_qrf,0) +ifnull(redgslsxv_qrf,0)+ifnull(realmdxv_qrf,0)))*100 end AS TotBIMP
        ,sum(ifnull(fppgsmv_qrf,0)+ifnull(redgsmv_qrf,0)) AS TotGSMV
        ,sum(ifnull(fppposv_qrf,0)+ifnull(redposv_qrf,0)) AS TotPoSV
        ,sum(ifnull(fppslsc_qrf,0) + ifnull(redslsc_qrf,0)) AS TotSlsC
        ,sum(ifnull(fppslsv_qrf,0)+ifnull(redslsv_qrf,0)) AS TotSlsV
        ,sum(ifnull(fppslsxv_qrf,0)+ifnull(redslsxv_qrf,0)) AS TotSlsxV
        ,sum(ifnull(fppstdv_qrf,0)+ifnull(redstdv_qrf,0)) TotStDV
        ,sum(0) AS TotPromoActV
        ,sum(ifnull(fpprevintu_qrf,0)) as fpp_rev_intake_units
        ,sum(ifnull(fpprevintv_qrf,0)) as fpp_rev_intake_val
        FROM beam_prod.mp_analyse_prod.mns_pl_qrf_t_nsaz_tbl qrf
        GROUP BY  cast(Right(calendar,8) AS int)
            ,concat('G5-', substring(product,4,3))

    UNION ALL

        SELECT 'MRF' AS plan
        ,'01' AS channel
        ,cast(Right(calendar,8) AS int) AS calendar
        ,concat('G5-', substring(product,4,3)) AS product
        ,sum(ifnull(fppposv_mrf,0)+ifnull(redposv_mrf,0)+ifnull(fppstdv_mrf,0)+ifnull(redstdv_mrf,0)+ifnull(realmdv_mrf,0)) AS DiscMDV
        ,sum(ifnull(fpgslsxv_mrf,0)) AS FPGSlsxV 
        ,sum(ifnull(fppgslsxv_mrf,0)) AS FPPGSlsxV 
        ,sum(ifnull(fppslsv_mrf,0)) AS FPPSlsV
        ,sum(ifnull(fppslsxv_mrf,0)) AS FPPSlsxV
        ,sum(ifnull(fpslsv_mrf,0)) AS FPSlsV
        ,sum(ifnull(prgslsxv_mrf,0)) AS PrGSlsxV
        ,sum(ifnull(prslsv_mrf,0) + ifnull(redslsv_mrf,0)) AS PrRedSlsV
        ,sum(ifnull(prslsv_mrf,0)) AS PrSlsV
        ,sum(ifnull(realmdv_mrf,0)) AS RealMDV
        ,sum(ifnull(realmdxv_mrf,0)) AS RealMDxV
        ,sum(ifnull(redgslsxv_mrf,0)) AS RedGSlsxV
        ,sum(ifnull(redslsv_mrf,0)) AS RedSlsV
        ,sum(ifnull(fppgslsxv_mrf,0) +ifnull(redgslsxv_mrf,0)+ifnull(realmdxv_mrf,0)) - sum(ifnull(fppslsc_mrf,0) + ifnull(redslsc_mrf,0)) AS TotBIMAV
        ,sum(ifnull(fppgslsxv_mrf,0) +ifnull(redgslsxv_mrf,0)+ifnull(realmdxv_mrf,0)) AS TotBIMBV
        ,CASE WHEN (sum(ifnull(fppgslsxv_mrf,0) +ifnull(redgslsxv_mrf,0)+ifnull(realmdxv_mrf,0)))=0 THEN 0 
        ELSE(sum(ifnull(fppgslsxv_mrf,0) +ifnull(redgslsxv_mrf,0)+ifnull(realmdxv_mrf,0)) - sum(ifnull(fppslsc_mrf,0) + ifnull(redslsc_mrf,0)))/(sum(ifnull(fppgslsxv_mrf,0) +ifnull(redgslsxv_mrf,0)+ifnull(realmdxv_mrf,0)))*100 end AS TotBIMP
        ,sum(ifnull(fppgsmv_mrf,0)+ifnull(redgsmv_mrf,0)) AS TotGSMV
        ,sum(ifnull(fppposv_mrf,0)+ifnull(redposv_mrf,0)) AS TotPoSV
        ,sum(ifnull(fppslsc_mrf,0) + ifnull(redslsc_mrf,0)) AS TotSlsC
        ,sum(ifnull(fppslsv_mrf,0)+ifnull(redslsv_mrf,0)) AS TotSlsV
        ,sum(ifnull(fppslsxv_mrf,0)+ifnull(redslsxv_mrf,0)) AS TotSlsxV
        ,sum(ifnull(fppstdv_mrf,0)+ifnull(redstdv_mrf,0)) TotStDV
        ,sum(0) AS TotPromoActV
        ,sum(ifnull(fpprevintu_mrf,0)) as fpp_rev_intake_units
        ,sum(ifnull(fpprevintv_mrf,0)) as fpp_rev_intake_val
        FROM beam_prod.mp_analyse_prod.mns_pl_mrf_t_nsaz_tbl mrf
        GROUP BY  cast(Right(calendar,8) AS int)
            ,concat('G5-', substring(product,4,3))

    UNION ALL

    -- Outlets
        SELECT 'RF' AS plan
        ,'05' AS channel
        ,cast(Right(calendar,8) AS int) AS calendar
        ,product
        ,sum(ifnull(fpposv_df,0)+ifnull(prposv_df,0)) as DiscMDV
        ,sum(ifnull(fpgslsxv_df,0)) as FPGSlsxV 
        ,sum(ifnull(fpgslsxv_df,0)+ifnull(prgslsxv_df,0)) as FPPGSlsxV 
        ,sum(ifnull(fpslsv_df,0)+ifnull(prslsv_df,0)) as FPPSlsV
        ,sum(ifnull(fpslsxv_df,0)+ifnull(prslsxv_df,0)) as FPPSlsxV
        ,sum(ifnull(fpslsv_df,0)) as FPSlsV
        ,sum(ifnull(prgslsxv_df,0)) as PrGSlsxV
        ,sum(ifnull(prslsv_df,0)) as PrRedSlsV
        ,sum(ifnull(prslsv_df,0)) as PrSlsV
        ,sum(0) as RealMDV
        ,sum(0) as RealMDxV
        ,sum(0) as RedGSlsxV
        ,sum(0) as RedSlsV
        ,sum(ifnull(fpgslsxv_df,0) +ifnull(prgslsxv_df,0)) - sum(ifnull(fpslsc_df,0) + ifnull(prslsc_df,0)) as TotBIMAV
        ,sum(ifnull(fpgslsxv_df,0) +ifnull(prgslsxv_df,0)) as TotBIMBV
        ,case when (sum(ifnull(fpgslsxv_df,0) +ifnull(prgslsxv_df,0)))=0 then 0 else
        (sum(ifnull(fpgslsxv_df,0) +ifnull(prgslsxv_df,0)) - sum(ifnull(fpslsc_df,0) + ifnull(prslsc_df,0)))/(sum(ifnull(fpgslsxv_df,0) +ifnull(prgslsxv_df,0)))*100 end as TotBIMP
        ,sum(ifnull(fpgsmv_df,0)+ifnull(prgsmv_df,0)) as TotGSMV
        ,sum(ifnull(fpposv_df,0)+ifnull(prposv_df,0)) as TotPoSV
        ,sum(ifnull(fpslsc_df,0) + ifnull(prslsc_df,0)) as TotSlsC
        ,sum(ifnull(fpslsv_df,0)+ifnull(prslsv_df,0)) as TotSlsV
        ,sum(ifnull(fpslsxv_df,0)+ifnull(prslsxv_df,0)) as TotSlsxV
        ,sum(0) TotStDV
        ,sum(ifnull(fpposv_df,0)+ifnull(prposv_df,0)) as TotPromoActV
        ,sum(0) as fpp_rev_intake_units
        ,sum(0) as fpp_rev_intake_val
        from beam_prod.mp_analyse_prod.mns_pl_df_t_nsaz_tbl df
        group by  cast(Right(calendar,8) AS int)
            ,product

    UNION ALL

        SELECT 'BUDGET' AS plan
        ,'05' AS channel
        ,cast(Right(calendar,8) AS int) AS calendar
        ,product
        ,sum(ifnull(fpposv_oukpi,0)+ifnull(prposv_oukpi,0)) as DiscMDV
        ,sum(ifnull(fpgslsxv_oukpi,0)) as FPGSlsxV 
        ,sum(ifnull(fpgslsxv_oukpi,0)+ifnull(prgslsxv_oukpi,0)) as FPPGSlsxV 
        ,sum(ifnull(fpslsv_oukpi,0)+ifnull(prslsv_oukpi,0)) as FPPSlsV
        ,sum(ifnull(fpslsxv_oukpi,0)+ifnull(prslsxv_oukpi,0)) as FPPSlsxV
        ,sum(ifnull(fpslsv_oukpi,0)) as FPSlsV
        ,sum(ifnull(prgslsxv_oukpi,0)) as PrGSlsxV
        ,sum(ifnull(prslsv_oukpi,0)) as PrRedSlsV
        ,sum(ifnull(prslsv_oukpi,0)) as PrSlsV
        ,sum(0) as RealMDV
        ,sum(0) as RealMDxV
        ,sum(0) as RedGSlsxV
        ,sum(0) as RedSlsV
        ,sum(ifnull(fpgslsxv_oukpi,0) +ifnull(prgslsxv_oukpi,0)) - sum(ifnull(fpslsc_oukpi,0) + ifnull(prslsc_oukpi,0)) as TotBIMAV
        ,sum(ifnull(fpgslsxv_oukpi,0) +ifnull(prgslsxv_oukpi,0)) as TotBIMBV
        ,case when (sum(ifnull(fpgslsxv_oukpi,0) +ifnull(prgslsxv_oukpi,0)))=0 then 0 else
        (sum(ifnull(fpgslsxv_oukpi,0) +ifnull(prgslsxv_oukpi,0)) - sum(ifnull(fpslsc_oukpi,0) + ifnull(prslsc_oukpi,0)))/(sum(ifnull(fpgslsxv_oukpi,0) +ifnull(prgslsxv_oukpi,0)))*100 end as TotBIMP
        ,sum(ifnull(fpgsmv_oukpi,0)+ifnull(prgsmv_oukpi,0)) as TotGSMV
        ,sum(ifnull(fpposv_oukpi,0)+ifnull(prposv_oukpi,0)) as TotPoSV
        ,sum(ifnull(fpslsc_oukpi,0) + ifnull(prslsc_oukpi,0)) as TotSlsC
        ,sum(ifnull(fpslsv_oukpi,0)+ifnull(prslsv_oukpi,0)) as TotSlsV
        ,sum(ifnull(fpslsxv_oukpi,0)+ifnull(prslsxv_oukpi,0)) as TotSlsxV
        ,sum(0) TotStDV
        ,sum(ifnull(fpposv_oukpi,0)+ifnull(prposv_oukpi,0)) as TotPromoActV
        ,sum(0) as fpp_rev_intake_units
        ,sum(0) as fpp_rev_intake_val
        from beam_prod.mp_analyse_prod.mns_pl_oukpi_t_nsaz_tbl oukpi
        group by  cast(Right(calendar,8) AS int)
            ,product
        
    union all
        
        SELECT 'QRF' AS plan
        ,'05' AS channel
        ,cast(Right(calendar,8) AS int) AS calendar
        ,product
        ,sum(ifnull(fpposv_qdf,0)+ifnull(prposv_qdf,0)) as DiscMDV
        ,sum(ifnull(fpgslsxv_qdf,0)) as FPGSlsxV 
        ,sum(ifnull(fpgslsxv_qdf,0)+ifnull(prgslsxv_qdf,0)) as FPPGSlsxV 
        ,sum(ifnull(fpslsv_qdf,0)+ifnull(prslsv_qdf,0)) as FPPSlsV
        ,sum(ifnull(fpslsxv_qdf,0)+ifnull(prslsxv_qdf,0)) as FPPSlsxV
        ,sum(ifnull(fpslsv_qdf,0)) as FPSlsV
        ,sum(ifnull(prgslsxv_qdf,0)) as PrGSlsxV
        ,sum(ifnull(prslsv_qdf,0)) as PrRedSlsV
        ,sum(ifnull(prslsv_qdf,0)) as PrSlsV
        ,sum(0) as RealMDV
        ,sum(0) as RealMDxV
        ,sum(0) as RedGSlsxV
        ,sum(0) as RedSlsV
        ,sum(ifnull(fpgslsxv_qdf,0) +ifnull(prgslsxv_qdf,0)) - sum(ifnull(fpslsc_qdf,0) + ifnull(prslsc_qdf,0)) as TotBIMAV
        ,sum(ifnull(fpgslsxv_qdf,0) +ifnull(prgslsxv_qdf,0)) as TotBIMBV
        ,case when (sum(ifnull(fpgslsxv_qdf,0) +ifnull(prgslsxv_qdf,0)))=0 then 0 else
        (sum(ifnull(fpgslsxv_qdf,0) +ifnull(prgslsxv_qdf,0)) - sum(ifnull(fpslsc_qdf,0) + ifnull(prslsc_qdf,0)))/(sum(ifnull(fpgslsxv_qdf,0) +ifnull(prgslsxv_qdf,0)))*100 end as TotBIMP
        ,sum(ifnull(fpgsmv_qdf,0)+ifnull(prgsmv_qdf,0)) as TotGSMV
        ,sum(ifnull(fpposv_qdf,0)+ifnull(prposv_qdf,0)) as TotPoSV
        ,sum(ifnull(fpslsc_qdf,0) + ifnull(prslsc_qdf,0)) as TotSlsC
        ,sum(ifnull(fpslsv_qdf,0)+ifnull(prslsv_qdf,0)) as TotSlsV
        ,sum(ifnull(fpslsxv_qdf,0)+ifnull(prslsxv_qdf,0)) as TotSlsxV
        ,sum(0) TotStDV
        ,sum(ifnull(fpposv_qdf,0)+ifnull(prposv_qdf,0)) as TotPromoActV
        ,sum(0) as fpp_rev_intake_units
        ,sum(0) as fpp_rev_intake_val
        from beam_prod.mp_analyse_prod.mns_pl_qdf_t_nsaz_tbl qdf
        group by  cast(Right(calendar,8) AS int)
            ,product

    union all
        
        SELECT 'MRF' AS plan
        ,'05' AS channel
        ,cast(Right(calendar,8) AS int) AS calendar
        ,product
        ,sum(ifnull(fpposv_mdf,0)+ifnull(prposv_mdf,0)) as DiscMDV
        ,sum(ifnull(fpgslsxv_mdf,0)) as FPGSlsxV 
        ,sum(ifnull(fpgslsxv_mdf,0)+ifnull(prgslsxv_mdf,0)) as FPPGSlsxV 
        ,sum(ifnull(fpslsv_mdf,0)+ifnull(prslsv_mdf,0)) as FPPSlsV
        ,sum(ifnull(fpslsxv_mdf,0)+ifnull(prslsxv_mdf,0)) as FPPSlsxV
        ,sum(ifnull(fpslsv_mdf,0)) as FPSlsV
        ,sum(ifnull(prgslsxv_mdf,0)) as PrGSlsxV
        ,sum(ifnull(prslsv_mdf,0)) as PrRedSlsV
        ,sum(ifnull(prslsv_mdf,0)) as PrSlsV
        ,sum(0) as RealMDV
        ,sum(0) as RealMDxV
        ,sum(0) as RedGSlsxV
        ,sum(0) as RedSlsV
        ,sum(ifnull(fpgslsxv_mdf,0) +ifnull(prgslsxv_mdf,0)) - sum(ifnull(fpslsc_mdf,0) + ifnull(prslsc_mdf,0)) as TotBIMAV
        ,sum(ifnull(fpgslsxv_mdf,0) +ifnull(prgslsxv_mdf,0)) as TotBIMBV
        ,case when (sum(ifnull(fpgslsxv_mdf,0) +ifnull(prgslsxv_mdf,0)))=0 then 0 else
        (sum(ifnull(fpgslsxv_mdf,0) +ifnull(prgslsxv_mdf,0)) - sum(ifnull(fpslsc_mdf,0) + ifnull(prslsc_mdf,0)))/(sum(ifnull(fpgslsxv_mdf,0) +ifnull(prgslsxv_mdf,0)))*100 end as TotBIMP
        ,sum(ifnull(fpgsmv_mdf,0)+ifnull(prgsmv_mdf,0)) as TotGSMV
        ,sum(ifnull(fpposv_mdf,0)+ifnull(prposv_mdf,0)) as TotPoSV
        ,sum(ifnull(fpslsc_mdf,0) + ifnull(prslsc_mdf,0)) as TotSlsC
        ,sum(ifnull(fpslsv_mdf,0)+ifnull(prslsv_mdf,0)) as TotSlsV
        ,sum(ifnull(fpslsxv_mdf,0)+ifnull(prslsxv_mdf,0)) as TotSlsxV
        ,sum(0) TotStDV
        ,sum(ifnull(fpposv_mdf,0)+ifnull(prposv_mdf,0)) as TotPromoActV
        ,sum(0) as fpp_rev_intake_units
        ,sum(0) as fpp_rev_intake_val
        from beam_prod.mp_analyse_prod.mns_pl_mdf_t_nsaz_tbl mdf
        group by  cast(Right(calendar,8) AS int)
            ,product

)

SELECT 
    -1 AS siteID
    ,cal.fiscalWeek
    ,plan
    , CASE 
        WHEN mp.product IN ('G5-T39', 'G5-T65', 'G5-T84')
            AND mp.channel NOT IN ('03', '05', '11')
        THEN '11'
        ELSE mp.channel
        END AS channel
    ,product
    ,-DiscMDV AS DiscMDV
    ,FPGSlsxV
    ,FPPGSlsxV
    ,FPPSlsV
    ,FPPSlsxV
    ,FPSlsV
    ,PrGSlsxV
    ,PrRedSlsV
    ,PrSlsV
    ,-RealMDV AS RealMDV
    ,-RealMDxV AS RealMDxV
    ,RedGSlsxV
    ,RedSlsV
    ,TotBIMAV
    ,TotBIMBV
    ,TotBIMP
    ,TotGSMV
    ,-TotPoSV AS TotPoSV
    ,-TotSlsC AS TotSlsC
    ,TotSlsV
    ,TotSlsxV
    ,-TotStDV AS TotStDV
    ,-TotPromoActV AS TotPromoActV
    ,RedSlsV - RealMDV AS SST
    ,RealMDV - RedSlsV AS DoC
    ,fpp_rev_intake_units
    ,fpp_rev_intake_val
FROM mp
INNER JOIN beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl cal
    ON mp.calendar = cal.calendarID
WHERE calendar IN (
    SELECT DISTINCT calendarID
    FROM beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl
    WHERE fiscalYear BETWEEN
            (SELECT max(fiscalYear)
            FROM beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl cal
            WHERE fiscalWeekEndingDate <= GETDATE()
            ) - 1
        AND (SELECT max(fiscalYear)
            FROM beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl cal
            WHERE fiscalWeekEndingDate <= GETDATE()
        ) + 1
)
    AND mp.product NOT IN ('G5-T46')