-- Feature Flag seed data
-- Set enabled = true for features that should be active by default.
-- Generally the app defaults all flags to OFF unless the database returns them as ON.

INSERT INTO feature_flag (code, app_client_key, enabled) VALUES
    ('publicComments', 'template', true),
    ('privateMessages', 'template', true),
    ('activityLog', 'template', true),
    ('settings', 'template', true),
    ('userAccountProfile', 'template', true),
    ('userAssociations', 'template', true),
    ('userDemographics', 'template', true)
ON CONFLICT (code, app_client_key) DO UPDATE SET enabled = EXCLUDED.enabled;
