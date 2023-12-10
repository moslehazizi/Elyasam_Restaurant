package db

import (
	"context"
	"testing"

	"github.com/moslehazizi/Elyasam_Restaurant/util"
	"github.com/stretchr/testify/require"
)

func createRandomService(t *testing.T, category Category) Service {
	arg := CreateServiceParams{
		ServiceImage:    util.RandomBytes(10),
		ServiceTitle:    util.RandomName(),
		ServiceCategory: category.ID,
		Recipe:          util.RandomName(),
		Price:           util.RandomInt(100000, 200000),
	}
	service, err := testQueries.CreateService(context.Background(), arg)

	require.NoError(t, err)
	require.NotEmpty(t, service)
	require.Equal(t, arg.ServiceImage, service.ServiceImage)
	require.Equal(t, arg.ServiceTitle, service.ServiceTitle)
	require.Equal(t, arg.Recipe, service.Recipe)
	require.Equal(t, arg.Price, service.Price)
	require.NotZero(t, service.ID)

	return service
}

func TestCreateServise(t *testing.T) {
	category := createRandomCategory(t)
	createRandomService(t, category)
}

func TestGetService(t *testing.T) {
	category := createRandomCategory(t)
	service_1 := createRandomService(t, category)
	service_2, err := testQueries.GetService(context.Background(), service_1.ID)

	require.NoError(t, err)
	require.NotEmpty(t, service_2)
	require.NotZero(t, service_2)
	require.Equal(t, service_1.ID, service_2.ID)
	require.Equal(t, service_1.ServiceImage, service_2.ServiceImage)
	require.Equal(t, service_1.ServiceTitle, service_2.ServiceTitle)
	require.Equal(t, service_1.Recipe, service_2.Recipe)
	require.Equal(t, service_1.Price, service_2.Price)
}

func TestListServices(t *testing.T) {
	category := createRandomCategory(t)
	for i := 0; i < 10; i++ {
		createRandomService(t, category)
	}
	arg := ListServicesParams{
		ServiceCategory: category.ID,
		Limit:           5,
		Offset:          5,
	}
	services, err := testQueries.ListServices(context.Background(), arg)

	require.NoError(t, err)
	require.Len(t, services, 5)

	for _, service := range services {
		require.NotEmpty(t, service)
		require.Equal(t, category.ID, service.ServiceCategory)
	}

}
