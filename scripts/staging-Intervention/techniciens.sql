INSERT INTO public.techniciens (prenom, nom)
SELECT DISTINCT
    CASE 
        WHEN technicien ~ 'JM|Jean-Marc' 
            THEN  'Jean-Marc'
        WHEN technicien ~ 'Alves|Pedro'
            THEN 'Pedro'
        WHEN technicien ~ 'Koffi Marc'
            THEN 'Marc'
        WHEN technicien ~ 'stagiaire'
            THEN 'stagiaire'
    END AS prenom,
    CASE 
        WHEN technicien ~ 'JM|Jean-Marc' 
            THEN  'Bonvin'
        WHEN technicien ~ 'Alves|Pedro'
            THEN 'Alves'
        WHEN technicien ~ 'Koffi Marc'
            THEN 'Koffi'
        WHEN technicien ~ 'stagiaire'
            THEN ''
    END AS nom
FROM staging.interventions;