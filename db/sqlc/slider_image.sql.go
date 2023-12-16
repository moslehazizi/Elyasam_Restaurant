// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.24.0
// source: slider_image.sql

package db

import (
	"context"
)

const createSliderImage = `-- name: CreateSliderImage :one
INSERT INTO slider_images(
    image_path
) VALUES (
    $1
) RETURNING id, image_path
`

func (q *Queries) CreateSliderImage(ctx context.Context, imagePath string) (SliderImage, error) {
	row := q.db.QueryRowContext(ctx, createSliderImage, imagePath)
	var i SliderImage
	err := row.Scan(&i.ID, &i.ImagePath)
	return i, err
}

const getSliderImage = `-- name: GetSliderImage :one
SELECT id, image_path FROM slider_images
WHERE id = $1 LIMIT 1
`

func (q *Queries) GetSliderImage(ctx context.Context, id int64) (SliderImage, error) {
	row := q.db.QueryRowContext(ctx, getSliderImage, id)
	var i SliderImage
	err := row.Scan(&i.ID, &i.ImagePath)
	return i, err
}

const listSliderImages = `-- name: ListSliderImages :many
SELECT id, image_path FROM slider_images
ORDER BY id
LIMIT $1
OFFSET $2
`

type ListSliderImagesParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) ListSliderImages(ctx context.Context, arg ListSliderImagesParams) ([]SliderImage, error) {
	rows, err := q.db.QueryContext(ctx, listSliderImages, arg.Limit, arg.Offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []SliderImage{}
	for rows.Next() {
		var i SliderImage
		if err := rows.Scan(&i.ID, &i.ImagePath); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}
