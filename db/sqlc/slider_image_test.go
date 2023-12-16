package db

import (
	"context"
	"testing"

	"github.com/moslehazizi/Elyasam_Restaurant/util"
	"github.com/stretchr/testify/require"
)

func createRandomSliderImage(t *testing.T) SliderImage {
	image_path := util.RandomName()
	slider_image, err := testQueries.CreateSliderImage(context.Background(), image_path)

	require.NoError(t, err)
	require.NotEmpty(t, slider_image)

	require.NotZero(t, slider_image.ID)
	require.Equal(t, image_path, slider_image.ImagePath)

	return slider_image
}

func TestCreateSliderImage(t *testing.T) {
	createRandomSliderImage(t)
}

func TestGetSliderImage(t *testing.T) {
	slider_image_1 := createRandomSliderImage(t)
	slider_image_2, err := testQueries.GetSliderImage(context.Background(), slider_image_1.ID)

	require.NoError(t, err)
	require.NotEmpty(t, slider_image_2)

	require.NotZero(t, slider_image_2.ID)
	require.Equal(t, slider_image_1.ID, slider_image_2.ID)
	require.Equal(t, slider_image_1.ImagePath, slider_image_2.ImagePath)
}

func TestListSliderImage(t *testing.T) {
	for i:=0; i<10; i++ {
		createRandomSliderImage(t)
	}

	arg := ListSliderImagesParams {
		Limit: 5,
		Offset: 5,
	}

	slider_images, err := testQueries.ListSliderImages(context.Background(), arg)

	require.NoError(t, err)
	require.Len(t, slider_images, 5)

	for _, slider_image := range slider_images {
		require.NotEmpty(t, slider_image)
	}

}