-- Active: 1773394971258@@127.0.0.1@5438@yverdon-inventory

SELECT type, COUNT(*) AS nb
FROM staging.inventaire_mobilier
GROUP BY
    type
ORDER BY nb DESC;


SELECT type,
            CASE
            WHEN LOWER(TRIM(type)) ~ 'banc' THEN 'banc'
            WHEN LOWER(TRIM(type)) ~ 'lampadaire' THEN 'lampadaire'
            WHEN LOWER(TRIM(type)) ~ 'poubelle' THEN 'poubelle'
            WHEN LOWER(TRIM(type)) ~ 'corbeille' THEN 'corbeille'
            WHEN LOWER(TRIM(type)) ~ 'fontaine' THEN 'fontaine'
            WHEN LOWER(TRIM(type)) ~ 'Borne' THEN 'borne EV'
            WHEN LOWER(TRIM(type)) ~ 'panneau' THEN 'panneau'
            END

FROM staging.inventaire_mobilier
WHERE
    materiau IS NOT NULL;