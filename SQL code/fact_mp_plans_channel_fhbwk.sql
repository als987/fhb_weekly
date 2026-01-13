CREATE OR REPLACE VIEW beam_prod.finance_azlab_prod.fact_mp_plans_channel_fhbwk AS

WITH mp AS (
    --Web
        SELECT
            'BUDGET' AS plan
            ,'03' AS channel
            ,product
            ,cast(Right(calendar,8) AS int) AS calendar
            ,sum(ifnull(fpslsv_aweb,0)) + sum(ifnull(prslsv_aweb,0)) AS fppslsv
            ,sum(ifnull(redslsv_aweb,0)) AS redslsv
        FROM beam_prod.mp_analyse_prod.mns_pl_aweb_t_nsaz_tbl
        WHERE organization = 'UK_ECOM'
        GROUP BY  product, calendar

    UNION ALL

        SELECT
            'QRF' AS plan
            ,'03' AS channel
            ,product
            ,cast(Right(calendar,8) AS int) AS calendar
            ,sum(ifnull(fpslsv_qweb,0)) + sum(ifnull(prslsv_qweb,0)) AS fppslsv
            ,sum(ifnull(redslsv_qweb,0)) AS redslsv
        FROM beam_prod.mp_analyse_prod.mns_pl_qweb_t_nsaz_tbl
        WHERE organization = 'UK_ECOM'
        GROUP BY  product, calendar

    UNION ALL

        SELECT
            'MRF' AS plan
            ,'03' AS channel
            ,product
            ,cast(Right(calendar,8) AS int) AS calendar
            ,sum(ifnull(fpslsv_mweb,0)) + sum(ifnull(prslsv_mweb,0)) AS fppslsv
            ,sum(ifnull(redslsv_mweb,0)) AS redslsv
        FROM beam_prod.mp_analyse_prod.mns_pl_mweb_t_nsaz_tbl
        WHERE organization = 'UK_ECOM'
        GROUP BY  product, calendar

    UNION ALL

        SELECT
            'RF' AS plan
            ,'03' AS channel
            ,product
            ,cast(Right(calendar,8) AS int) AS calendar
            ,sum(ifnull(fpslsv_web,0)) + sum(ifnull(prslsv_web,0)) AS fppslsv
            ,sum(ifnull(redslsv_web,0)) AS redslsv
        FROM beam_prod.mp_analyse_prod.mns_pl_web_t_nsaz_tbl
        WHERE organization = 'UK_ECOM'
        GROUP BY  product, calendar

    --Retail
    UNION ALL

        SELECT
            'BUDGET' AS plan
            ,'01' AS channel
            ,tot.product
            ,cast(Right(tot.calendar,8) AS int) AS calendar
            ,sum(COALESCE(ifnull(fppslsv_opkpi,0),0) - COALESCE(ifnull(fppslsv_aweb,0),0)) AS fppslsv
            ,sum(COALESCE(ifnull(redslsv_opkpi,0),0) - COALESCE(ifnull(redslsv_aweb,0),0)) AS redslsv
        FROM (
            SELECT
                concat('G5-', substring(opkpi.product,4,3)) AS product
                ,calendar
                ,sum(ifnull(fppslsv_opkpi,0)) AS fppslsv_opkpi
                ,sum(ifnull(redslsv_opkpi,0)) AS redslsv_opkpi
            FROM beam_prod.mp_analyse_prod.mns_pl_opkpi_t_nsaz_tbl opkpi
            GROUP BY concat('G5-', substring(opkpi.product,4,3)), calendar) tot
            LEFT JOIN (
                SELECT product
                    , sum(ifnull(fpslsv_aweb,0) + ifnull(prslsv_aweb,0)) AS fppslsv_aweb
                    , sum(ifnull(redslsv_aweb,0)) AS redslsv_aweb
                    , calendar
                FROM beam_prod.mp_analyse_prod.mns_pl_aweb_t_nsaz_tbl
                WHERE organization = 'UK_ECOM'
                GROUP BY product,calendar
                ) aweb
            ON tot.calendar = aweb.calendar AND tot.product = aweb.product
        GROUP BY tot.product, tot.calendar

    UNION ALL

        SELECT
            'QRF' AS plan
            ,'01' AS channel
            ,tot.product
            ,cast(Right(tot.calendar,8) AS int) AS calendar
            ,sum(COALESCE(ifnull(fppslsv_qrf,0),0) - COALESCE(ifnull(fppslsv_qweb,0),0)) AS fppslsv
            ,sum(COALESCE(ifnull(redslsv_qrf,0),0) - COALESCE(ifnull(redslsv_qweb,0),0)) AS redslsv
        FROM (
            SELECT
                concat('G5-', substring(qrf.product,4,3)) AS product
                ,calendar
                ,sum(ifnull(fppslsv_qrf,0)) AS fppslsv_qrf
                ,sum(ifnull(redslsv_qrf,0)) AS redslsv_qrf
            FROM beam_prod.mp_analyse_prod.mns_pl_qrf_t_nsaz_tbl qrf
            GROUP BY concat('G5-', substring(qrf.product,4,3)), calendar) tot
            LEFT JOIN (
                SELECT product
                    , sum(ifnull(fpslsv_qweb,0) + ifnull(prslsv_qweb,0)) AS fppslsv_qweb
                    , sum(ifnull(redslsv_qweb,0)) AS redslsv_qweb
                    , calendar
                FROM beam_prod.mp_analyse_prod.mns_pl_qweb_t_nsaz_tbl
                WHERE organization = 'UK_ECOM'
                GROUP BY product,calendar
                ) qweb
            ON tot.calendar = qweb.calendar AND tot.product = qweb.product
        GROUP BY tot.product, tot.calendar

    UNION ALL

        SELECT
            'MRF' AS plan
            ,'01' AS channel
            ,tot.product
            ,cast(Right(tot.calendar,8) AS int) AS calendar
            ,sum(COALESCE(ifnull(fppslsv_mrf,0),0) - COALESCE(ifnull(fppslsv_mweb,0),0)) AS fppslsv
            ,sum(COALESCE(ifnull(redslsv_mrf,0),0) - COALESCE(ifnull(redslsv_mweb,0),0)) AS redslsv
        FROM (
            SELECT
                concat('G5-', substring(mrf.product,4,3)) AS product
                ,calendar
                ,sum(ifnull(fppslsv_mrf,0)) AS fppslsv_mrf
                ,sum(ifnull(redslsv_mrf,0)) AS redslsv_mrf
            FROM beam_prod.mp_analyse_prod.mns_pl_mrf_t_nsaz_tbl mrf
            GROUP BY concat('G5-', substring(mrf.product,4,3)), calendar) tot
            LEFT JOIN (
                SELECT product
                    , sum(ifnull(fpslsv_mweb,0) + ifnull(prslsv_mweb,0)) AS fppslsv_mweb
                    , sum(ifnull(redslsv_mweb,0)) AS redslsv_mweb
                    , calendar
                FROM beam_prod.mp_analyse_prod.mns_pl_mweb_t_nsaz_tbl
                WHERE organization = 'UK_ECOM'
                GROUP BY product,calendar
                ) mweb
            ON tot.calendar = mweb.calendar AND tot.product = mweb.product
        GROUP BY tot.product, tot.calendar

    UNION ALL

        SELECT
            'RF' AS plan
            ,'01' AS channel
            ,tot.product
            ,cast(Right(tot.calendar,8) AS int) AS calendar
            ,sum(COALESCE(ifnull(fppslsv_rf,0),0) - COALESCE(ifnull(fppslsv_web,0),0)) AS fppslsv
            ,sum(COALESCE(ifnull(redslsv_rf,0),0) - COALESCE(ifnull(redslsv_web,0),0)) AS redslsv
        FROM (
            SELECT
                concat('G5-', substring(rf.product,4,3)) AS product
                ,calendar
                ,sum(ifnull(fppslsv_rf,0)) AS fppslsv_rf
                ,sum(ifnull(redslsv_rf,0)) AS redslsv_rf
            FROM beam_prod.mp_analyse_prod.mns_pl_rf_t_nsaz_tbl rf
            GROUP BY concat('G5-', substring(rf.product,4,3)), calendar) tot
            LEFT JOIN (
                SELECT product
                    , sum(ifnull(fpslsv_web,0) + ifnull(prslsv_web,0)) AS fppslsv_web
                    , sum(ifnull(redslsv_web,0)) AS redslsv_web
                    , calendar
                FROM beam_prod.mp_analyse_prod.mns_pl_web_t_nsaz_tbl
                WHERE organization = 'UK_ECOM'
                GROUP BY product,calendar
                ) web
            ON tot.calendar = web.calendar AND tot.product = web.product
        GROUP BY tot.product, tot.calendar

    --Outlets
    UNION ALL

        SELECT
            'BUDGET' AS plan
            ,'05' AS channel
            ,product
            ,cast(Right(calendar,8) AS int) AS calendar
            ,sum(ifnull(fpslsv_oukpi,0)) + sum(ifnull(prslsv_oukpi,0)) AS fppslsv
            ,0 AS redslsv
        FROM beam_prod.mp_analyse_prod.mns_pl_oukpi_t_nsaz_tbl
        GROUP BY  product, calendar

    UNION ALL

        SELECT
            'QRF' AS plan
            ,'05' AS channel
            ,product
            ,cast(Right(calendar,8) AS int) AS calendar
            ,sum(ifnull(fpslsv_qdf,0)) + sum(ifnull(prslsv_qdf,0)) AS fppslsv
            ,0 AS redslsv
        FROM beam_prod.mp_analyse_prod.mns_pl_qdf_t_nsaz_tbl
        GROUP BY  product, calendar

    UNION ALL

        SELECT
            'MRF' AS plan
            ,'05' AS channel
            ,product
            ,cast(Right(calendar,8) AS int) AS calendar
            ,sum(ifnull(fpslsv_mdf,0)) + sum(ifnull(prslsv_mdf,0)) AS fppslsv
            ,0 AS redslsv
        FROM beam_prod.mp_analyse_prod.mns_pl_mdf_t_nsaz_tbl
        GROUP BY  product, calendar

    UNION ALL

        SELECT
            'RF' AS plan
            ,'05' AS channel
            ,product
            ,cast(Right(calendar,8) AS int) AS calendar
            ,sum(ifnull(fpslsv_df,0)) + sum(ifnull(prslsv_df,0)) AS fppslsv
            ,0 AS redslsv
        FROM beam_prod.mp_analyse_prod.mns_pl_df_t_nsaz_tbl
        GROUP BY  product, calendar
)

SELECT
    cal.fiscalWeek
    , mp.plan
    , CASE 
        WHEN mp.product IN ('G5-T39', 'G5-T65', 'G5-T84')
            AND mp.channel NOT IN ('03', '05', '11')
        THEN '11'
        ELSE mp.channel
        END AS channel
    , mp.product
    , mp.fppslsv
    , mp.redslsv
    , -1 AS siteID
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