/*
    Informations provisoires en attendant que le professeur distribue la feuille.
*/ 
INSERT INTO public.reporters (nom, prenom)
SELECT  DISTINCT
    CASE 
        WHEN signale_par ~ 'concierge école'
            THEN 'Rateur'
        WHEN signale_par ~ 'patrouille JM'
            THEN 'Maria'
        WHEN signale_par ~ 'Mme Weber'
            THEN 'Weber'
        WHEN signale_par ~ 'Mme Rochat'
            THEN 'Rochat'
        WHEN signale_par ~ 'Mme Dupont'
            THEN 'Dupont'
        WHEN signale_par ~ 'M. Pereira'
            THEN 'Pereira'
        WHEN signale_par ~ 'M. Keller'
            THEN 'Keller'
        ELSE 'unknown citizen'
    END AS nom,
    CASE 
        WHEN signale_par ~ 'concierge école'
            THEN 'Aspi'
        WHEN signale_par ~ 'patrouille JM'
            THEN 'Jean'
        WHEN signale_par ~ 'Mme Weber'
            THEN 'Lisa'
        WHEN signale_par ~ 'Mme Rochat'
            THEN 'Emilie'
        WHEN signale_par ~ 'Mme Dupont'
            THEN 'Josette'
        WHEN signale_par ~ 'M. Pereira'
            THEN 'Mark'
        WHEN signale_par ~ 'M. Keller'
            THEN 'Patrick'
        ELSE 'unknown citizen'
    END AS prenom
FROM staging.signalements;