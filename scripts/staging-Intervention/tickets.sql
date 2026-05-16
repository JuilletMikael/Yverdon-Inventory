INSERT INTO public.tickets (id_etats_tickets, id_urgences)
SELECT DISTINCT
    i.id AS id_inventaire,
    etat.id AS id_etat_ticket,
    urgence.id AS id_urgence
FROM
    staging.signalements etats_tickets
    LEFT JOIN public.urgences urgence ON LOWER(TRIM(s.urgence)) LIKE '%' || urgence.libelle || '%'
    LEFT JOIN public.etats_tickets etat ON LOWER(TRIM(s.statut)) LIKE '%' || etat.libelle || '%'
    LEFT JOIN public.inventaires i ON i.id_types_inventaires = (
        SELECT ti.id
        FROM public.types_inventaires ti
        WHERE
            LOWER(ti.libelle) = CASE
                WHEN LOWER(TRIM(s.objet)) LIKE '%banc%' THEN 'banc'
                WHEN LOWER(TRIM(s.objet)) LIKE '%lampadaire%' THEN 'lampadaire'
                WHEN LOWER(TRIM(s.objet)) LIKE '%poubelle%' THEN 'poubelle'
                WHEN LOWER(TRIM(s.objet)) LIKE '%corbeille%' THEN 'corbeille'
                WHEN LOWER(TRIM(s.objet)) LIKE '%fontaine%' THEN 'fontaine'
                WHEN LOWER(TRIM(s.objet)) LIKE '%borne%' THEN 'borne ev'
                WHEN LOWER(TRIM(s.objet)) LIKE '%panneau%' THEN 'panneau'
            END
        LIMIT 1
    )
WHERE
    urgence.id IS NOT NULL
    AND etat.id IS NOT NULL
    AND i.id IS NOT NULL;