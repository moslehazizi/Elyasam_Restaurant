package db

import (
	"context"
	"testing"
	"time"

	"github.com/moslehazizi/Elyasam_Restaurant/util"
	"github.com/stretchr/testify/require"
)

func createRandomUser(t *testing.T) User {
	arg := CreateUserParams{
		PhoneNumber:    util.RandomName(),
		HashedPassword: util.RandomName(),
		FirstName:      util.RandomName(),
		LastName:       util.RandomName(),
		Email:          util.RandomEmail(),
	}

	user, err := testQueries.CreateUser(context.Background(), arg)

	require.NoError(t, err)
	require.NotEmpty(t, user)

	require.Equal(t, arg.PhoneNumber, user.PhoneNumber)
	require.Equal(t, arg.HashedPassword, user.HashedPassword)
	require.Equal(t, arg.FirstName, user.FirstName)
	require.Equal(t, arg.LastName, user.LastName)
	require.Equal(t, arg.Email, user.Email)
	require.NotZero(t, user.ID)
	require.NotZero(t, user.CreatedAt)

	return user
}

func TestCreateUser(t *testing.T) {
	createRandomUser(t)
}

func TestGetUser(t *testing.T) {
	user_1 := createRandomUser(t)

	user_2, err := testQueries.GetUser(context.Background(), user_1.ID)

	require.NoError(t, err)
	require.NotEmpty(t, user_2)

	require.NotZero(t, user_2.ID)
	require.Equal(t, user_1.ID, user_2.ID)
	require.Equal(t, user_1.PhoneNumber, user_2.PhoneNumber)
	require.Equal(t, user_1.HashedPassword, user_2.HashedPassword)
	require.Equal(t, user_1.FirstName, user_2.FirstName)
	require.Equal(t, user_1.LastName, user_2.LastName)
	require.Equal(t, user_1.Email, user_2.Email)

	require.WithinDuration(t, user_1.CreatedAt, user_2.CreatedAt, time.Second)
}
