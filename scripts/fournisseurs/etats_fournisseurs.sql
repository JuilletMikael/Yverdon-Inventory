INSERT INTO public.etats_fournisseurs (libelle)
SELECT DISTINCT
    CASE
        WHEN LOWER(TRIM(unaccent(remarques))) LIKE '%ferme%' THEN 'ferme'
        WHEN LOWER(TRIM(unaccent(remarques))) LIKE '%urgence%' THEN 'urgences'
        ELSE 'actif'
    END AS etat_normalise
FROM staging.fournisseurs_contacts;