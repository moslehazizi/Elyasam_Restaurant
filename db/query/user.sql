-- name: CreateUser :one
INSERT INTO users(
    phone_number,
    hashed_password,
    full_name,
    email
) VALUES (
    $1, $2, $3, $4
) RETURNING *;

-- name: GetUser :one
SELECT * FROM users
WHERE phone_number = $1
LIMIT 1;