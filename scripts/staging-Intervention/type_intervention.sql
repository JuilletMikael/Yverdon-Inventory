INSERT INTO public.types_interventions (libelle)
SELECT DISTINCT
    CASE
        WHEN LOWER(TRIM(type_intervention)) LIKE '%détartrage%' THEN 'détartrage'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%hivernage%' THEN 'hivernage'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%mise à jour logiciel%' THEN 'mise à jour logiciel'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%nettoyage%' THEN 'nettoyage'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%peinture%' THEN 'peinture'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%redressage mât%' THEN 'redressage mât'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%remise en service%' THEN 'remise en service'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%remplacement%' THEN 'remplacement'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%réparation%' THEN 'réparation'
    END
FROM staging.interventions;
