INSERT INTO
    public.fournisseurs_de_materiels (
        id_fournisseurs,
        id_types_materiels
    )
SELECT DISTINCT
    f.id,
    tm.id
FROM staging.fournisseurs_contacts s
    INNER JOIN public.fournisseurs f ON f.entreprise = s.entreprise
    CROSS JOIN LATERAL unnest(string_to_array(s.type_materiel, ',')) AS type
    INNER JOIN public.types_materiels tm ON LOWER(TRIM(public.unaccent (tm.libelle))) = LOWER(TRIM(public.unaccent (type)))
WHERE
    NOT EXISTS (
        SELECT 1
        FROM unnest(
                string_to_array(s.type_materiel, ',')
            ) AS type
        WHERE
            LOWER(TRIM(PUBLIC.unaccent (type))) = 'nettoyage'
    )
    AND s.type_materiel IS NOT NULL;