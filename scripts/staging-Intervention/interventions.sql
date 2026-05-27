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
            THEN ROUND(
                CAST(
                    REGEXP_REPLACE(
                        s.duree,
                        '[^0-9\.]',
                        '',
                        'g'
                    ) AS NUMERIC
                ) * 60
            )

        WHEN s.duree ~ '^\d+h\d{2}$'
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

LEFT JOIN staging.signalements sig
    ON LOWER(TRIM(public.unaccent(sig.objet)))
    =
    LOWER(TRIM(public.unaccent(s.objet)))

LEFT JOIN public.techniciens tech

ON tech.nom = CASE
    WHEN s.technicien ILIKE '%JM%' THEN 'Bonvin'
    WHEN s.technicien ILIKE '%Jean-Marc%' THEN 'Bonvin'
    WHEN s.technicien ILIKE '%Pedro%' THEN 'Alves'
    WHEN s.technicien ILIKE '%P. Alves%' THEN 'Alves'
    WHEN s.technicien ILIKE '%Alves Pedro%' THEN 'Alves'
    WHEN s.technicien ILIKE '%Koffi%' THEN 'Koffi'
    WHEN s.technicien ILIKE '%stagiaire%' THEN 'stagiaire'
END

INNER JOIN staging.inventaire_mobilier inv_stage

ON
(
    CASE
        WHEN LOWER(s.objet) LIKE '%banc%' THEN 'banc'
        WHEN LOWER(s.objet) LIKE '%lampadaire%' THEN 'lampadaire'
        WHEN LOWER(s.objet) LIKE '%poubelle%' THEN 'poubelle'
        WHEN LOWER(s.objet) LIKE '%corbeille%' THEN 'corbeille'
        WHEN LOWER(s.objet) LIKE '%fontaine%' THEN 'fontaine'
        WHEN LOWER(s.objet) LIKE '%borne%' THEN 'borne'
        WHEN LOWER(s.objet) LIKE '%panneau%' THEN 'panneau'
        WHEN LOWER(s.objet) LIKE '%eclairage%' THEN 'eclairage'
    END
)
=
(
    CASE
        WHEN LOWER(inv_stage.type) LIKE '%banc%' THEN 'banc'
        WHEN LOWER(inv_stage.type) LIKE '%lampadaire%' THEN 'lampadaire'
        WHEN LOWER(inv_stage.type) LIKE '%poubelle%' THEN 'poubelle'
        WHEN LOWER(inv_stage.type) LIKE '%corbeille%' THEN 'corbeille'
        WHEN LOWER(inv_stage.type) LIKE '%fontaine%' THEN 'fontaine'
        WHEN LOWER(inv_stage.type) LIKE '%borne%' THEN 'borne'
        WHEN LOWER(inv_stage.type) LIKE '%panneau%' THEN 'panneau'
        WHEN LOWER(inv_stage.type) LIKE '%eclairage%' THEN 'eclairage'
    END
)

AND LOWER(public.unaccent(s.objet))
LIKE '%' || LOWER(public.unaccent(inv_stage.lieu)) || '%'

INNER JOIN public.inventaires inv
    ON inv.reference = inv_stage.id

LEFT JOIN public.tickets tk
    ON tk.id_inventaire = inv.id

INNER JOIN public.types_interventions ti
    ON LOWER(TRIM(public.unaccent(s.type_intervention)))
    =
    LOWER(TRIM(public.unaccent(ti.libelle)));