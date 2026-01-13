CREATE OR REPLACE VIEW beam_prod.finance_azlab_prod.dim_weekly_calendar AS
SELECT
    fiscalWeek,
    fiscalWeekNumber,
    fiscalWeekEndingDate,
    fiscalWeekLastWeek,
    fiscalWeekLastYear,
    fiscalWeekLastToLastyear,
    fiscalMonth,
    fiscalMonthName,
    fiscalMonthNumber,
    fiscalQuarter,
    fiscalQuarterNumber,
    fiscalHalfYear,
    fiscalYear,
    season,
    calendarID
FROM
    beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl
WHERE
    lastDayInWeekIndicator = 'Y'
    AND fiscalYear >= 2020