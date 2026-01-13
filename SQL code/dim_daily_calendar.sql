CREATE VIEW OR REPLACE VIEW beam_prod.finance_azlab_prod.dim_daily_calendar AS
    WITH comp_days AS
        (SELECT 
            ty.naturalDate AS ty_naturalDate
            ,yest.naturalDate AS yest_naturalDate
            ,lw.naturalDate AS lw_naturalDate
            ,ly.naturalDate AS ly_naturalDate
            ,lly.naturalDate AS lly_naturalDate
        FROM 
            beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl ty
            LEFT JOIN beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl yest
                ON ty.naturalDateLastDate = yest.naturalDate
            LEFT JOIN beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl lw
                ON ty.fiscalWeekLastWeek = lw.fiscalWeek
                AND ty.dayOfTheWeek = lw.dayOfTheWeek
            LEFT JOIN beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl ly
                ON ty.fiscalWeekLastYear = ly.fiscalWeek
                AND ty.dayOfTheWeek = ly.dayOfTheWeek
            LEFT JOIN beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl lly
                ON ty.fiscalWeekLastToLastYear = lly.fiscalWeek
                AND ty.dayOfTheWeek = lly.dayOfTheWeek
        )

    SELECT
        cal.calendarID
        ,cal.naturalDate
        ,comp.yest_naturalDate
        ,comp.lw_naturalDate
        ,comp.ly_naturalDate
        ,comp.lly_naturalDate
        ,cal.dayOfTheWeek
        ,cal.dayNumberInFiscalMonth
        ,cal.dayNumberInFiscalYear
        ,cal.lastDayInWeekIndicator
        ,cal.lastDayInMonthIndicator
        ,cal.fiscalWeek
        ,cal.fiscalWeekNumber
        ,cal.fiscalWeekEndingDate
        ,cal.fiscalMonth
        ,cal.fiscalMonthName
        ,cal.fiscalMonthNumber
        ,cal.fiscalQuarter
        ,cal.fiscalQuarterNumber
        ,cal.fiscalHalfYear
        ,cal.fiscalYear
        ,cal.season
    FROM
        beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl cal
        LEFT JOIN comp_days comp
            ON cal.naturalDate = comp.ty_naturalDate
    WHERE fiscalYear >= 2020