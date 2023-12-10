CREATE TABLE "categories" (
  "id" BIGSERIAL PRIMARY KEY,
  "category_title" varchar NOT NULL
);

CREATE TABLE "foods" (
  "id" BIGSERIAL PRIMARY KEY,
  "food_image" bytea NOT NULL,
  "food_title" varchar NOT NULL,
  "food_category" bigint NOT NULL,
  "star" int NOT NULL DEFAULT 0,
  "recipe" text NOT NULL,
  "price" bigint NOT NULL
);

CREATE TABLE "comments" (
  "id" bigint PRIMARY KEY,
  "comment_content" text NOT NULL,
  "food" bigint NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (now())
);

CREATE INDEX ON "categories" ("category_title");

CREATE INDEX ON "foods" ("food_category");

CREATE INDEX ON "comments" ("id");

ALTER TABLE "foods" ADD FOREIGN KEY ("food_category") REFERENCES "categories" ("id");

ALTER TABLE "comments" ADD FOREIGN KEY ("food") REFERENCES "foods" ("id");
