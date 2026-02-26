-- AppClient seed data
-- Defines the tenant registry for multi-tenancy support.

INSERT INTO app_client (key, name) VALUES
    ('template', 'Template App')
ON CONFLICT (key) DO UPDATE SET
    name = EXCLUDED.name;
