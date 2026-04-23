CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    id_etats_tickets INT NOT NULL REFERENCES etats_tickets(id),
    id_urgences INT NOT NULL REFERENCES urgences(id)
);

