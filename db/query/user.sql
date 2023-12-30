-- name: CreateUser :one
INSERT INTO users(
    phone_number,
    hashed_password,
    first_name,
    last_name,
    email
) VALUES (
    $1, $2, $3, $4, $5
) RETURNING *;

-- name: GetUser :one
SELECT * FROM users
WHERE phone_number = $1 AND
      hashed_password = $2
LIMIT 1;