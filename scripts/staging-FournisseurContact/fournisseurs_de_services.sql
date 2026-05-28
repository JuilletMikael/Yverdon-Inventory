
INSERT INTO public.fournisseurs_de_services (
    id_fournisseurs,
    id_types_services
)SELECT
    f.id,
    ts.id
FROM public.fournisseurs f
JOIN public.types_services ts ON ts.libelle = 'nettoyage'
WHERE f.entreprise = 'Ville Propre Sàrl';


