INSERT INTO
    public.urgences (libelle)
SELECT DISTINCT
    LOWER(
        TRIM(public.unaccent (urgence))
    )
FROM staging.signalements
WHERE
    urgence IS NOT NULL;