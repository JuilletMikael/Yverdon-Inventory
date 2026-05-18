-- Active: 1774596950136@@127.0.0.1@5432@yverdon-inventory
INSERT INTO public.etats_tickets (libelle)
SELECT DISTINCT LOWER(TRIM(statut))
    FROM staging.signalements
    WHERE statut IS NOT NULL;