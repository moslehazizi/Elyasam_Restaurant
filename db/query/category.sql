-- name: CreateCategory :one
INSERT INTO categories(
    category_title
) VALUES (
    $1
) RETURNING *;

-- name: GetCategory :one
SELECT * FROM categories
WHERE id = $1 LIMIT 1;

-- name: ListCategories :many
SELECT * FROM categoreis
ORDER BY id
LIMIT $1
OFFSET $2;
