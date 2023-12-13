-- name: CreateCategory :one
INSERT INTO categories(
    category_title,
    category_icon
) VALUES (
    $1, $2
) RETURNING *;

-- name: GetCategory :one
SELECT * FROM categories
WHERE id = $1 LIMIT 1;

-- name: ListCategories :many
SELECT * FROM categories
ORDER BY id
LIMIT $1
OFFSET $2;