CREATE TABLE "categories" (
  "id" BIGSERIAL PRIMARY KEY,
  "category_title" varchar NOT NULL
);

CREATE TABLE "services" (
  "id" BIGSERIAL PRIMARY KEY,
  "service_image" bytea NOT NULL,
  "service_title" varchar NOT NULL,
  "service_category" bigint NOT NULL,
  "star" int NOT NULL DEFAULT 0,
  "recipe" text NOT NULL,
  "price" bigint NOT NULL
);

CREATE TABLE "comments" (
  "id" bigint PRIMARY KEY,
  "comment_content" text NOT NULL,
  "service_id" bigint NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (now())
);

CREATE INDEX ON "categories" ("category_title");

CREATE INDEX ON "services" ("service_category");

CREATE INDEX ON "comments" ("id");

ALTER TABLE "services" ADD FOREIGN KEY ("service_category") REFERENCES "categories" ("id");

ALTER TABLE "comments" ADD FOREIGN KEY ("service_id") REFERENCES "services" ("id");
