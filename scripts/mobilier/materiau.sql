INSERT INTO public.materiaux (libelle)
SELECT DISTINCT 
    public.unaccent(LOWER(materiau))
FROM staging.inventaire_mobilier
WHERE materiau IS NOT NULL;