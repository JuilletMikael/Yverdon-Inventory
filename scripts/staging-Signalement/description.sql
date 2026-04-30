INSERT INTO
    public.types_signalements (libelle)
SELECT DISTINCT
    CASE
        WHEN LOWER(description) ~ 'cassé|fissuré|fendu|manquant|décollé|grillée' THEN 'casse'
        WHEN LOWER(description) ~ 'éclaire|clignote|ne s''?allume plus|ne charge plus|ne coule plus|déborde' THEN 'defectueux'
        WHEN LOWER(description) ~ 'tag|mousse|pourri|brûlée|penché|tordu|renversé|abime' THEN 'abime'
        ELSE 'autre'
    END AS libelle
FROM staging.signalements
WHERE
    description IS NOT NULL;