INSERT INTO
    factures (
        reference_commande,
        date,
        cout_total,
        id_etats_factures,
        id_fournisseurs
    )

SELECT DISTINCT
    LEFT(MD5(random()::text), 10) AS reference_commande,
    CASE
        WHEN s.date ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(s.date, 'DD.MM.YYYY')
        WHEN s.date ~ '^\d{4}-\d{2}-\d{2}$' THEN TO_DATE(s.date, 'YYYY-MM-DD')
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
    END,
    ef.id,
    CASE
        WHEN LOWER(TRIM(s.type_intervention)) = 'nettoyage' THEN (
            SELECT fds.id_fournisseurs
            FROM fournisseurs_de_services fds
            LIMIT 1
        )
        ELSE (
            SELECT fdm.id_fournisseurs
            FROM
                types_materiels tm
                INNER JOIN fournisseurs_de_materiels fdm ON fdm.id_types_materiels = tm.id
            WHERE
                LOWER(tm.libelle) = CASE
                    WHEN LOWER(TRIM(s.objet)) LIKE '%banc%' THEN 'banc'
                    WHEN LOWER(TRIM(s.objet)) LIKE '%lampadaire%' THEN 'lampadaire'
                    WHEN LOWER(TRIM(s.objet)) LIKE '%poubelle%' THEN 'poubelle'
                    WHEN LOWER(TRIM(s.objet)) LIKE '%corbeille%' THEN 'corbeille'
                    WHEN LOWER(TRIM(s.objet)) LIKE '%fontaine%' THEN 'fontaine'
                    WHEN LOWER(TRIM(s.objet)) LIKE '%borne%' THEN 'borne ev'
                    WHEN LOWER(TRIM(s.objet)) LIKE '%panneau%' THEN 'panneau'
                END
            ORDER BY fdm.id
            LIMIT 1
        )
    END AS id_fournisseurs
FROM staging.interventions s


    INNER JOIN etats_factures ef ON LOWER(ef.libelle) = 'payee'
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