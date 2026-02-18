-- Feature Flag seed data
-- Set enabled = true for features that should be active by default.
-- Generally the app defaults all flags to OFF unless the database returns them as ON.

INSERT INTO feature_flag (code, enabled) VALUES
    ('publicComments', true),
    ('privateMessages', true),
    ('activityLog', true),
    ('settings', true),
    ('userAccountProfile', true),
    ('userAssociations', true),
    ('userDemographics', true)
ON CONFLICT (code) DO UPDATE SET enabled = EXCLUDED.enabled;
