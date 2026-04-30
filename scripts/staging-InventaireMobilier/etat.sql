
CREATE EXTENSION IF NOT EXISTS unaccent;

-- 2️⃣ Ensuite insérer les données
INSERT INTO public.etats_inventaires (libelle)
SELECT DISTINCT
    unaccent(LOWER(etat))
FROM staging.inventaire_mobilier
WHERE
    etat IS NOT NULL;