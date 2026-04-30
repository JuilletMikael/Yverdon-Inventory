SELECT
    CASE
        WHEN date ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE("date", 'DD.MM.YYYY')
        WHEN date ~ '^\d{4}-\d{2}-\d{2}$' THEN TO_DATE("date", 'YYYY-MM-DD')
    END
from staging.signalements;