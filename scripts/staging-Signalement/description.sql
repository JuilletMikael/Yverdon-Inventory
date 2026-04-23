SELECT description, COUNT(*) AS nb
FROM staging.signalements
GROUP BY
    description
ORDER BY nb DESC;

CREATE TABLE type_signalements (
    id SERIAL PRIMARY KEY,
    libelle TEXT NOT NULL
);

INSERT INTO type_signalements (libelle)
VALUES
  ('cassé'),
  ('défectueux'),
  ('abîmé');

  
ALTER TABLE staging.signalements
ADD COLUMN type_signalement_id INTEGER;

INSERT INTO type_signalements (libelle)
SELECT DISTINCT
    CASE
        WHEN LOWER(description) ~ 'cassé|cassée|fissur|fendu|manquant|décollé'
            THEN 'cassé'
        WHEN LOWER(description) ~ 'éclaire|clignote|ne s.allume|ne charge|ne coule|fuit|débord|ampoule'
            THEN 'défectueux'
        WHEN LOWER(description) ~ 'tag|graffiti|mousse|algue|pourri|brûl|penché|tordu|renvers|gel|tempête|vis'
            THEN 'abîmé'
    END AS libelle
FROM staging.signalements
WHERE description IS NOT NULL;

ALTER TABLE staging.signalements
ADD CONSTRAINT fk_type_signalement
FOREIGN KEY (type_signalement_id)
REFERENCES type_signalements(id);

SELECT ts.libelle, COUNT(*) AS nb
FROM staging.signalements s
JOIN type_signalements ts
  ON s.type_signalement_id = ts.id
GROUP BY ts.libelle;