-- THIS IS AN EXEMPLE OF WHAT TYPE OF DATA SHOULD BE HERE

-- INSERT INTO movies (title, release_year) VALUES
-- ('Toy Story', 1995),
-- ('A Bug''s Life', 1998),
-- ('Toy Story 2', 1999),
-- ('Monsters, Inc.', 2001),
-- ('Finding Nemo', 2003),
-- ('The Incredibles', 2004),
-- ('Cars', 2006),
-- ('Ratatouille', 2007),
-- ('WALL-E', 2008),
-- ('Up', 2009),
-- ('Toy Story 3', 2010),
-- ('Cars 2', 2011),
-- ('Brave', 2012),
-- ('Monsters University', 2013);


-- INSERT INTO boxoffice (movie_id, rating, domestic_sales, international_sales) VALUES
-- (1, 8.3, 191000000, 170000000),      -- Toy Story
-- (2, 7.2, 162000000, 200000000),      -- A Bug's Life
-- (3, 7.9, 245000000, 250000000),      -- Toy Story 2
-- (4, 8.1, 289000000, 272000000),      -- Monsters, Inc.
-- (5, 8.2, 380000000, 555000000),      -- Finding Nemo
-- (6, 8.0, 261000000, 370000000),      -- The Incredibles
-- (7, 7.1, 244000000, 217000000),      -- Cars
-- (8, 8.0, 206000000, 417000000),      -- Ratatouille
-- (9, 8.4, 223000000, 309000000),      -- WALL-E
-- (10, 8.2, 292000000, 438000000),     -- Up
-- (11, 8.3, 415000000, 648000000),     -- Toy Story 3
-- (12, 6.2, 191000000, 370000000),     -- Cars 2
-- (13, 7.1, 237000000, 303000000),     -- Brave
-- (14, 7.3, 268000000, 475000000);     -- Monsters University

-- initdb/02-staging.sql



CREATE SCHEMA IF NOT EXISTS staging;


CREATE TABLE staging.inventaire_mobilier (
    id TEXT, type TEXT, materiau TEXT, lieu TEXT,
    latitude TEXT, longitude TEXT,
    date_installation TEXT, etat TEXT, remarques TEXT
);


-- Import CSV — data/ est monté sous /data/ dans le conteneur
COPY staging.inventaire_mobilier
FROM '/data/inventaire_mobilier.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');




CREATE SCHEMA IF NOT EXISTS staging;


CREATE TABLE staging.signalements (
    date TEXT, signale_par TEXT, objet TEXT, description TEXT,
    urgence TEXT, statut TEXT
);


-- Import CSV — data/ est monté sous /data/ dans le conteneur
COPY staging.signalements
FROM '/data/signalements.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

SELECT COUNT(*) FROM staging.inventaire_mobilier; 
SELECT COUNT(*) FROM staging.signalements;  

