CREATE
OR REPLACE VIEW beam_prod.finance_azlab_prod.fact_stock_fhbwk AS
WITH
    included_weeks AS (
        SELECT DISTINCT
            fiscalWeek,
            fiscalWeekLastYear
        FROM
            beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl
        WHERE
            fiscalWeekEndingDate = (
                SELECT
                    MAX(fiscalWeekEndingDate) AS current_fiscal_week
                FROM
                    beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl
                WHERE
                    naturalDate = CAST(DATEADD (DAY, -7, GETDATE ()) AS date)
            )
    ),
    base AS (
        SELECT
            cal.fiscalWeek,
            sit.partyCode AS comp_code,
            sit.siteID,
            pro.producthierarchylevel5nodeid AS dept,
            CASE
                WHEN (
                    RIGHT (pro.producthierarchylevel5nodeid, 3) IN ('T39', 'T65', 'T84')
                    AND sit.channelCode NOT IN ('03', '05', '11')
                ) THEN '11'
                ELSE sit.channelCode
            END AS channel,
            sto.stockMetric,
            CASE
                WHEN sit.shapeOfChainName = 'Outlets' THEN 'F'
                WHEN sto.priceIndicator IN ('M', 'R') THEN 'R'
                WHEN sto.priceIndicator IN ('P') THEN 'P'
                ELSE 'F'
            END AS fp_rp_ind,
            SUM(
                CASE
                    WHEN sto.stockMetric = 'Units' THEN sto.valueInclInTransit
                    ELSE 0
                END
            ) AS qty,
            SUM(
                CASE
                    WHEN sto.stockMetric = 'Value' THEN sto.valueInclInTransit
                    ELSE 0
                END
            ) AS val
        FROM
            beam_prod.commercialops_cnh_prod.factweeklystock_saz_tbl sto
            LEFT JOIN beam_prod.masterdata_present_prod.dimsite_nsaz_tbl sit ON sto.siteId = sit.siteID
            LEFT JOIN beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl cal ON sto.calendarid = cal.calendarID
            LEFT JOIN beam_prod.masterdata_present_prod.dimproduct_nsaz_tbl pro ON sto.productID = pro.dimproductkey
        WHERE
            sit.worldwideHierCode IN ('ZWIDE03', 'ZWIDE03', 'ZWIDE04')
            AND pro.producthierarchylevel5nodeid NOT IN ('G5-T46')
            AND sit.partyCode IN (1000, 3000)
            AND (
                cal.fiscalWeek = (
                    SELECT
                        fiscalWeek
                    FROM
                        included_weeks
                )
                OR cal.fiscalWeek = (
                    SELECT
                        fiscalWeekLastYear
                    FROM
                        included_weeks
                )
            )
            AND NOT cal.fiscalWeek BETWEEN 202604 and 202621
        GROUP BY
            cal.fiscalWeek,
            sit.partyCode,
            sit.siteID,
            pro.producthierarchylevel5nodeid,
            CASE
                WHEN (
                    RIGHT (pro.producthierarchylevel5nodeid, 3) IN ('T39', 'T65', 'T84')
                    AND sit.channelCode NOT IN ('03', '05', '11')
                ) THEN '11'
                ELSE sit.channelCode
            END,
            CASE
                WHEN sit.shapeOfChainName = 'Outlets' THEN 'F'
                WHEN sto.priceIndicator IN ('M', 'R') THEN 'R'
                WHEN sto.priceIndicator IN ('P') THEN 'P'
                ELSE 'F'
            END,
            sto.stockMetric
    )
SELECT
    fiscalWeek,
    comp_code,
    siteID,
    dept,
    channel,
    fp_rp_ind,
    SUM(qty) AS qty,
    SUM(val) AS val
FROM
    base
GROUP BY
    fiscalWeek,
    comp_code,
    siteID,
    dept,
    channel,
    fp_rp_ind