INSERT INTO
    public.inventaires (
        reference,
        position,
        date_installation,
        remarques,
        id_etats_inventaires,
        id_types_inventaires
    )
SELECT DISTINCT
    inv.id,
    CASE
        WHEN latitude IS NOT NULL
        AND longitude IS NOT NULL THEN public.ST_SetSRID (
            public.ST_MakePoint (
                longitude::numeric,
                latitude::numeric
            ),
            4326
        )
        ELSE NULL
    END AS position,
    CASE
        WHEN date_installation ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(
            date_installation,
            'DD.MM.YYYY'
        )
        WHEN date_installation ~ '^\d{4}-\d{2}-\d{2}$' THEN TO_DATE(
            date_installation,
            'YYYY-MM-DD'
        )
        WHEN date_installation ~ '^\d{4}$' THEN TO_DATE(date_installation, 'YYYY')
        WHEN LOWER(date_installation) ~ '^[[:alpha:]]+ \d{4}$' THEN TO_DATE(
            LOWER(date_installation),
            'TMMonth YYYY'
        )
    END AS date_normalisee,
    inv.remarques,
    etat.id AS id_etats_inventaires,
    typ.id AS type_inv
FROM
    staging.inventaire_mobilier inv
    INNER JOIN public.etats_inventaires etat ON LOWER(
        public.unaccent (etat.libelle)
    ) = LOWER(public.unaccent (inv.etat))
    INNER JOIN public.types_inventaires typ ON LOWER(typ.libelle) = CASE
        WHEN LOWER(TRIM(inv.type)) LIKE '%banc%' THEN 'banc'
        WHEN LOWER(TRIM(inv.type)) LIKE '%lampadaire%' THEN 'lampadaire'
        WHEN LOWER(TRIM(inv.type)) LIKE '%poubelle%' THEN 'poubelle'
        WHEN LOWER(TRIM(inv.type)) LIKE '%corbeille%' THEN 'corbeille'
        WHEN LOWER(TRIM(inv.type)) LIKE '%fontaine%' THEN 'fontaine'
        WHEN LOWER(TRIM(inv.type)) LIKE '%borne%' THEN 'borne ev'
        WHEN LOWER(TRIM(inv.type)) LIKE '%panneau%' THEN 'panneau'
    END;