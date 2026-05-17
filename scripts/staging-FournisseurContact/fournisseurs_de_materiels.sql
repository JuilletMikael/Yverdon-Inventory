-- Active: 1773394971258@@127.0.0.1@5438@yverdon-inventory

INSERT INTO public.fournisseurs_de_materiels (id_fournisseurs)
SELECT f.id
FROM public.fournisseurs f
JOIN staging.fournisseurs s ON f.entreprise = s.entreprise
WHERE NOT EXISTS (
    SELECT 1
    FROM unnest(string_to_array(s.type_materiel, ',')) AS type
    WHERE LOWER(TRIM(unaccent(type))) = 'nettoyage'
)
AND s.type_materiel IS NOT NULL;

