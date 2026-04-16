-- Active: 1773394971258@@127.0.0.1@5438@yverdon-inventory
INSERT INTO public.etats_inventaires (libelle)
SELECT DISTINCT
    unaccent (LOWER(etat))
FROM staging.inventaire_mobilier
WHERE
    etat IS NOT NULL;
