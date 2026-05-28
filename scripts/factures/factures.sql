-- reference_commande = Valleur de 10 chat aléatoire
-- Date formatée
-- Cout total : null, garantie, gratuit = 0
-- etats_factures : définit par défault à payée
-- id_fournisseurs : si le type d’intervention est "nettoyage", il prend automatiquement le premier fournisseur de services
-- id_fournisseurs : sinon il utilise le fournisseur lié au type de matériel 
-- ROW_NUMBER() [...] : sert à détecter les doublons et à ne garder qu’une seule ligne identique

INSERT INTO public.factures (
    reference_commande,
    date,
    cout_total,
    id_etats_factures,
    id_fournisseurs
)

SELECT 
    LEFT(MD5(random()::text), 10) AS reference_commande,
    date,
    cout_total,
    id_etats_factures,
    id_fournisseurs
FROM 
(
    SELECT

        CASE
            WHEN s.date ~ '^\d{2}\.\d{2}\.\d{4}$'
                THEN TO_DATE(s.date, 'DD.MM.YYYY')
            WHEN s.date ~ '^\d{4}-\d{2}-\d{2}$'
                THEN TO_DATE(s.date, 'YYYY-MM-DD')
        END AS date,

        CASE
            WHEN LOWER(TRIM(s.cout_materiel)) IN ('garantie', 'gratuit') THEN 0
            WHEN TRIM(s.cout_materiel) = '' THEN 0
            WHEN s.cout_materiel IS NULL THEN 0
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

        CASE
            WHEN LOWER(TRIM(s.type_intervention)) = 'nettoyage' 
                THEN (SELECT id_fournisseurs FROM public.fournisseurs_de_services LIMIT 1)
            ELSE fdm.id_fournisseurs
        END AS id_fournisseurs,

        ROW_NUMBER() OVER (
            PARTITION BY s.date, s.objet, s.cout_materiel, s.type_intervention
            ORDER BY s.date
        ) as rn

    FROM staging.interventions s

    INNER JOIN public.etats_factures ef ON LOWER(ef.libelle) = 'payee'

    LEFT JOIN public.types_materiels tm
        ON LOWER(tm.libelle) = (
            CASE
                WHEN LOWER(public.unaccent(s.objet)) LIKE '%banc%' THEN 'banc'
                WHEN LOWER(public.unaccent(s.objet)) LIKE '%lampadaire%' THEN 'lampadaire'
                WHEN LOWER(public.unaccent(s.objet)) LIKE '%poubelle%' THEN 'poubelle'
                WHEN LOWER(public.unaccent(s.objet)) LIKE '%corbeille%' THEN 'corbeille'
                WHEN LOWER(public.unaccent(s.objet)) LIKE '%fontaine%' THEN 'fontaine'
                WHEN LOWER(public.unaccent(s.objet)) LIKE '%borne%' THEN 'borne'
                WHEN LOWER(public.unaccent(s.objet)) LIKE '%panneau%' THEN 'panneau'
                WHEN LOWER(public.unaccent(s.objet)) LIKE '%eclairage%' THEN 'eclairage'
                WHEN LOWER(public.unaccent(s.objet)) LIKE '%plantations%' THEN 'plantation'
            END
        )

    LEFT JOIN public.fournisseurs_de_materiels fdm ON fdm.id_types_materiels = tm.id

) sub
WHERE rn = 1;