-- Séparer « valeur, valeur », puis normaliser le résultat pour l'associer au type « matériel ».
-- CROSS JOIN - produit cartésien entre deux tables.

INSERT INTO public.fournisseurs_de_materiels (
    id_fournisseurs,
    id_types_materiels
)

SELECT DISTINCT
    f.id,
    tm.id

FROM staging.fournisseurs_contacts s

INNER JOIN public.fournisseurs f
    ON f.entreprise = s.entreprise

CROSS JOIN LATERAL unnest(
    string_to_array(s.type_materiel, ',')
) AS type

CROSS JOIN LATERAL (
    SELECT CASE
        WHEN LOWER(TRIM(public.unaccent(type))) LIKE '%banc%' THEN 'banc'
        WHEN LOWER(TRIM(public.unaccent(type))) LIKE '%lampadaire%' THEN 'lampadaire'
        WHEN LOWER(TRIM(public.unaccent(type))) LIKE '%poubelle%' THEN 'poubelle'
        WHEN LOWER(TRIM(public.unaccent(type))) LIKE '%corbeille%' THEN 'corbeille'
        WHEN LOWER(TRIM(public.unaccent(type))) LIKE '%fontaine%' THEN 'fontaine'
        WHEN LOWER(TRIM(public.unaccent(type))) LIKE '%borne%' THEN 'borne'
        WHEN LOWER(TRIM(public.unaccent(type))) LIKE '%panneau%' THEN 'panneau'
        WHEN LOWER(TRIM(public.unaccent(type))) LIKE '%eclairage%' THEN 'eclairage'
        WHEN LOWER(TRIM(public.unaccent(type))) LIKE '%plantations%' THEN 'plantations'
        ELSE LOWER(TRIM(public.unaccent(type)))
    END AS type_norm
) t

INNER JOIN public.types_materiels tm
    ON LOWER(tm.libelle) = t.type_norm

WHERE
    s.type_materiel IS NOT NULL
    AND LOWER(TRIM(public.unaccent(type))) != 'nettoyage';