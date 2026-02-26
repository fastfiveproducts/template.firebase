-- Rename title → subject on public_comment and private_message tables.
-- Run this before deploying the schema change so existing rows are migrated.

-- public_comment
ALTER TABLE "public"."public_comment" ADD COLUMN "subject" text;
UPDATE "public"."public_comment" SET "subject" = "title";
ALTER TABLE "public"."public_comment" ALTER COLUMN "subject" SET NOT NULL;
ALTER TABLE "public"."public_comment" DROP COLUMN "title";

-- private_message
ALTER TABLE "public"."private_message" ADD COLUMN "subject" text;
UPDATE "public"."private_message" SET "subject" = "title";
ALTER TABLE "public"."private_message" ALTER COLUMN "subject" SET NOT NULL;
ALTER TABLE "public"."private_message" DROP COLUMN "title";
