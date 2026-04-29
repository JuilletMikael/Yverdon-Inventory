-- UPDATE staging.signalements
-- SET "date" = TO_CHAR(
--     TO_DATE("date", 'DD.MM.YYYY'),
--     'YYYY-MM-DD'
-- )
-- WHERE "date" ~ '^\d{2}\.\d{2}\.\d{4}$';
/*
Il manquais le deuxième type de date 2023-01-12,
on as pas besoin d'update pour l'instant donc un select suffit
et on as pas besoin du to_char() car c'est déjà un texte
*/
SELECT 
    CASE 
        WHEN date ~ '^\d{2}\.\d{2}\.\d{4}$'
            THEN TO_DATE("date", 'DD.MM.YYYY')
        WHEN date ~ '^\d{4}-\d{2}-\d{2}$'
            THEN TO_DATE("date", 'YYYY-MM-DD')
    END
from staging.signalements;