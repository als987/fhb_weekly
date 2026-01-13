CREATE
OR REPLACE VIEW beam_prod.finance_azlab_prod.fact_ordervol_fhbwk AS
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
    CASE
        WHEN sit.shapeOfChainName = 'Outlets' THEN 'F'
        WHEN ord.priceIndicator IN ('M', 'R') THEN 'R'
        WHEN ord.priceIndicator IN ('P') THEN 'P'
        ELSE 'F'
    END AS fp_rp_ind,
    SUM(ord.netValue) AS qty
FROM
    beam_prod.commercialOps_cnh_prod.factWeeklySales_saz_tbl ord
    LEFT JOIN beam_prod.masterdata_present_prod.dimsite_nsaz_tbl sit ON ord.siteId = sit.siteID
    LEFT JOIN beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl cal ON ord.calendarid = cal.calendarID
    LEFT JOIN beam_prod.masterdata_present_prod.dimproduct_nsaz_tbl pro ON ord.productID = pro.dimproductkey
WHERE
    ord.SalesMetric = "Units"
    AND sit.worldwideHierCode IN ('ZWIDE02', 'ZWIDE03', 'ZWIDE04')
    AND pro.producthierarchylevel5nodeid NOT IN ('G5-T46')
    AND sit.partyCode IN (1000, 3000)
    AND cal.fiscalYear BETWEEN (
        SELECT
            max(fiscalYear)
        FROM
            beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl cal
        WHERE
            fiscalWeekEndingDate <= GETDATE ()
    ) - 1 AND (
        SELECT
            max(fiscalYear)
        FROM
            beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl cal
        WHERE
            fiscalWeekEndingDate <= GETDATE ()
    )
    AND cal.fiscalWeekEndingDate < GETDATE ()
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
        WHEN ord.priceIndicator IN ('M', 'R') THEN 'R'
        WHEN ord.priceIndicator IN ('P') THEN 'P'
        ELSE 'F'
    END