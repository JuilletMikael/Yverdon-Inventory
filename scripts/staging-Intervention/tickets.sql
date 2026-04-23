-- CREATE TABLE tickets (
--     id SERIAL PRIMARY KEY,
--     id_etats_tickets INT NOT NULL REFERENCES etats_tickets(id),
--     id_urgences INT NOT NULL REFERENCES urgences(id)
-- );


-- INSERT INTO public.tickets (id_etats_tickets, id_urgences)
-- SELECT 
--     SPLIT_PART(technicien, ' ', 1) AS nom,
--     SPLIT_PART(technicien, ' ', 2) AS prenom,
--     '+41791234567' AS telephone,
--     'jhon.doe@exmaple.com' AS email
-- FROM (
--     SELECT DISTINCT technicien
--     FROM staging.interventions
--     WHERE technicien IS NOT NULL
-- ) t;

-- SELECT DISTINCT
--     urgence,
--     statut
-- FROM staging.signalements
-- LEFT JOIN public.urgences public_urgences
--     ON LOWER(TRIM(urgence)) LIKE '%' || public_urgences.libelle || '%'
-- LEFT JOIN public.etats_tickets public_etat
--     ON LOWER(TRIM(statut)) LIKE '%' || public_etat.libelle || '%';
    
INSERT INTO public.tickets (id_etats_tickets, id_urgences)
SELECT DISTINCT
    etat.id,
    urgence.id
FROM staging.signalements s

LEFT JOIN public.urgences urgence
    ON LOWER(TRIM(s.urgence)) LIKE '%' || urgence.libelle || '%'

LEFT JOIN public.etats_tickets etat
    ON LOWER(TRIM(s.statut)) LIKE '%' || etat.libelle || '%'

WHERE urgence.id IS NOT NULL
  AND etat.id IS NOT NULL;