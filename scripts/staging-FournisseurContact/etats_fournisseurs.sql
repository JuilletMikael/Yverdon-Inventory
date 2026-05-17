-- Active: 1773394971258@@127.0.0.1@5438@yverdon-inventory
INSERT INTO public.etats_fournisseurs (libelle)
SELECT DISTINCT
CASE LOWER(TRIM(remarques))
    WHEN '%fermé depuis mars 2025%'    THEN 'fermé'
    WHEN '%pour les urgences%'         THEN 'urgences'
    WHEN '%rapide pour les urgences%'  THEN 'urgences'
    ELSE 'actif'
END AS etat_normalise
FROM staging.fournisseurs;