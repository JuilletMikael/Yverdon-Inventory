INSERT INTO
    public.factures (
        reference_commande,
        date,
        cout_total,
        id_etats_factures,
        id_fournisseurs
    )
SELECT DISTINCT
    LEFT(MD5(random()::text), 10) AS reference_commande,

    CASE
        WHEN s.date ~ '^\d{2}\.\d{2}\.\d{4}$'
            THEN TO_DATE(s.date, 'DD.MM.YYYY')

        WHEN s.date ~ '^\d{4}-\d{2}-\d{2}$'
            THEN TO_DATE(s.date, 'YYYY-MM-DD')
    END AS date,

    CASE
        WHEN LOWER(TRIM(s.cout_materiel)) IN ('garantie', 'gratuit') THEN NULL
        WHEN TRIM(s.cout_materiel) = '' THEN NULL
        ELSE CAST(
            REGEXP_REPLACE(
                REPLACE(s.cout_materiel, ',', '.'),
                '[^0-9.]',
                '',
                'g'
            ) AS NUMERIC
        )
    END AS cout_total,

    ef.id AS id_etats_factures,

    COALESCE(fds.id_fournisseurs, fdm.id_fournisseurs) AS id_fournisseurs

FROM staging.interventions s

INNER JOIN public.etats_factures ef
    ON LOWER(ef.libelle) = 'payee'

LEFT JOIN public.fournisseurs_de_services fds
    ON LOWER(TRIM(s.type_intervention)) = 'nettoyage'

LEFT JOIN public.types_materiels tm
    ON LOWER(tm.libelle) = (
        CASE
            WHEN LOWER(public.unaccent (s.objet)) LIKE '%banc%' THEN 'banc'
            WHEN LOWER(public.unaccent (s.objet)) LIKE '%lampadaire%' THEN 'lampadaire'
            WHEN LOWER(public.unaccent (s.objet)) LIKE '%poubelle%' THEN 'poubelle'
            WHEN LOWER(public.unaccent (s.objet)) LIKE '%corbeille%' THEN 'corbeille'
            WHEN LOWER(public.unaccent (s.objet)) LIKE '%fontaine%' THEN 'fontaine'
            WHEN LOWER(public.unaccent (s.objet)) LIKE '%borne%' THEN 'borne'
            WHEN LOWER(public.unaccent (s.objet)) LIKE '%panneau%' THEN 'panneau'
            WHEN LOWER(public.unaccent (s.objet)) LIKE '%eclairage%' THEN 'eclairage'
            WHEN LOWER(public.unaccent (s.objet)) LIKE '%plantations%' THEN 'plantation'
        END
    )

LEFT JOIN public.fournisseurs_de_materiels fdm
    ON fdm.id_types_materiels = tm.id
WHERE
    CASE
        WHEN LOWER(TRIM(s.cout_materiel)) IN ('garantie', 'gratuit') THEN NULL
        WHEN TRIM(s.cout_materiel) = '' THEN NULL
        ELSE CAST(
            REGEXP_REPLACE(
                REPLACE(s.cout_materiel, ',', '.'),
                '[^0-9.]',
                '',
                'g'
            ) AS NUMERIC
        )
    END IS NOT NULL;