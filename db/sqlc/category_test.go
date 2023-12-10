package db

import (
	"context"
	"testing"

	"github.com/moslehazizi/Elyasam_Restaurant/util"
	"github.com/stretchr/testify/require"
)

func createRandomCategory(t *testing.T) Category{
	category_title := util.RandomName()
	category, err := testQueries.CreateCategory(context.Background(), category_title)

	require.NoError(t, err)
	require.NotEmpty(t, category)

	require.Equal(t, category_title, category.CategoryTitle)
	require.NotZero(t, category.ID)

	return category
}

func TestCreateCategory(t *testing.T) {
	createRandomCategory(t)
}

func TestGetCategory(t *testing.T) {
	category_1 := createRandomCategory(t)
	category_2, err := testQueries.GetCategory(context.Background(), category_1.ID)

	require.NoError(t, err)
	require.NotEmpty(t, category_2)
	require.NotZero(t, category_2.ID)
	require.Equal(t, category_1.ID, category_2.ID)
	require.Equal(t, category_1.CategoryTitle, category_2.CategoryTitle)
}

func TestListCategories(t *testing.T) {
	for i:=0; i<10; i++ {
		createRandomCategory(t)
	}
	arg := ListCategoriesParams{
		Limit: 5,
		Offset: 5,
	}

	categories, err := testQueries.ListCategories(context.Background(), arg)

	require.NoError(t, err)
	require.Len(t, categories, 5)

	for _, category := range categories {
		require.NotEmpty(t, category)
	}
}