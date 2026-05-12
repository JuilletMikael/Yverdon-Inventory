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

INSERT INTO public.techniciens (prenom, nom, telephone, email) VALUES
('Jean-Marc', 'Bonvin', '024 423 55 01', 'jm.bonvin@yverdon.ch'),
('Pedro', 'Alves', '024 423 55 02', 'p.alves@yverdon.ch'),
('Marc', 'Koffi', '024 423 55 03', 'm.koffi@yverdon.ch');


Insert INTO public.techniciens (prenom, nom, telephone, email)
SELECT DISTINCT nom, prenom, telephone, email
FROM staging.techniciens;