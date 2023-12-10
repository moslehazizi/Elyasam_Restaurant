-- name: CreateService :one
INSERT INTO services(
    service_image,
    service_title,
    service_category,
    recipe,
    price
) VALUES (
    $1, $2, $3, $4, $5
) RETURNING *;

-- name: GetService :one
SELECT * FROM services
WHERE id = $1 LIMIT 1;

-- name: ListServices :many
SELECT * FROM services
WHERE
    service_category = $1
ORDER BY id
LIMIT $2
OFFSET $3;