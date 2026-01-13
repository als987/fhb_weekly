CREATE VIEW beam_prod.finance_azlab_prod.first_week_current_quarter AS
SELECT DISTINCT min(fiscalWeek) AS fiscalWeek
FROM beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl
WHERE fiscalQuarter = (
    SELECT max(fiscalQuarter)
    FROM beam_prod.masterdata_present_prod.dimcalendar_nsaz_tbl cal
    WHERE fiscalWeekEndingDate <= GETDATE()
)