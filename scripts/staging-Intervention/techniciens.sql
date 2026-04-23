INSERT INTO public.techniciens (nom, prenom, telephone, email)
SELECT 
    SPLIT_PART(technicien, ' ', 2) AS nom,
    SPLIT_PART(technicien, ' ', 1) AS prenom,
    '+41791234567' AS telephone,
    'jhon.doe@exmaple.com' AS email
FROM (
    SELECT DISTINCT technicien
    FROM staging.interventions
    WHERE technicien IS NOT NULL
) t;