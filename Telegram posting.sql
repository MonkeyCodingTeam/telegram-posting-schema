CREATE TYPE "ChatTypes" AS ENUM (
  'private',
  'channel',
  'group',
  'supergroup'
);

CREATE TABLE "Chats" (
  "id" bigint PRIMARY KEY,
  "name" varchar(55),
  "username" varchar(55),
  "last_name" varchar(55),
  "first_name" varchar(55),
  "timezone" timezone,
  "type" ChatTypes,
  "has_bot" boolean,
  "has_bot_access" boolean,
  "created_at" timezone,
  "updated_at" timezone
);

CREATE TABLE "Folders" (
  "id" bigint PRIMARY KEY,
  "name" varchar(55),
  "created_at" timezone,
  "updated_at" timezone
);

CREATE TABLE "ChatsFolders" (
  "chat_id" bigint,
  "folder_id" bigint,
  "created_at" timezone,
  PRIMARY KEY ("chat_id", "folder_id")
);

CREATE TABLE "ContentPlans" (
  "id" int PRIMARY KEY,
  "name" varchar(55),
  "created_at" timezone,
  "updated_at" timezone
);

CREATE TABLE "Templates" (
  "id" int PRIMARY KEY,
  "text" text,
  "send_at" timestamp,
  "content_plan_id" int,
  "created_at" timezone,
  "updated_at" timezone
);

CREATE TABLE "ContentPlansFolders" (
  "folder_id" int,
  "content_plan_id" int,
  "created_at" timezone
);

CREATE TABLE "ContentPlansChats" (
  "chat_id" bigint,
  "content_plan_id" int,
  "created_at" timezone
);

CREATE TABLE "Contents" (
  "id" bigint PRIMARY KEY,
  "file_name" varchar(255),
  "s3_key" varchar(512),
  "s3_bucket" varchar(255),
  "mime_type" varchar(128),
  "size" bigint
);

CREATE TABLE "Posts" (
  "id" bigint PRIMARY KEY,
  "text" string,
  "content_id" bigint,
  "template_id" int,
  "chat_id" bigint,
  "message_id" int,
  "schedule_date" timezone,
  "random_id" bigint,
  "entities" json,
  "silent" boolean,
  "created_at" timezone,
  "updated_at" timezone
);

CREATE TABLE "Stories" (
  "id" bigint PRIMARY KEY,
  "text" string,
  "content_id" bigint,
  "template_id" int,
  "chat_id" bigint,
  "story_id" bigint,
  "entities" json,
  "period" int,
  "created_at" timezone,
  "updated_at" timezone
);

CREATE TABLE "VideoNote" (
  "id" bigint PRIMARY KEY,
  "chat_id" bigint,
  "content_id" bigint,
  "thumbnail_id" bigint,
  "disable_notification" boolean,
  "duration" int,
  "length" int,
  "created_at" timezone,
  "updated_at" timezone
);

ALTER TABLE "ChatsFolders" ADD FOREIGN KEY ("chat_id") REFERENCES "Chats" ("id");

ALTER TABLE "ChatsFolders" ADD FOREIGN KEY ("folder_id") REFERENCES "Folders" ("id");

ALTER TABLE "Templates" ADD FOREIGN KEY ("content_plan_id") REFERENCES "ContentPlans" ("id");

ALTER TABLE "ContentPlansFolders" ADD FOREIGN KEY ("folder_id") REFERENCES "Folders" ("id");

ALTER TABLE "ContentPlansFolders" ADD FOREIGN KEY ("content_plan_id") REFERENCES "ContentPlans" ("id");

ALTER TABLE "ContentPlansChats" ADD FOREIGN KEY ("chat_id") REFERENCES "Chats" ("id");

ALTER TABLE "ContentPlansChats" ADD FOREIGN KEY ("content_plan_id") REFERENCES "ContentPlans" ("id");

ALTER TABLE "Posts" ADD FOREIGN KEY ("content_id") REFERENCES "Contents" ("id");

ALTER TABLE "Posts" ADD FOREIGN KEY ("template_id") REFERENCES "Templates" ("id");

ALTER TABLE "Posts" ADD FOREIGN KEY ("chat_id") REFERENCES "Chats" ("id");

ALTER TABLE "Stories" ADD FOREIGN KEY ("content_id") REFERENCES "Contents" ("id");

ALTER TABLE "Stories" ADD FOREIGN KEY ("template_id") REFERENCES "Templates" ("id");

ALTER TABLE "Stories" ADD FOREIGN KEY ("chat_id") REFERENCES "Chats" ("id");

ALTER TABLE "VideoNote" ADD FOREIGN KEY ("chat_id") REFERENCES "Chats" ("id");

ALTER TABLE "VideoNote" ADD FOREIGN KEY ("content_id") REFERENCES "Contents" ("id");

ALTER TABLE "VideoNote" ADD FOREIGN KEY ("thumbnail_id") REFERENCES "Contents" ("id");
