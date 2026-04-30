INSERT INTO public.inventaires (
    reference,
    position,
    date_installation,
    remarques,
    id_types_inventaires,
    id_etats_inventaires
)
SELECT DISTINCT
    staging.id AS reference,
    ST_SetSRID(
        ST_MakePoint(
            CAST(REPLACE(staging.longitude, ',', '.') AS NUMERIC),
            CAST(REPLACE(staging.latitude, ',', '.') AS NUMERIC)
        ),
        4326
    ) AS position,
    CASE 
        WHEN staging.date_installation ~ '^\d{4}-\d{2}-\d{2}$' 
        THEN CAST(staging.date_installation AS DATE)
        ELSE NULL
    END AS date_installation,
    staging.remarques,
    type_inv.id AS id_types_inventaires,
    etat_inv.id AS id_etats_inventaires
FROM staging.inventaire_mobilier staging

LEFT JOIN public.types_inventaires type_inv
    ON LOWER(TRIM(staging.type)) LIKE '%' || LOWER(TRIM(type_inv.libelle)) || '%'

LEFT JOIN public.etats_inventaires etat_inv
    ON LOWER(TRIM(staging.etat)) LIKE '%' || LOWER(TRIM(etat_inv.libelle)) || '%'

WHERE type_inv.id IS NOT NULL
  AND etat_inv.id IS NOT NULL
  AND staging.id IS NOT NULL;

  SELECT COUNT(*) FROM public.inventaires;

  SELECT DISTINCT type FROM staging.inventaire_mobilier;
SELECT DISTINCT etat FROM staging.inventaire_mobilier;


SELECT * FROM public.types_inventaires;
SELECT * FROM public.etats_inventaires;