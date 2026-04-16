SELECT "date", COUNT(*) AS nb
FROM staging.signalements
GROUP BY
    "date"
ORDER BY nb DESC;


SELECT COUNT(*) as total_lignes
FROM signalements;


SELECT "date"
FROM staging.signalements
WHERE "date" ~ '^\d{2}\.\d{2}\.\d{4}$';


UPDATE staging.signalements
SET "date" = TO_CHAR(
    TO_DATE("date", 'DD.MM.YYYY'),
    'YYYY-MM-DD'
)
WHERE "date" ~ '^\d{2}\.\d{2}\.\d{4}$';

SELECT DISTINCT "date"
FROM staging.signalements
ORDER BY "date";
