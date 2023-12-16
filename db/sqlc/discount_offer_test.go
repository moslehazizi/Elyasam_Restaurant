package db

import (
	"context"
	"testing"

	"github.com/stretchr/testify/require"
)

func createRandomDiscountOffer(t *testing.T, service Service) DiscountOffer {
	ServiceID := service.ID
	discount_offer, err := testQueries.CreateDiscountOffer(context.Background(), ServiceID)

	require.NoError(t, err)
	require.NotEmpty(t, discount_offer)

	require.Equal(t, ServiceID, discount_offer.ServiceID)
	require.NotZero(t, discount_offer.ID)

	return discount_offer
}

func TestCreateDiscountOffer(t *testing.T) {
	category := createRandomCategory(t)
	service := createRandomService(t, category)
	createRandomDiscountOffer(t, service)
}

func TestGetDiscountOffer(t *testing.T) {
	category := createRandomCategory(t)
	service := createRandomService(t, category)
	discount_offer_1 := createRandomDiscountOffer(t, service)
	discount_offer_2, err := testQueries.GetDiscountOffer(context.Background(), discount_offer_1.ID)

	require.NoError(t, err)
	require.NotEmpty(t, discount_offer_2)
	require.NotZero(t, discount_offer_2.ID)

	require.Equal(t, discount_offer_1.ID, discount_offer_2.ID)
	require.Equal(t, discount_offer_1.ServiceID, discount_offer_2.ServiceID)
	require.Equal(t, discount_offer_1.CreatedAt, discount_offer_2.CreatedAt)
	require.Equal(t, discount_offer_1.ExpiredAt, discount_offer_2.ExpiredAt)
}

func TestListDiscountOffer(t *testing.T) {
	category := createRandomCategory(t)
	service := createRandomService(t, category)

	for i:=0; i<10; i++ {
		createRandomDiscountOffer(t, service)
	}

	arg := ListDiscountOffersParams{
		Limit: 5,
		Offset: 5,
	}

	discount_offers, err := testQueries.ListDiscountOffers(context.Background(), arg)

	require.NoError(t, err)
	require.Len(t, discount_offers, 5)

	for _, discount_offer := range discount_offers {
		require.NotEmpty(t, discount_offer)
	}
}