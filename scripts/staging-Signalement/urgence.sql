INSERT INTO public.urgences (libelle)
SELECT DISTINCT LOWER(TRIM(urgence))
    FROM staging.signalements
    WHERE urgence IS NOT NULL;