SELECT "date", COUNT(*) AS nb
FROM staging.signalements
GROUP BY
    "date"
ORDER BY nb DESC;


SELECT COUNT(*) as total_lignes
FROM signalements;

-- Convertir TOUS les formats de dates en YYYY-MM-DD
UPDATE staging.signalements
SET "date" = 
  CASE
    WHEN "date" ~ '^\d{4}-\d{2}-\d{2}$' THEN TO_CHAR(TO_DATE("date", 'DD.MM.YYYY'), 'YYYY-MM-DD')
    WHEN "date" ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_CHAR(TO_DATE("date", 'YYYY-MM-DD'), 'YYYY-MM-DD')
  END
WHERE "date" IS NOT NULL;


SELECT DISTINCT "date"
FROM staging.signalements
ORDER BY "date";

