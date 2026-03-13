-- Active: 1773394971258@@127.0.0.1@5432@yverdon-inventory
CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.fournisseurs_contacts (
    entreprise TEXT, contact TEXT, telephone TEXT, email TEXT,
    type_materiel TEXT, remarques TEXT
);

COPY staging.fournisseurs
FROM '/data/fournisseurs_contacts.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

CREATE TABLE staging.interventions (
    date TEXT, objet TEXT, type_intervention TEXT, technicien TEXT,
    duree TEXT, cout_materiel TEXT, remarques TEXT
);

COPY staging.interventions
FROM '/data/interventions.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');
