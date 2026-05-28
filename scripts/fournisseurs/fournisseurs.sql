-- Formate : telephone, email.
-- Lie l'englais seulement si mention de germanophone.
-- Lie etats_fournisseurs après être formate.

INSERT INTO public.fournisseurs 
    (
        entreprise,
        contact,
        telephone,
        email,
        id_etats_fournisseurs,
        id_langues
    )

SELECT
    entreprise,
    contact,
    
    CASE
        WHEN REGEXP_REPLACE(telephone, '[^0-9+]', '', 'g') ~ '^0[0-9]{9}$' THEN '+41' || SUBSTRING(
            REGEXP_REPLACE(telephone, '[^0-9]', '', 'g')
            FROM 2
        )
        WHEN REGEXP_REPLACE(telephone, '[^0-9+]', '', 'g') ~ '^\+41[0-9]{9}$' THEN REGEXP_REPLACE(telephone, '\s+', '', 'g')
        ELSE NULL
    END AS telephone_normalise,
    
    CASE
        WHEN LOWER(TRIM(email)) ~ '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$' THEN LOWER(TRIM(email))
        ELSE NULL
    END AS email_normalise,
    ef.id AS etat_fourn,
    lg.id AS lang

FROM staging.fournisseurs_contacts
    
INNER JOIN public.etats_fournisseurs ef ON ef.libelle = (
    CASE
        WHEN LOWER(
            TRIM(PUBLIC.unaccent (remarques))
        ) LIKE '%ferme%' THEN 'ferme'
        WHEN LOWER(
            TRIM(PUBLIC.unaccent (remarques))
        ) LIKE '%urgence%' THEN 'urgences'
        ELSE 'actif'
    END
)

INNER JOIN public.langues lg ON lg.libelle = (
    CASE
        WHEN LOWER(
            TRIM(PUBLIC.unaccent (remarques))
        ) LIKE '%germanophone%' THEN 'allemand'
        ELSE 'français'
    END
);