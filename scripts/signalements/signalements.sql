-- id_inventaires : objet concerné 
-- 1. Correspondance sur le type de mobilier
-- 2. Correspondance sur le lieu
-- 3. Forcer un seul inventaire correspondant pour éviter les doublons

INSERT INTO public.signalements (
    description,
    id_inventaires,
    id_reporteurs,
    id_types_signalements
)

SELECT 
    ss.description,
    inv.id AS id_inventaires,
    rep.id AS id_reporteurs,
    type_sig.id AS id_types_signalements
FROM staging.signalements ss

INNER JOIN staging.inventaire_mobilier inv_stage
    ON LOWER(ss.objet) LIKE '%' || LOWER(inv_stage.type) || '%'
    AND LOWER(public.unaccent(ss.objet)) LIKE '%' || LOWER(public.unaccent(inv_stage.lieu)) || '%'
    AND inv_stage.id = (
        SELECT inv_stage2.id
        FROM staging.inventaire_mobilier inv_stage2
        WHERE LOWER(ss.objet) LIKE '%' || LOWER(inv_stage2.type) || '%'
        AND LOWER(public.unaccent(ss.objet)) LIKE '%' || LOWER(public.unaccent(inv_stage2.lieu)) || '%'
        ORDER BY inv_stage2.id
        LIMIT 1
    )

INNER JOIN public.inventaires inv ON inv.reference = inv_stage.id

LEFT JOIN public.reporters rep
ON rep.nom = CASE
    WHEN ss.signale_par ~ 'concierge école' THEN 'Rateur'
    WHEN ss.signale_par ~ 'patrouille JM' THEN 'Maria'
    WHEN ss.signale_par ~ 'Mme Weber' THEN 'Weber'
    WHEN ss.signale_par ~ 'Mme Rochat' THEN 'Rochat'
    WHEN ss.signale_par ~ 'Mme Dupont' THEN 'Dupont'
    WHEN ss.signale_par ~ 'M. Pereira' THEN 'Pereira'
    WHEN ss.signale_par ~ 'M. Keller' THEN 'Keller'
    ELSE 'citoyen inconnu'
END
AND rep.prenom = CASE
    WHEN ss.signale_par ~ 'concierge école' THEN 'Aspi'
    WHEN ss.signale_par ~ 'patrouille JM' THEN 'Jean'
    WHEN ss.signale_par ~ 'Mme Weber' THEN 'Lisa'
    WHEN ss.signale_par ~ 'Mme Rochat' THEN 'Emilie'
    WHEN ss.signale_par ~ 'Mme Dupont' THEN 'Josette'
    WHEN ss.signale_par ~ 'M. Pereira' THEN 'Mark'
    WHEN ss.signale_par ~ 'M. Keller' THEN 'Patrick'
    ELSE 'citoyen inconnu'
END

INNER JOIN public.types_signalements type_sig ON type_sig.libelle = CASE
    WHEN LOWER(ss.description) ~ 'cassé|fissuré|fendu|manquant|décollé|grillée' THEN 'casse'
    WHEN LOWER(ss.description) ~ 'éclaire|clignote|ne s''?allume plus|ne charge plus|ne coule plus|déborde' THEN 'defectueux'
    WHEN LOWER(ss.description) ~ 'tag|mousse|pourri|brûlée|penché|tordu|renversé|abime' THEN 'abime'
    ELSE 'autre'
END

WHERE rep.id IS NOT NULL;