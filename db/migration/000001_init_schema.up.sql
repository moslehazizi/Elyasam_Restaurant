CREATE TABLE "users" (
  "id" bigserial PRIMARY KEY,
  "phone_number" varchar UNIQUE NOT NULL,
  "hashed_password" varchar NOT NULL,
  "full_name" varchar NOT NULL,
  "email" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "categories" (
  "id" BIGSERIAL PRIMARY KEY,
  "category_title" varchar NOT NULL,
  "category_icon" varchar NOT NULL
);

CREATE TABLE "services" (
  "id" BIGSERIAL PRIMARY KEY,
  "service_image" varchar NOT NULL,
  "service_title" varchar NOT NULL,
  "service_category" bigint NOT NULL,
  "star" int NOT NULL DEFAULT 0,
  "recipe" text NOT NULL,
  "price" bigint NOT NULL
);

CREATE TABLE "comments" (
  "id" BIGSERIAL PRIMARY KEY,
  "comment_content" text NOT NULL,
  "service_id" bigint NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (now())
);

CREATE TABLE "discount_offers" (
  "id" BIGSERIAL PRIMARY KEY,
  "service_id" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "expired_at" timestamptz NOT NULL DEFAULT (now()+INTERVAL'8 hours')
);

CREATE TABLE "slider_images" (
  "id" BIGSERIAL PRIMARY KEY,
  "image_path" varchar NOT NULL
);

CREATE INDEX ON "categories" ("category_title");

CREATE INDEX ON "services" ("service_category");

CREATE INDEX ON "comments" ("id");

CREATE INDEX ON "discount_offers" ("id");

CREATE INDEX ON "slider_images" ("id");

ALTER TABLE "services" ADD FOREIGN KEY ("service_category") REFERENCES "categories" ("id");

ALTER TABLE "comments" ADD FOREIGN KEY ("service_id") REFERENCES "services" ("id");

ALTER TABLE "discount_offers" ADD FOREIGN KEY ("service_id") REFERENCES "services" ("id");
