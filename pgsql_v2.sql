CREATE TYPE "chats_type_enum" AS ENUM (
  'sender',
  'private',
  'group',
  'supergroup',
  'channel'
);

CREATE TABLE "chat_folder" (
  "chat_id" bigint(20) NOT NULL,
  "folder_id" bigint(20) NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (current_timestamp())
);

CREATE TABLE "chats" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "username" varchar(255) NOT NULL,
  "old_id" bigint(20) DEFAULT null,
  "title" varchar(255) DEFAULT null,
  "first_name" varchar(255) DEFAULT null,
  "last_name" varchar(255) DEFAULT null,
  "type" chats_type_enum NOT NULL,
  "has_bot" tinyint(1) NOT NULL DEFAULT 0,
  "timezone" tinyint(1) NOT NULL,
  "deleted_at" timestamp DEFAULT null,
  "created_at" timestamp DEFAULT null,
  "updated_at" timestamp DEFAULT null
);

CREATE TABLE "content_plan_chat" (
  "content_plan_id" bigint(20) NOT NULL,
  "chat_id" bigint(20) NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (current_timestamp())
);

CREATE TABLE "content_plan_folder" (
  "content_plan_id" bigint(20) NOT NULL,
  "folder_id" bigint(20) NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (current_timestamp())
);

CREATE TABLE "content_plans" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" varchar(55) NOT NULL,
  "created_at" timestamp DEFAULT null,
  "updated_at" timestamp DEFAULT null
);

CREATE TABLE "content_post" (
  "post_id" bigint(20) NOT NULL,
  "content_id" bigint(20) NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (current_timestamp())
);

CREATE TABLE "contents" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "file_name" varchar(255) NOT NULL,
  "s3_key" varchar(512) DEFAULT null,
  "s3_bucket" varchar(255) DEFAULT null,
  "disk" varchar(55) NOT NULL DEFAULT 'local',
  "path" varchar(255) NOT NULL,
  "mime_type" varchar(128) NOT NULL,
  "size" bigint(20) NOT NULL,
  "created_at" timestamp DEFAULT null,
  "updated_at" timestamp DEFAULT null
);

CREATE TABLE "failed_jobs" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "uuid" varchar(255) NOT NULL,
  "connection" text NOT NULL,
  "queue" text NOT NULL,
  "payload" longtext NOT NULL,
  "exception" longtext NOT NULL,
  "failed_at" timestamp NOT NULL DEFAULT (current_timestamp())
);

CREATE TABLE "folders" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" varchar(55) NOT NULL,
  "created_at" timestamp DEFAULT null,
  "updated_at" timestamp DEFAULT null
);

CREATE TABLE "job_batches" (
  "id" varchar(255) PRIMARY KEY NOT NULL,
  "name" varchar(255) NOT NULL,
  "total_jobs" int(11) NOT NULL,
  "pending_jobs" int(11) NOT NULL,
  "failed_jobs" int(11) NOT NULL,
  "failed_job_ids" longtext NOT NULL,
  "options" mediumtext DEFAULT null,
  "cancelled_at" int(11) DEFAULT null,
  "created_at" int(11) NOT NULL,
  "finished_at" int(11) DEFAULT null
);

CREATE TABLE "jobs" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "queue" varchar(255) NOT NULL,
  "payload" longtext NOT NULL,
  "attempts" tinyint(3) NOT NULL,
  "reserved_at" int(10) DEFAULT null,
  "available_at" int(10) NOT NULL,
  "created_at" int(10) NOT NULL
);

CREATE TABLE "migrations" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "migration" varchar(255) NOT NULL,
  "batch" int(11) NOT NULL
);

CREATE TABLE "posts" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "text" text NOT NULL,
  "entities" longtext DEFAULT null,
  "silent" tinyint(1) NOT NULL DEFAULT 0,
  "publish_date" datetime DEFAULT null,
  "random_id" int(11) DEFAULT null,
  "message_id" int(11) DEFAULT null,
  "chat_id" bigint(20) DEFAULT null,
  "template_id" bigint(20) DEFAULT null,
  "folder_id" bigint(20) DEFAULT null,
  "parent_id" bigint(20) DEFAULT null,
  "created_at" timestamp DEFAULT null,
  "updated_at" timestamp DEFAULT null
);

CREATE TABLE "stories" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "caption" text DEFAULT null,
  "entities" longtext DEFAULT null,
  "publish_date" datetime DEFAULT null,
  "period" int(11) NOT NULL DEFAULT 86400,
  "random_id" int(11) DEFAULT null,
  "story_id" int(11) DEFAULT null,
  "content_id" bigint(20) NOT NULL,
  "chat_id" bigint(20) DEFAULT null,
  "template_id" bigint(20) DEFAULT null,
  "folder_id" bigint(20) DEFAULT null,
  "parent_id" bigint(20) DEFAULT null,
  "created_at" timestamp DEFAULT null,
  "updated_at" timestamp DEFAULT null
);

CREATE TABLE "templates" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "text" text NOT NULL,
  "entities" longtext DEFAULT null,
  "publish_date" datetime DEFAULT null,
  "content_plan_id" bigint(20) NOT NULL,
  "created_at" timestamp DEFAULT null,
  "updated_at" timestamp DEFAULT null
);

CREATE TABLE "video_notes" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "duration" int(11) NOT NULL,
  "length" int(11) NOT NULL,
  "silent" tinyint(1) NOT NULL DEFAULT 0,
  "publish_date" datetime DEFAULT null,
  "message_id" int(11) DEFAULT null,
  "thumbnail_id" bigint(20) DEFAULT null,
  "content_id" bigint(20) NOT NULL,
  "chat_id" bigint(20) DEFAULT null,
  "folder_id" bigint(20) DEFAULT null,
  "parent_id" bigint(20) DEFAULT null,
  "created_at" timestamp DEFAULT null,
  "updated_at" timestamp DEFAULT null
);

CREATE INDEX "chat_folder_chat_id_foreign" ON "chat_folder" ("chat_id");

CREATE INDEX "chat_folder_folder_id_foreign" ON "chat_folder" ("folder_id");

CREATE INDEX "content_plan_chat_content_plan_id_foreign" ON "content_plan_chat" ("content_plan_id");

CREATE INDEX "content_plan_chat_chat_id_foreign" ON "content_plan_chat" ("chat_id");

CREATE INDEX "content_plan_folder_content_plan_id_foreign" ON "content_plan_folder" ("content_plan_id");

CREATE INDEX "content_plan_folder_folder_id_foreign" ON "content_plan_folder" ("folder_id");

CREATE INDEX "content_post_post_id_foreign" ON "content_post" ("post_id");

CREATE INDEX "content_post_content_id_foreign" ON "content_post" ("content_id");

CREATE UNIQUE INDEX "failed_jobs_uuid_unique" ON "failed_jobs" ("uuid");

CREATE INDEX "jobs_queue_index" ON "jobs" ("queue");

CREATE INDEX "posts_chat_id_foreign" ON "posts" ("chat_id");

CREATE INDEX "posts_template_id_foreign" ON "posts" ("template_id");

CREATE INDEX "posts_folder_id_foreign" ON "posts" ("folder_id");

CREATE INDEX "posts_parent_id_foreign" ON "posts" ("parent_id");

CREATE INDEX "stories_content_id_foreign" ON "stories" ("content_id");

CREATE INDEX "stories_chat_id_foreign" ON "stories" ("chat_id");

CREATE INDEX "stories_template_id_foreign" ON "stories" ("template_id");

CREATE INDEX "stories_folder_id_foreign" ON "stories" ("folder_id");

CREATE INDEX "stories_parent_id_foreign" ON "stories" ("parent_id");

CREATE INDEX "video_notes_thumbnail_id_foreign" ON "video_notes" ("thumbnail_id");

CREATE INDEX "video_notes_content_id_foreign" ON "video_notes" ("content_id");

CREATE INDEX "video_notes_chat_id_foreign" ON "video_notes" ("chat_id");

CREATE INDEX "video_notes_folder_id_foreign" ON "video_notes" ("folder_id");

CREATE INDEX "video_notes_parent_id_foreign" ON "video_notes" ("parent_id");

ALTER TABLE "chat_folder" ADD CONSTRAINT "chat_folder_chat_id_foreign" FOREIGN KEY ("chat_id") REFERENCES "chats" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "chat_folder" ADD CONSTRAINT "chat_folder_folder_id_foreign" FOREIGN KEY ("folder_id") REFERENCES "folders" ("id") ON DELETE CASCADE;

ALTER TABLE "content_plan_chat" ADD CONSTRAINT "content_plan_chat_chat_id_foreign" FOREIGN KEY ("chat_id") REFERENCES "chats" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "content_plan_chat" ADD CONSTRAINT "content_plan_chat_content_plan_id_foreign" FOREIGN KEY ("content_plan_id") REFERENCES "content_plans" ("id") ON DELETE CASCADE;

ALTER TABLE "content_plan_folder" ADD CONSTRAINT "content_plan_folder_content_plan_id_foreign" FOREIGN KEY ("content_plan_id") REFERENCES "content_plans" ("id") ON DELETE CASCADE;

ALTER TABLE "content_plan_folder" ADD CONSTRAINT "content_plan_folder_folder_id_foreign" FOREIGN KEY ("folder_id") REFERENCES "folders" ("id") ON DELETE CASCADE;

ALTER TABLE "content_post" ADD CONSTRAINT "content_post_content_id_foreign" FOREIGN KEY ("content_id") REFERENCES "contents" ("id") ON DELETE CASCADE;

ALTER TABLE "content_post" ADD CONSTRAINT "content_post_post_id_foreign" FOREIGN KEY ("post_id") REFERENCES "posts" ("id") ON DELETE CASCADE;

ALTER TABLE "posts" ADD CONSTRAINT "posts_chat_id_foreign" FOREIGN KEY ("chat_id") REFERENCES "chats" ("id") ON UPDATE CASCADE;

ALTER TABLE "posts" ADD CONSTRAINT "posts_folder_id_foreign" FOREIGN KEY ("folder_id") REFERENCES "folders" ("id") ON DELETE CASCADE;

ALTER TABLE "posts" ADD CONSTRAINT "posts_parent_id_foreign" FOREIGN KEY ("parent_id") REFERENCES "posts" ("id") ON DELETE SET NULL;

ALTER TABLE "posts" ADD CONSTRAINT "posts_template_id_foreign" FOREIGN KEY ("template_id") REFERENCES "templates" ("id") ON DELETE SET NULL;

ALTER TABLE "stories" ADD CONSTRAINT "stories_chat_id_foreign" FOREIGN KEY ("chat_id") REFERENCES "chats" ("id") ON UPDATE CASCADE;

ALTER TABLE "stories" ADD CONSTRAINT "stories_content_id_foreign" FOREIGN KEY ("content_id") REFERENCES "contents" ("id") ON DELETE CASCADE;

ALTER TABLE "stories" ADD CONSTRAINT "stories_folder_id_foreign" FOREIGN KEY ("folder_id") REFERENCES "folders" ("id") ON DELETE CASCADE;

ALTER TABLE "stories" ADD CONSTRAINT "stories_parent_id_foreign" FOREIGN KEY ("parent_id") REFERENCES "stories" ("id") ON DELETE SET NULL;

ALTER TABLE "stories" ADD CONSTRAINT "stories_template_id_foreign" FOREIGN KEY ("template_id") REFERENCES "templates" ("id") ON DELETE SET NULL;

ALTER TABLE "video_notes" ADD CONSTRAINT "video_notes_chat_id_foreign" FOREIGN KEY ("chat_id") REFERENCES "chats" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "video_notes" ADD CONSTRAINT "video_notes_content_id_foreign" FOREIGN KEY ("content_id") REFERENCES "contents" ("id");

ALTER TABLE "video_notes" ADD CONSTRAINT "video_notes_folder_id_foreign" FOREIGN KEY ("folder_id") REFERENCES "folders" ("id") ON DELETE CASCADE;

ALTER TABLE "video_notes" ADD CONSTRAINT "video_notes_parent_id_foreign" FOREIGN KEY ("parent_id") REFERENCES "video_notes" ("id") ON DELETE SET NULL;

ALTER TABLE "video_notes" ADD CONSTRAINT "video_notes_thumbnail_id_foreign" FOREIGN KEY ("thumbnail_id") REFERENCES "contents" ("id") ON DELETE SET NULL;
