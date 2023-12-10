package db

import (
	"context"
	"testing"
	"time"

	"github.com/moslehazizi/Elyasam_Restaurant/util"
	"github.com/stretchr/testify/require"
)

func createRandomComment(t *testing.T, service Service) Comment {
	arg := CreateCommentParams{
		CommentContent: util.RandomName(),
		ServiceID: service.ID,
	}
	comment, err := testQueries.CreateComment(context.Background(), arg)

	require.NoError(t, err)
	require.NotEmpty(t, comment)
	require.Equal(t, arg.CommentContent, comment.CommentContent)
	require.Equal(t, arg.ServiceID, comment.ServiceID)
	require.NotZero(t, comment.ID)

	return comment
}

func TestCreateComment(t *testing.T) {
	category := createRandomCategory(t)
	service := createRandomService(t, category)
	createRandomComment(t, service)
}

func TestGetComment(t *testing.T) {
	category := createRandomCategory(t)
	service := createRandomService(t, category)
	comment_1 := createRandomComment(t, service)
	comment_2, err := testQueries.GetComment(context.Background(), comment_1.ID)

	require.NoError(t, err)
	require.NotEmpty(t, comment_2)
	require.NotZero(t, comment_2.ID)
	require.Equal(t, comment_1.ID, comment_2.ID)
	require.Equal(t, comment_1.CommentContent, comment_2.CommentContent)
	require.Equal(t, comment_1.ServiceID, comment_2.ServiceID)
	require.WithinDuration(t, comment_1.CreatedAt, comment_2.CreatedAt, time.Second)
}

func TestListComment(t *testing.T) {
	category := createRandomCategory(t)
	service := createRandomService(t, category)
	for i:=0; i<10; i++ {
		createRandomComment(t, service)
	}
	arg := ListCommentsParams{
		ServiceID: service.ID,
		Limit: 5,
		Offset: 5,
	}
	comments, err := testQueries.ListComments(context.Background(), arg)

	require.NoError(t, err)
	require.Len(t, comments, 5)

	for _, comment := range comments {
		require.Equal(t, arg.ServiceID, comment.ServiceID)
		require.NotEmpty(t, comment)
	}
}