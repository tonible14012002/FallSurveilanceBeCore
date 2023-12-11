CREATE TABLE "accounts_myuser" ("password" varchar(128) NOT NULL, "last_login" timestamp with time zone NULL, "is_superuser" boolean NOT NULL, "username" varchar(150) NOT NULL UNIQUE, "first_name" varchar(150) NOT NULL, "last_name" varchar(150) NOT NULL, "email" varchar(254) NOT NULL, "is_staff" boolean NOT NULL, "is_active" boolean NOT NULL, "date_joined" timestamp with time zone NOT NULL, "pkid" bigint NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, "id" uuid NOT NULL UNIQUE, "dob" date NULL, "phone" varchar(128) NOT NULL);

-- Index for username
CREATE INDEX "accounts_myuser_username_d9cb398a_like" ON "accounts_myuser" ("username" varchar_pattern_ops);

-- Follow relationship
CREATE TABLE "accounts_myuser_followers" ("id" bigint NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, "from_myuser_id" bigint NOT NULL, "to_myuser_id" bigint NOT NULL);

-- Contraint for follow relationship 
ALTER TABLE "accounts_myuser_followers" ADD CONSTRAINT "accounts_myuser_follower_from_myuser_id_to_myuser_c8d374cc_uniq" UNIQUE ("from_myuser_id", "to_myuser_id");
ALTER TABLE "accounts_myuser_followers" ADD CONSTRAINT "accounts_myuser_foll_from_myuser_id_c2dc27a3_fk_accounts_" FOREIGN KEY ("from_myuser_id") REFERENCES "accounts_myuser" ("pkid") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "accounts_myuser_followers" ADD CONSTRAINT "accounts_myuser_foll_to_myuser_id_33f3f09f_fk_accounts_" FOREIGN KEY ("to_myuser_id") REFERENCES "accounts_myuser" ("pkid") DEFERRABLE INITIALLY DEFERRED;

-- Profile 1-1 myuser
CREATE TABLE "profile" ("pkid" bigint NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, "id" uuid NOT NULL UNIQUE, "created_at" timestamp with time zone NOT NULL, "updated_at" timestamp with time zone NOT NULL, "avatar" varchar(2000) NOT NULL, "gender" varchar(20) NOT NULL, "country" varchar(2) NOT NULL, "city" varchar(200) NOT NULL, "_nickname" varchar(100) NULL UNIQUE, "user_id" bigint NOT NULL UNIQUE);
ALTER TABLE "profile" ADD CONSTRAINT "profile_user_id_2aeb6f6b_fk_accounts_myuser_pkid" FOREIGN KEY ("user_id") REFERENCES "accounts_myuser" ("pkid") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "profile__nickname_b2c733ee_like" ON "profile" ("_nickname" varchar_pattern_ops);

-- for test user
ALTER TABLE "accounts_myuser" ADD COLUMN "is_test" boolean DEFAULT false NOT NULL;
ALTER TABLE "accounts_myuser" ALTER COLUMN "is_test" DROP DEFAULT;


-- Story post
CREATE TABLE "story" ("pkid" bigint NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, "id" uuid NOT NULL UNIQUE, "created_at" timestamp with time zone NOT NULL, "updated_at" timestamp with time zone NOT NULL, "media_url" varchar(200) NOT NULL, "live_time" smallint NOT NULL CHECK ("live_time" >= 0), "expired" boolean NOT NULL, "duration" smallint NOT NULL CHECK ("duration" >= 0), "media_type" varchar(20) NOT NULL, "privacy_mode" varchar(20) NOT NULL, "user_id" bigint NOT NULL);
ALTER TABLE "story" ADD CONSTRAINT "story_user_id_84537394_fk_accounts_myuser_pkid" FOREIGN KEY ("user_id") REFERENCES "accounts_myuser" ("pkid") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "story_user_id_84537394" ON "story" ("user_id");
ALTER TABLE "story" ALTER COLUMN "media_url" TYPE varchar(2000);
ALTER TABLE "story" DROP COLUMN "expired" CASCADE;
ALTER TABLE "story" ADD COLUMN "expire_date" timestamp with time zone NULL;
ALTER TABLE "story" ADD COLUMN "status" varchar(50) DEFAULT 'NEW' NOT NULL;
ALTER TABLE "story" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "story" ADD COLUMN "alt_text" varchar(200) DEFAULT '' NOT NULL;
ALTER TABLE "story" ALTER COLUMN "alt_text" DROP DEFAULT;
ALTER TABLE "story" ADD COLUMN "caption" varchar(200) DEFAULT '' NOT NULL;
ALTER TABLE "story" ALTER COLUMN "caption" DROP DEFAULT;
--

-- Exclude user relationship
CREATE TABLE "story_excluded_users" ("id" bigint NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, "userstory_id" bigint NOT NULL, "myuser_id" bigint NOT NULL);
ALTER TABLE "story_excluded_users" ADD CONSTRAINT "story_excluded_users_userstory_id_myuser_id_79b3a596_uniq" UNIQUE ("userstory_id", "myuser_id");
ALTER TABLE "story_excluded_users" ADD CONSTRAINT "story_excluded_users_userstory_id_aad3f96b_fk_story_pkid" FOREIGN KEY ("userstory_id") REFERENCES "story" ("pkid") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "story_excluded_users" ADD CONSTRAINT "story_excluded_users_myuser_id_9557aef3_fk_accounts_myuser_pkid" FOREIGN KEY ("myuser_id") REFERENCES "accounts_myuser" ("pkid") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "story_excluded_users_userstory_id_aad3f96b" ON "story_excluded_users" ("userstory_id");
CREATE INDEX "story_excluded_users_myuser_id_9557aef3" ON "story_excluded_users" ("myuser_id");

--
ALTER TABLE "story" ADD COLUMN "view_option" varchar DEFAULT 'EVERYONE' NOT NULL;
ALTER TABLE "story" ALTER COLUMN "view_option" DROP DEFAULT;


-- Story view
CREATE TABLE "story_viewer" ("pkid" bigint NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, "viewed_at" timestamp with time zone NOT NULL, "story_id" bigint NOT NULL, "user_id" bigint NOT NULL);
ALTER TABLE "story_viewer" ADD CONSTRAINT "story_viewer_user_id_story_id_dacd070c_uniq" UNIQUE ("user_id", "story_id");
ALTER TABLE "story_viewer" ADD CONSTRAINT "story_viewer_story_id_c9e41837_fk_story_pkid" FOREIGN KEY ("story_id") REFERENCES "story" ("pkid") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "story_viewer" ADD CONSTRAINT "story_viewer_user_id_c638e34b_fk_accounts_myuser_pkid" FOREIGN KEY ("user_id") REFERENCES "accounts_myuser" ("pkid") DEFERRABLE INITIALLY DEFERRED;

CREATE INDEX "story_viewer_story_id_c9e41837" ON "story_viewer" ("story_id");
CREATE INDEX "story_viewer_user_id_c638e34b" ON "story_viewer" ("user_id");