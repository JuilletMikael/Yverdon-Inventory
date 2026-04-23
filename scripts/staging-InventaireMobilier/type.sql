SELECT type, COUNT(*) AS nb
FROM staging.inventaire_mobilier
GROUP BY
    type
ORDER BY nb DESC;

INSERT INTO public.types_inventaires (libelle)
SELECT DISTINCT
            CASE
            WHEN LOWER(TRIM(type)) LIKE '%banc%' THEN 'banc'
            WHEN LOWER(TRIM(type)) LIKE '%lampadaire%' THEN 'lampadaire'
            WHEN LOWER(TRIM(type)) LIKE '%poubelle%' THEN 'poubelle'
            WHEN LOWER(TRIM(type)) LIKE '%corbeille%' THEN 'corbeille'
            WHEN LOWER(TRIM(type)) LIKE '%fontaine%' THEN 'fontaine'
            WHEN LOWER(TRIM(type)) LIKE '%borne%' THEN 'borne EV'
            WHEN LOWER(TRIM(type)) LIKE '%panneau%' THEN 'panneau'
            END

FROM staging.inventaire_mobilier
WHERE
    type IS NOT NULL;