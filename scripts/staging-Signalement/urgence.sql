-- Active: 1774596950136@@127.0.0.1@5432@yverdon-inventory
INSERT INTO public.urgences (libelle)
SELECT DISTINCT LOWER(TRIM(urgence))
    FROM staging.signalements
    WHERE urgence IS NOT NULL;