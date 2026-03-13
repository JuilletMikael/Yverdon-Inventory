CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE types_interventions (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);

CREATE TABLE etats_tickets (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);

CREATE TABLE urgences (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);

CREATE TABLE types_signalements (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);

CREATE TABLE etats_inventaires (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);

CREATE TABLE types_inventaires (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);

CREATE TABLE materiaux (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);

CREATE TABLE types_materiels (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);


CREATE TABLE types_services (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);

CREATE TABLE etats_fournisseurs (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);

CREATE TABLE langues (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);

CREATE TABLE etats_factures (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);


-- 

CREATE TABLE techniciens (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    telephone VARCHAR(20) CHECK (telephone ~ '^\+?[0-9 ]{7,20}$'),
    email VARCHAR(254) CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    id_etats_tickets INT NOT NULL REFERENCES etats_tickets(id),
    id_urgences INT NOT NULL REFERENCES urgences(id)
);

CREATE TABLE interventions (
    id SERIAL PRIMARY KEY,
    date DATE,
    durée INT,
    remarques TEXT,
    id_tickets INT NOT NULL REFERENCES tickets(id),
    id_techniciens INT NOT NULL REFERENCES techniciens(id),
    id_types_interventions INT NOT NULL REFERENCES types_interventions(id)
);

CREATE TABLE reporters (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    telephone VARCHAR(20) CHECK (telephone ~ '^\+?[0-9 ]{7,20}$'),
    email VARCHAR(254) CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE TABLE fournisseurs (
    id SERIAL PRIMARY KEY,
    entreprise VARCHAR(100),
    contact VARCHAR(100),
    telephone VARCHAR(20) CHECK (telephone ~ '^\+?[0-9 ]{7,20}$'),
    email VARCHAR(254) CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    id_etats_fournisseurs INT NOT NULL REFERENCES etats_fournisseurs(id),
    id_langues INT NOT NULL REFERENCES langues(id)
);

CREATE TABLE fournisseurs_de_services (
    id SERIAL PRIMARY KEY,
    id_fournisseurs INT NOT NULL REFERENCES fournisseurs(id),
    id_types_services INT NOT NULL REFERENCES types_services(id)
);

CREATE TABLE fournisseurs_de_materiels (
    id SERIAL PRIMARY KEY,
    id_fournisseurs INT NOT NULL REFERENCES fournisseurs(id),
    id_types_materiels INT NOT NULL REFERENCES types_materiels(id)
);

CREATE TABLE factures (
    id SERIAL PRIMARY KEY,
    reference_commande VARCHAR(10),
    date DATE,
    cout_total DECIMAL(15,2),
    id_etats_factures INT NOT NULL REFERENCES etats_factures(id),
    id_fournisseurs INT NOT NULL REFERENCES fournisseurs(id)
);

CREATE TABLE interventions_factures (
    id SERIAL PRIMARY KEY,
    cout_total DECIMAL(15,2),
    id_factures INT NOT NULL REFERENCES factures(id),
    id_interventions INT NOT NULL REFERENCES interventions(id)
);

-- ===========================================
-- TABLE: inventaires
-- position en WGS84 (SRID 4326)
-- ===========================================
CREATE TABLE inventaires (
    id SERIAL PRIMARY KEY,
    reference VARCHAR(10),
    position GEOMETRY(POINT, 4326),
    date_installation DATE,
    prix DECIMAL(15,2),
    remarques TEXT,
    id_factures INT REFERENCES factures(id),
    id_types_inventaires INT NOT NULL REFERENCES types_inventaires(id),
    id_etats_inventaires INT NOT NULL REFERENCES etats_inventaires(id)
);

CREATE TABLE signalements (
    id SERIAL PRIMARY KEY,
    description TEXT,
    id_tickets INT REFERENCES tickets(id),
    id_reporteurs INT NOT NULL REFERENCES reporters(id),
    id_inventaires INT NOT NULL REFERENCES inventaires(id),
    id_types_signalements INT NOT NULL REFERENCES types_signalements(id)
);