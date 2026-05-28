Insert INTO public.techniciens ( nom, prenom, telephone, email)
SELECT DISTINCT nom, prenom, telephone, email
FROM staging.techniciens;

-- Ajoute un stagiaire
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