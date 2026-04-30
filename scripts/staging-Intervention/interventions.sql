INSERT INTO public.interventions (
    date,
    duree,
    remarques,
    id_techniciens,
    id_tickets,
    id_types_interventions
)
SELECT DISTINCT
    CASE
        WHEN s.date ~ '^\d{2}\.\d{2}\.\d{4}$'
            THEN TO_DATE(s.date, 'DD.MM.YYYY')
        WHEN s.date ~ '^\d{4}-\d{2}-\d{2}$'
            THEN TO_DATE(s.date, 'YYYY-MM-DD')
        WHEN s.date ~ '^\d{2}/\d{2}/\d{4}$'
            THEN TO_DATE(s.date, 'DD/MM/YYYY')
        ELSE NULL
    END AS date_uniformisee,
    CASE
    WHEN s.duree ~ '^\d+\s*(min|mn)$'
        THEN CAST(REGEXP_REPLACE(s.duree, '\D', '', 'g') AS INTEGER)

    WHEN s.duree ~ '^\d+(\.\d+)?\s*h$'
        THEN ROUND(CAST(REGEXP_REPLACE(s.duree, '[^0-9\.]', '', 'g') AS NUMERIC) * 60)

    WHEN s.duree ~ '^\\d+h\\d{2}$'
        THEN (
            CAST(REGEXP_REPLACE(s.duree, 'h.*', '') AS INTEGER) * 60
            +
            CAST(REGEXP_REPLACE(s.duree, '.*h', '') AS INTEGER)
        )

        WHEN LOWER(s.duree) = 'une matinée'
            THEN 240

        WHEN LOWER(s.duree) = 'une journée'
            THEN 480
        ELSE NULL
    END AS duree_minute,
    s.remarques,
    tech.id,
    tk.id,
    ti.id
FROM staging.interventions s

JOIN staging.signalements sig
    ON sig.objet = s.objet

INNER JOIN public.techniciens tech
    ON SPLIT_PART(s.technicien, ' ', 1) = tech.prenom

INNER JOIN public.tickets tk
    ON tk.id_urgences = (
        SELECT u.id
        FROM public.urgences u
        WHERE LOWER(TRIM(sig.urgence)) LIKE '%' || u.libelle || '%'
        LIMIT 1
    )
    AND tk.id_etats_tickets = (
        SELECT e.id
        FROM public.etats_tickets e
        WHERE LOWER(TRIM(sig.statut)) LIKE '%' || e.libelle || '%'
        LIMIT 1
    )

INNER JOIN public.types_interventions ti
    ON LOWER(TRIM(s.type_intervention)) = LOWER(TRIM(ti.libelle));
