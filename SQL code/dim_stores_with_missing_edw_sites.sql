CREATE OR REPLACE VIEW beam_prod.finance_azlab_prod.dim_stores_with_missing_edw_sites AS
WITH
    codes (siteNumber) AS (
        SELECT
            *
        FROM
        VALUES
            ('F0005'),
            ('F1007'),
            ('F1008'),
            ('F1009'),
            ('G0009'),
            ('G1001'),
            ('G0010'),
            ('F1019'),
            ('1884'),
            ('5205'),
            ('5158')
    ),
    missing_sites AS (
        SELECT
            siteNumber
        FROM
            codes
    )
-- Construction of a dummy site code for when data is not at site level
-- Uses WATFORD SAT as a base as this has mostly suitable values
    ,dummy AS (
        SELECT
            -1 AS siteID,
            '0000' AS siteNumber,
            'DUMMY UK STORE' AS siteName,
            siteOpenDate,
            siteCloseDate,
            locationPostalCode,
            isoCountryCode,
            isoCountryName,
            partyCode,
            partyName,
            priceListCode,
            siteType,
            areaCode,
            areaName,
            shapeOfChainCode,
            shapeOfChainName,
            storeTradingGroupCode,
            storeTradingGroupName,
            financeDivisionCode,
            financeDivisionName,
            depotSiteNumber,
            depotSiteName,
            worldwideHierCode,
            worldwideHierName,
            internationalHierCode,
            internationalHierName
        FROM
            beam_prod.masterdata_present_prod.dimsite_nsaz_tbl
        WHERE
            siteID = 60329
    )
    ,edw_missing_sites AS (
        SELECT
            - row_number() OVER (
                ORDER BY
                    edw.siteNumber
            ) -1 AS siteID,
            edw.siteNumber,
            edw.siteNumber AS siteName,
            siteOpenDate,
            siteCloseDate,
            locationPostalCode,
            isoCountryCode,
            isoCountryName,
            partyCode,
            partyName,
            priceListCode,
            siteType,
            areaCode,
            areaName,
            shapeOfChainCode,
            shapeOfChainName,
            storeTradingGroupCode,
            storeTradingGroupName,
            financeDivisionCode,
            financeDivisionName,
            depotSiteNumber,
            depotSiteName,
            worldwideHierCode,
            worldwideHierName,
            internationalHierCode,
            internationalHierName
        FROM
            missing_sites edw
            INNER JOIN dummy dum ON 1 = 1
    )
SELECT
    siteID,
    siteNumber,
    siteName,
    siteOpenDate,
    siteCloseDate,
    locationPostalCode,
    isoCountryCode,
    isoCountryName,
    partyCode,
    partyName,
    priceListCode,
    siteType,
    areaCode,
    areaName,
    shapeOfChainCode,
    shapeOfChainName,
    storeTradingGroupCode,
    storeTradingGroupName,
    financeDivisionCode,
    financeDivisionName,
    depotSiteNumber,
    depotSiteName,
    worldwideHierCode,
    worldwideHierName,
    internationalHierCode,
    internationalHierName
FROM
    beam_prod.masterdata_present_prod.dimsite_nsaz_tbl
    -- WHERE worldwideHierCode IN ('ZWIDE02', 'ZWIDE03', 'ZWIDE04', 'ZWIDE06')
    -- WHERE partyCode IN (1000, 3000)
UNION ALL
SELECT
    *
FROM
    edw_missing_sites