-- Active: 1773394952740@@127.0.0.1@5438@yverdon-inventory@staging
SELECT COUNT(*) as total_lignes
FROM signalements;

SELECT 
    urgence,
    COUNT(*) as nombre
FROM signalements
GROUP BY urgence
ORDER BY nombre DESC;


UPDATE signalements
SET urgence = LOWER(TRIM(urgence))
WHERE urgence IS NOT NULL AND urgence != '';

 
SELECT DISTINCT
FROM signalements
WHERE
    urgence IS NOT NULL;

UPDATE signalements
SET urgence = 'normal'
WHERE urgence IS NULL OR urgence = '';


SELECT 
    urgence,
    COUNT(*) as nombre
FROM signalements
GROUP BY urgence
ORDER BY nombre DESC;

