INSERT INTO public.etats_tickets (libelle)
SELECT DISTINCT LOWER(TRIM(statut))
    FROM staging.signalements
    WHERE statut IS NOT NULL;