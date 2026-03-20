-- Active: 1773394971258@@127.0.0.1@5432@yverdon-inventory@staging
-- Active: 1773394971258@@127.0.0.1@5432@yverdon-inventory


--Aperçu colonne materiau
SELECT materiau, COUNT(*) AS nb
FROM inventaire_mobilier
GROUP BY materiau
ORDER BY nb DESC;

DELETE FROM inventaire_mobilier
WHERE TRIM(materiau) = '' OR materiau IS NULL;

UPDATE inventaire_mobilier
SET materiau = CASE LOWER(TRIM(materiau))
    WHEN 'bois'         THEN 'bois'
    WHEN 'Métal'  THEN 'métal'
    WHEN 'metal'        THEN 'métal'
    WHEN 'sodium'    THEN 'sodium'
    WHEN 'LED'          THEN 'led'
    WHEN 'pierre'        THEN 'pierre'
    WHEN 'Pierre'        THEN 'pierre'
    WHEN 'béton'          THEN 'béton'
    ELSE LOWER(TRIM(materiau))  -- minuscules + trim pour tout le reste
END;



