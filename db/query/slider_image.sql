-- name: CreateSliderImage :one
INSERT INTO slider_images(
    image_path
) VALUES (
    $1
) RETURNING *;

-- name: GetSliderImage :one
SELECT * FROM slider_images
WHERE id = $1 LIMIT 1;

-- name: ListSliderImages :many
SELECT * FROM slider_images
ORDER BY id
LIMIT $1
OFFSET $2;