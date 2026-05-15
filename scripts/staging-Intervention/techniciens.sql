Insert INTO public.techniciens (prenom, nom, telephone, email)
SELECT DISTINCT nom, prenom, telephone, email
FROM staging.techniciens;