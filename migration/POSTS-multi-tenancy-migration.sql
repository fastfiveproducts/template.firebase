-- Multi-tenancy migration — run ONCE before deploying the schema changes.
--
-- Firebase Data Connect cannot add a NOT NULL column to tables that already
-- contain rows.  This script creates the app_client table, seeds the default
-- tenant, then adds the app_client_key column to each affected table with a
-- backfill so the subsequent deploy sees the schema already in the target state.
--
-- Run against your Cloud SQL instance with:
--   gcloud sql connect <INSTANCE> --database=<DB> --user=firebaseowner_<DB>_public
-- or via the Cloud SQL Studio in the Google Cloud console.

BEGIN;

-- Set the role that owns the Data Connect schema objects.
-- Replace the role name below if your project uses a different convention.
SET ROLE "firebaseowner_template-9960d-2-database_public";

-----------------------------------------------------------------
-- 1. AppClient table
-----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "public"."app_client" (
    "key"        text NOT NULL,
    "name"       text NOT NULL,
    PRIMARY KEY ("key")
);

-- Match the unique index Data Connect would create.
CREATE UNIQUE INDEX IF NOT EXISTS "app_client_key_uidx"
    ON "public"."app_client" ("key");

-- Seed the default tenant.
INSERT INTO "public"."app_client" ("key", "name")
VALUES ('template', 'Template App')
ON CONFLICT ("key") DO NOTHING;

-----------------------------------------------------------------
-- 2. feature_flag  — add column, backfill, set NOT NULL, rekey
-----------------------------------------------------------------
ALTER TABLE "public"."feature_flag"
    ADD COLUMN IF NOT EXISTS "app_client_key" text;

UPDATE "public"."feature_flag"
    SET "app_client_key" = 'template'
    WHERE "app_client_key" IS NULL;

ALTER TABLE "public"."feature_flag"
    ALTER COLUMN "app_client_key" SET NOT NULL;

-- Swap primary key from (code) to (code, app_client_key).
ALTER TABLE "public"."feature_flag"
    DROP CONSTRAINT IF EXISTS "feature_flag_pkey";
ALTER TABLE "public"."feature_flag"
    ADD PRIMARY KEY ("code", "app_client_key");

-- Foreign key to app_client.
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'feature_flag_app_client_key_fkey'
    ) THEN
        ALTER TABLE "public"."feature_flag"
            ADD CONSTRAINT "feature_flag_app_client_key_fkey"
            FOREIGN KEY ("app_client_key")
            REFERENCES "public"."app_client" ("key") ON DELETE CASCADE;
    END IF;
END $$;

-----------------------------------------------------------------
-- 3. public_comment — add column, backfill, set NOT NULL
-----------------------------------------------------------------
ALTER TABLE "public"."public_comment"
    ADD COLUMN IF NOT EXISTS "app_client_key" text;

UPDATE "public"."public_comment"
    SET "app_client_key" = 'template'
    WHERE "app_client_key" IS NULL;

ALTER TABLE "public"."public_comment"
    ALTER COLUMN "app_client_key" SET NOT NULL;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'public_comment_app_client_key_fkey'
    ) THEN
        ALTER TABLE "public"."public_comment"
            ADD CONSTRAINT "public_comment_app_client_key_fkey"
            FOREIGN KEY ("app_client_key")
            REFERENCES "public"."app_client" ("key") ON DELETE CASCADE;
    END IF;
END $$;

-----------------------------------------------------------------
-- 4. private_message — add column, backfill, set NOT NULL
-----------------------------------------------------------------
ALTER TABLE "public"."private_message"
    ADD COLUMN IF NOT EXISTS "app_client_key" text;

UPDATE "public"."private_message"
    SET "app_client_key" = 'template'
    WHERE "app_client_key" IS NULL;

ALTER TABLE "public"."private_message"
    ALTER COLUMN "app_client_key" SET NOT NULL;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'private_message_app_client_key_fkey'
    ) THEN
        ALTER TABLE "public"."private_message"
            ADD CONSTRAINT "private_message_app_client_key_fkey"
            FOREIGN KEY ("app_client_key")
            REFERENCES "public"."app_client" ("key") ON DELETE CASCADE;
    END IF;
END $$;

COMMIT;
