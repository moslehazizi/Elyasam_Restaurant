-- name: CreateDiscountOffer :one
INSERT INTO discount_offers(
    service_id
) VALUES (
    $1
) RETURNING *;

-- name: GetDiscountOffer :one
SELECT * FROM discount_offers
WHERE id = $1 LIMIT 1;

-- name: ListDiscountOffers :many
SELECT * FROM discount_offers
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: DeleteDiscountOffer :exec
DELETE FROM discount_offers
WHERE id = $1;