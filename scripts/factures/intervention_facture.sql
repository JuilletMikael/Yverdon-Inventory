INSERT INTO public.interventions_factures (
    id_interventions,
    id_factures
)
SELECT DISTINCT

    inter.id AS id_interventions,
    fact.id AS id_factures

FROM staging.interventions s
INNER JOIN public.interventions inter
    ON inter.date = CASE

        WHEN s.date ~ '^\d{2}\.\d{2}\.\d{4}$'
            THEN TO_DATE(s.date, 'DD.MM.YYYY')

        WHEN s.date ~ '^\d{4}-\d{2}-\d{2}$'
            THEN TO_DATE(s.date, 'YYYY-MM-DD')

    END
INNER JOIN public.factures fact
    ON fact.date = CASE

        WHEN s.date ~ '^\d{2}\.\d{2}\.\d{4}$'
            THEN TO_DATE(s.date, 'DD.MM.YYYY')

        WHEN s.date ~ '^\d{4}-\d{2}-\d{2}$'
            THEN TO_DATE(s.date, 'YYYY-MM-DD')

    END

    AND fact.cout_total = CASE

        WHEN LOWER(TRIM(s.cout_materiel))
            IN ('garantie', 'gratuit')
            THEN NULL

        WHEN TRIM(s.cout_materiel) = ''
            THEN NULL

        ELSE CAST(
            REGEXP_REPLACE(
                REPLACE(s.cout_materiel, ',', '.'),
                '[^0-9.]',
                '',
                'g'
            ) AS NUMERIC
        )

    END

WHERE fact.id IS NOT NULL
  AND inter.id IS NOT NULL;