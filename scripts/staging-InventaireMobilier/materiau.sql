--Aperçu colonne materiau
SELECT materiau, COUNT(*) AS nb
FROM staging.inventaire_mobilier
GROUP BY
    materiau
ORDER BY nb DESC;

CREATE EXTENSION IF NOT EXISTS unaccent;

INSERT INTO public.materiaux (libelle)
SELECT DISTINCT
    staging.unaccent(LOWER(materiau))
FROM staging.inventaire_mobilier
WHERE
    materiau IS NOT NULL;


