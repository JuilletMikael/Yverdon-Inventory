INSERT INTO public.tickets (id_etats_tickets, id_urgences)
SELECT DISTINCT
    etat.id,
    urgence.id
FROM staging.signalements s

LEFT JOIN public.urgences urgence
    ON LOWER(TRIM(s.urgence)) LIKE '%' || urgence.libelle || '%'

LEFT JOIN public.etats_tickets etat
    ON LOWER(TRIM(s.statut)) LIKE '%' || etat.libelle || '%'

-- TODO : need to change in inventaire
LEFT JOIN public.etats_tickets etat
    ON LOWER(TRIM(s.statut)) LIKE '%' || etat.libelle || '%'

WHERE urgence.id IS NOT NULL
  AND etat.id IS NOT NULL;