CREATE OR REPLACE VIEW beam_prod.finance_azlab_prod.fact_mp_stock_fhbwk AS
WITH mp AS (
    SELECT
        'RF' AS plan
        ,'01' AS channel
        , cast(right(calendar,8) AS int) AS calendar
        , concat('G5-', substring(product,4,3)) AS product
        , sum(ifnull(fppstclstkv_rf,0)) AS fpp_str_cls_stk_val
        , sum(ifnull(fppdcclstkv_rf,0)) AS fpp_dc_cls_stk_val
        , sum(ifnull(fppstclstkv_rf,0)) + sum(ifnull(fppdcclstkv_rf,0))  AS fpp_tot_cls_stk_val
        , sum(ifnull(fppstclstkv_rf,0)) + sum(ifnull(redstclstkv_rf,0)) AS tot_str_cls_stk_val
        , sum(ifnull(reddcclstkv_rf,0)) + sum(ifnull(fppdcclstkv_rf,0)) AS tot_dc_cls_stk_val
        , sum(ifnull(reddcclstkv_rf,0))+ sum(ifnull(redstclstkv_rf,0)) + sum(ifnull(fppstclstkv_rf,0)) + sum(ifnull(fppdcclstkv_rf,0)) AS tot_tot_cls_stk_val
    FROM beam_prod.mp_analyse_prod.mns_pl_rf_t_nsaz_tbl rf
    GROUP BY  cast(right(calendar,8) AS int)
        , concat('G5-', substring(product,4,3))

    UNION ALL

    SELECT
        'BUDGET' AS plan
        ,'01' AS channel
        , cast(right(calendar,8) AS int) AS calendar
        , concat('G5-', substring(product,4,3)) AS product
        , sum(ifnull(fppstclstkv_opkpi,0)) AS fpp_str_cls_stk_val
        , sum(ifnull(fppdcclstkv_opkpi,0)) AS fpp_dc_cls_stk_val
        , sum(ifnull(fppstclstkv_opkpi,0)) + sum(ifnull(fppdcclstkv_opkpi,0))  AS fpp_tot_cls_stk_val
        , sum(ifnull(fppstclstkv_opkpi,0)) + sum(ifnull(redstclstkv_opkpi,0)) AS tot_str_cls_stk_val
        , sum(ifnull(reddcclstkv_opkpi,0)) + sum(ifnull(fppdcclstkv_opkpi,0)) AS tot_dc_cls_stk_val
        , sum(ifnull(reddcclstkv_opkpi,0)) + sum(ifnull(redstclstkv_opkpi,0)) + sum(ifnull(fppstclstkv_opkpi,0)) + sum(ifnull(fppdcclstkv_opkpi,0)) AS tot_tot_cls_stk_val
    FROM beam_prod.mp_analyse_prod.mns_pl_opkpi_t_nsaz_tbl opkpi
    GROUP BY  cast(right(calendar,8) AS int)
        , concat('G5-', substring(product,4,3))

    UNION ALL

    SELECT
        'QRF' AS plan
        ,'01' AS channel
        , cast(right(calendar,8) AS int) AS calendar
        , concat('G5-', substring(product,4,3)) AS product
        , sum(ifnull(fppstclstkv_qrf,0)) AS fpp_str_cls_stk_val
        , sum(ifnull(fppdcclstkv_qrf,0)) AS fpp_dc_cls_stk_val
        , sum(ifnull(fppstclstkv_qrf,0)) + sum(ifnull(fppdcclstkv_qrf,0))  AS fpp_tot_cls_stk_val
        , sum(ifnull(fppstclstkv_qrf,0)) + sum(ifnull(redstclstkv_qrf,0)) AS tot_str_cls_stk_val
        , sum(ifnull(reddcclstkv_qrf,0)) + sum(ifnull(fppdcclstkv_qrf,0)) AS tot_dc_cls_stk_val
        , sum(ifnull(reddcclstkv_qrf,0))+ sum(ifnull(redstclstkv_qrf,0)) + sum(ifnull(fppstclstkv_qrf,0)) + sum(ifnull(fppdcclstkv_qrf,0)) AS tot_tot_cls_stk_val
    FROM beam_prod.mp_analyse_prod.mns_pl_qrf_t_nsaz_tbl qrf
    GROUP BY  cast(right(calendar,8) AS int)
        , concat('G5-', substring(product,4,3))
    
    UNION ALL

    SELECT
        'RF' AS plan
        ,'05' AS channel
        , cast(right(calendar,8) AS int) AS calendar
        , concat('G5-', substring(product,4,3)) AS product
        , sum(ifnull(stclstkv_df,0)) AS fpp_str_cls_stk_val
        , sum(ifnull(dcclstkv_df,0)) AS fpp_dc_cls_stk_val
        , sum(ifnull(stclstkv_df,0)) + sum(ifnull(dcclstkv_df,0))  AS fpp_tot_cls_stk_val
        , sum(ifnull(stclstkv_df,0)) AS tot_str_cls_stk_val
        , sum(ifnull(dcclstkv_df,0)) AS tot_dc_cls_stk_val
        , sum(ifnull(stclstkv_df,0)) + sum(ifnull(dcclstkv_df,0)) AS tot_tot_cls_stk_val
    FROM beam_prod.mp_analyse_prod.mns_pl_df_t_nsaz_tbl rf
    GROUP BY  cast(right(calendar,8) AS int)
        , concat('G5-', substring(product,4,3))

    UNION ALL

    SELECT
        'BUDGET' AS plan
        ,'05' AS channel
        , cast(right(calendar,8) AS int) AS calendar
        , concat('G5-', substring(product,4,3)) AS product
        , sum(ifnull(stclstkv_oukpi,0)) AS fpp_str_cls_stk_val
        , sum(ifnull(dcclstkv_oukpi,0)) AS fpp_dc_cls_stk_val
        , sum(ifnull(stclstkv_oukpi,0)) + sum(ifnull(dcclstkv_oukpi,0))  AS fpp_tot_cls_stk_val
        , sum(ifnull(stclstkv_oukpi,0)) AS tot_str_cls_stk_val
        , sum(ifnull(dcclstkv_oukpi,0)) AS tot_dc_cls_stk_val
        , sum(ifnull(stclstkv_oukpi,0)) + sum(ifnull(dcclstkv_oukpi,0)) AS tot_tot_cls_stk_val
    FROM beam_prod.mp_analyse_prod.mns_pl_oukpi_t_nsaz_tbl opkpi
    GROUP BY  cast(right(calendar,8) AS int)
        , concat('G5-', substring(product,4,3))

    UNION ALL

    SELECT
        'QRF' AS plan
        ,'05' AS channel
        , cast(right(calendar,8) AS int) AS calendar
        , concat('G5-', substring(product,4,3)) AS product
        , sum(ifnull(stclstkv_qdf,0)) AS fpp_str_cls_stk_val
        , sum(ifnull(dcclstkv_qdf,0)) AS fpp_dc_cls_stk_val
        , sum(ifnull(stclstkv_qdf,0)) + sum(ifnull(dcclstkv_qdf,0))  AS fpp_tot_cls_stk_val
        , sum(ifnull(stclstkv_qdf,0)) AS tot_str_cls_stk_val
        , sum(ifnull(dcclstkv_qdf,0)) AS tot_dc_cls_stk_val
        , sum(ifnull(stclstkv_qdf,0)) + sum(ifnull(dcclstkv_qdf,0)) AS tot_tot_cls_stk_val
    FROM beam_prod.mp_analyse_prod.mns_pl_qdf_t_nsaz_tbl qrf
    GROUP BY  cast(right(calendar,8) AS int)
        , concat('G5-', substring(product,4,3))
)

SELECT cal.fiscalWeek
    , mp.plan
    , mp.channel
    , mp.product
    , mp.fpp_str_cls_stk_val
    , mp.fpp_dc_cls_stk_val
    , mp.fpp_tot_cls_stk_val
    , mp.tot_str_cls_stk_val
    , mp.tot_dc_cls_stk_val
    , mp.tot_tot_cls_stk_val
FROM mp
INNER JOIN beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl cal
    ON mp.calendar = cal.calendarID
WHERE cast(right(calendar,8) AS int) IN (
    SELECT DISTINCT calendarID
    FROM beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl
    WHERE fiscalWeek IN (
        SELECT fiscalWeek
        FROM beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl
        WHERE naturalDate = DATEADD(DAY, -7, CAST(GETDATE() AS date))
    )
    OR fiscalWeek IN (
        SELECT fiscalWeekLastWeek
        FROM beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl
        WHERE naturalDate = DATEADD(DAY, -7, CAST(GETDATE() AS date))
    )
    OR fiscalWeek IN (
        SELECT fiscalWeekLastYear
        FROM beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl
        WHERE naturalDate = DATEADD(DAY, -7, CAST(GETDATE() AS date))
    )
)