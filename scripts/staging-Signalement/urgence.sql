SELECT urgence, COUNT(*) AS nb
FROM staging.signalements
GROUP BY
    urgence
ORDER BY nb DESC;


SELECT COUNT(*) as total_lignes
FROM signalements;

SELECT 
    urgence,
    COUNT(*) as nombre
FROM signalements
GROUP BY urgence
ORDER BY nombre DESC;

SELECT DISTINCT LOWER(TRIM(urgence))
FROM signalements
WHERE urgence IS NOT NULL;

UPDATE staging.signalements
SET urgence = 'normal'
WHERE urgence IS NULL OR urgence = '';

SELECT COUNT(*) as cases_vides
FROM staging.signalements
WHERE urgence IS NULL OR urgence = '';