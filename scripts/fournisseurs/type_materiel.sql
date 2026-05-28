-- Séparer « valeur, valeur », puis normaliser le résultat pour l'associer au type « matériel ».
-- Ne prend pas en compte la valleur nettoyage.

INSERT INTO
    public.types_materiels (libelle)

SELECT DISTINCT
    CASE 
        WHEN LOWER(TRIM(public.unaccent (type))) LIKE '%banc%' THEN 'banc'
        WHEN LOWER(TRIM(public.unaccent (type))) LIKE '%lampadaire%' THEN 'lampadaire'
        WHEN LOWER(TRIM(public.unaccent (type))) LIKE '%poubelle%' THEN 'poubelle'
        WHEN LOWER(TRIM(public.unaccent (type))) LIKE '%corbeille%' THEN 'corbeille'
        WHEN LOWER(TRIM(public.unaccent (type))) LIKE '%fontaine%' THEN 'fontaine'
        WHEN LOWER(TRIM(public.unaccent (type))) LIKE '%borne%' THEN 'borne'
        WHEN LOWER(TRIM(public.unaccent (type))) LIKE '%panneau%' THEN 'panneau'
        WHEN LOWER(TRIM(public.unaccent (type))) LIKE '%eclairage%' THEN 'eclairage'
        WHEN LOWER(TRIM(public.unaccent (type))) LIKE '%plantations%' THEN 'plantations'
        ELSE LOWER(TRIM(public.unaccent (type)))
    END AS type_normalise
FROM staging.fournisseurs_contacts

CROSS JOIN LATERAL unnest(
    string_to_array(type_materiel, ',')
) AS type

WHERE
    type IS NOT NULL
    AND LOWER(TRIM(unaccent (type))) != 'nettoyage';