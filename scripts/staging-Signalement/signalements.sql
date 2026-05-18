-- Active: 1774596950136@@127.0.0.1@5432@yverdon-inventory
CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    id_etats_tickets INT NOT NULL REFERENCES etats_tickets(id),
    id_urgences INT NOT NULL REFERENCES urgences(id)
);


INSERT INTO public.signalements (
    description,
    id_inventaires,
    id_reporteurs,
    id_types_signalements
)
SELECT DISTINCT
    ss.description,
    inv.id AS id_inventaires,
    rep.id AS id_reporteurs,
    type_sig.id AS id_types_signalements
FROM staging.signalements ss
INNER JOIN public.types_signalements type_sig ON type_sig.libelle = CASE WHEN LOWER(TRIM(ss.description)) LIKE '%banc%' THEN 'banc' WHEN LOWER(TRIM(ss.description)) LIKE '%lampadaire%' THEN 'lampadaire' WHEN LOWER(TRIM(ss.description)) LIKE '%poubelle%' THEN 'poubelle' WHEN LOWER(TRIM(ss.description)) LIKE '%corbeille%' THEN 'corbeille' WHEN LOWER(TRIM(ss.description)) LIKE '%fontaine%' THEN 'fontaine' WHEN LOWER(TRIM(ss.description)) LIKE '%borne%' THEN 'borne ev' WHEN LOWER(TRIM(ss.description)) LIKE '%panneau%' THEN 'panneau' END
INNER JOIN public.types_inventaires type_inv ON type_inv.libelle = type_sig.libelle
INNER JOIN public.inventaires inv ON inv.id_types_inventaires = type_inv.id
LEFT JOIN public.reporters rep ON 
    rep.nom = CASE WHEN ss.signale_par ~ 'concierge école' THEN 'Rateur' WHEN ss.signale_par ~ 'patrouille JM' THEN 'Maria' WHEN ss.signale_par ~ 'Mme Weber' THEN 'Weber' WHEN ss.signale_par ~ 'Mme Rochat' THEN 'Rochat' WHEN ss.signale_par ~ 'Mme Dupont' THEN 'Dupont' WHEN ss.signale_par ~ 'M. Pereira' THEN 'Pereira' WHEN ss.signale_par ~ 'M. Keller' THEN 'Keller' ELSE 'unknown citizen' END
    AND rep.prenom = CASE WHEN ss.signale_par ~ 'concierge école' THEN 'Aspi' WHEN ss.signale_par ~ 'patrouille JM' THEN 'Jean' WHEN ss.signale_par ~ 'Mme Weber' THEN 'Lisa' WHEN ss.signale_par ~ 'Mme Rochat' THEN 'Emilie' WHEN ss.signale_par ~ 'Mme Dupont' THEN 'Josette' WHEN ss.signale_par ~ 'M. Pereira' THEN 'Mark' WHEN ss.signale_par ~ 'M. Keller' THEN 'Patrick' ELSE 'unknown citizen' END
WHERE rep.id IS NOT NULL AND type_sig.id IS NOT NULL;

INSERT INTO public.tickets (
    id_etats_tickets,
    id_urgences
)

