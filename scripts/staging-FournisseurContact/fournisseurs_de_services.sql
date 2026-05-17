
INSERT INTO public.fournisseurs_de_services (id_fournisseurs)
SELECT id FROM public.fournisseurs
WHERE entreprise = 'Ville Propre Sàrl';


