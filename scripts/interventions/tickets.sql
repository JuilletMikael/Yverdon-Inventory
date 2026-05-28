-- id_etats_tickets : état du ticket
-- id_urgences : niveau d’urgence du ticket (défault "normal")
-- id_inventaire : objet concerné par le ticket (défault "en attente")

INSERT INTO public.tickets (
    id_etats_tickets,
    id_urgences,
    id_inventaire
)

SELECT DISTINCT
    COALESCE(etat.id, etat_defaut.id) AS id_etat_ticket,
    COALESCE(urgence.id, urgence_defaut.id) AS id_urgence,
    i.id AS id_inventaire

FROM staging.signalements s

LEFT JOIN public.urgences urgence
    ON LOWER(TRIM(s.urgence)) LIKE '%' || LOWER(TRIM(urgence.libelle)) || '%'

LEFT JOIN public.etats_tickets etat
    ON LOWER(TRIM(s.statut)) LIKE '%' || LOWER(TRIM(etat.libelle)) || '%'

CROSS JOIN (
    SELECT id
    FROM public.urgences
    WHERE LOWER(libelle) = 'normal'
) urgence_defaut

CROSS JOIN (
    SELECT id
    FROM public.etats_tickets
    WHERE LOWER(libelle) = 'en attente'
) etat_defaut

INNER JOIN staging.inventaire_mobilier inv_stage
    ON LOWER(inv_stage.type) = CASE
        WHEN LOWER(TRIM(s.objet)) LIKE '%banc%' THEN 'banc'
        WHEN LOWER(TRIM(s.objet)) LIKE '%lampadaire%' THEN 'lampadaire'
        WHEN LOWER(TRIM(s.objet)) LIKE '%poubelle%' THEN 'poubelle'
        WHEN LOWER(TRIM(s.objet)) LIKE '%corbeille%' THEN 'corbeille'
        WHEN LOWER(TRIM(s.objet)) LIKE '%fontaine%' THEN 'fontaine'
        WHEN LOWER(TRIM(s.objet)) LIKE '%borne%' THEN 'borne ev'
        WHEN LOWER(TRIM(s.objet)) LIKE '%panneau%' THEN 'panneau'
    END

    AND LOWER(inv_stage.lieu) = LOWER(
        TRIM(
            REGEXP_REPLACE(
                s.objet,
                '.*près de ',
                '',
                'i'
            )
        )
    )

INNER JOIN public.inventaires i
    ON i.reference = inv_stage.id;