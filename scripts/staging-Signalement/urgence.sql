/*
On as juste besoin de s'assurer qu'il n'y a pas de majuscule ou d'espace
*/
INSERT INTO public.urgences (libelle)
SELECT DISTINCT LOWER(TRIM(urgence))
    FROM staging.signalements
    WHERE urgence IS NOT NULL;