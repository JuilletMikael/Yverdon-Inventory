-- Active: 1773394971258@@127.0.0.1@5432@yverdon-inventory
-- Active: 1773394971258@@127.0.0.1@5432@yverdon-inventory

--Aperçu colonne materiau
SELECT materiau, COUNT(*) AS nb
FROM inventaire_mobilier
GROUP BY
    materiau
ORDER BY nb DESC;

CREATE EXTENSION IF NOT EXISTS unaccent;

SELECT DISTINCT
    unaccent (LOWER(materiau))
FROM inventaire_mobilier
WHERE
    materiau IS NOT NULL;