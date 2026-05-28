Insert INTO public.techniciens ( nom, prenom, telephone, email)
SELECT DISTINCT nom, prenom, telephone, email
FROM staging.techniciens;

INSERT INTO public.techniciens (
    nom,
    prenom,
    telephone,
    email
)
VALUES (
    'stagiaire',
    'stagiaire',
    NULL,
    NULL
);