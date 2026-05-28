CREATE ROLE citoyens;
CREATE ROLE techniciens;
CREATE ROLE administrateurs;

GRANT USAGE ON SCHEMA public TO citoyens;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO citoyens;

GRANT USAGE ON SCHEMA public TO techniciens;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO techniciens;

GRANT USAGE ON SCHEMA public TO administrateurs;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO administrateurs;

SELECT grantee, table_schema, privilege_type
FROM information_schema.role_table_grants
WHERE grantee IN ('citoyens', 'techniciens', 'administrateurs')
ORDER BY grantee, table_name, privilege_type;