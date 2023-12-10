-- name: CreateComment :one
INSERT INTO comments(
    comment_content,
    service_id
) VALUES (
    $1, $2
) RETURNING *;

-- name: GetComment :one
SELECT * FROM comments
WHERE id = $1 LIMIT 1;

-- name: ListComments :many
SELECT * FROM comments
WHERE 
    service_id = $1
ORDER BY id
LIMIT $2
OFFSET $3;