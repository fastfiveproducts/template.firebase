-- AppClient seed data
-- Defines the tenant registry for multi-tenancy support.

INSERT INTO app_client (key, name, description, photo_url) VALUES
    ('template', 'Template App', 'The default template application', NULL)
ON CONFLICT (key) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    photo_url = EXCLUDED.photo_url;
