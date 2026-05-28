-- Ce script est 100% générer par IA dans le but de s'assurer que l'ensemble des script puisse fournir des valleurs finales de comptabilité.

CREATE OR REPLACE VIEW public.v_cout_par_type_mobilier AS
SELECT

    EXTRACT(YEAR FROM inter.date) AS annee,

    ti.libelle AS type_mobilier,

    COUNT(DISTINCT inter.id) AS nombre_interventions,

    COALESCE(SUM(f.cout_total), 0) AS cout_total,

    ROUND(
        COALESCE(AVG(f.cout_total), 0),
        2
    ) AS cout_moyen_par_intervention

FROM public.interventions inter

LEFT JOIN public.interventions_factures ifac
    ON ifac.id_interventions = inter.id

LEFT JOIN public.factures f
    ON f.id = ifac.id_factures

INNER JOIN public.tickets t
    ON t.id = inter.id_tickets

INNER JOIN public.inventaires inv
    ON inv.id = t.id_inventaire

INNER JOIN public.types_inventaires ti
    ON ti.id = inv.id_types_inventaires

WHERE EXTRACT(YEAR FROM inter.date) IN (2024, 2025)

GROUP BY
    annee,
    ti.libelle

ORDER BY
    annee,
    cout_total DESC;