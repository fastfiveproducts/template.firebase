-- Backfill NULL setTimestamp values with createTimestamp
-- for UserDisplayName rows created before setTimestamp had a default value.
UPDATE user_display_name
   SET set_timestamp = create_timestamp
 WHERE set_timestamp IS NULL;
