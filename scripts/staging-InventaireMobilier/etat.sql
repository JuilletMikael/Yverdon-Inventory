INSERT INTO public.etats_inventaires (libelle)
SELECT DISTINCT
    staging.unaccent(LOWER(etat))
FROM staging.inventaire_mobilier
WHERE
    etat IS NOT NULL;
