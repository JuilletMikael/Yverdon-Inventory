-- Active: 1773394971258@@127.0.0.1@5438@yverdon-inventory@staging
INSERT INTO public.types_materiels (libelle)
  SELECT DISTINCT
  CASE LOWER(TRIM(unaccent(type)))
    WHEN 'eclairage led' THEN 'eclairage'
    WHEN 'bornes ev' THEN 'borne'
    WHEN 'bancs metal' THEN 'banc'
    WHEN 'bancs bois' THEN 'banc'
    WHEN 'bancs' THEN 'banc'
    WHEN 'plantations autour mobilier' THEN 'plantation'
    ELSE LOWER(TRIM(unaccent(type)))
    END AS type_normalise
FROM staging.fournisseurs
CROSS JOIN LATERAL unnest(string_to_array(type_materiel, ',')) AS type
WHERE type IS NOT NULL
 AND LOWER(TRIM(unaccent(type))) != 'nettoyage';

CREATE EXTENSION IF NOT EXISTS unaccent;
 
 