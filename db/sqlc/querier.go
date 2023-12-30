// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.24.0

package db

import (
	"context"
)

type Querier interface {
	CreateCategory(ctx context.Context, arg CreateCategoryParams) (Category, error)
	CreateComment(ctx context.Context, arg CreateCommentParams) (Comment, error)
	CreateDiscountOffer(ctx context.Context, serviceID int64) (DiscountOffer, error)
	CreateService(ctx context.Context, arg CreateServiceParams) (Service, error)
	CreateSliderImage(ctx context.Context, imagePath string) (SliderImage, error)
	CreateUser(ctx context.Context, arg CreateUserParams) (User, error)
	DeleteDiscountOffer(ctx context.Context, id int64) error
	GetCategory(ctx context.Context, id int64) (Category, error)
	GetComment(ctx context.Context, id int64) (Comment, error)
	GetDiscountOffer(ctx context.Context, id int64) (DiscountOffer, error)
	GetService(ctx context.Context, id int64) (Service, error)
	GetSliderImage(ctx context.Context, id int64) (SliderImage, error)
	GetUser(ctx context.Context, id int64) (User, error)
	ListCategories(ctx context.Context, arg ListCategoriesParams) ([]Category, error)
	ListComments(ctx context.Context, arg ListCommentsParams) ([]Comment, error)
	ListDiscountOffers(ctx context.Context, arg ListDiscountOffersParams) ([]DiscountOffer, error)
	ListServices(ctx context.Context, arg ListServicesParams) ([]Service, error)
	ListServicesById(ctx context.Context, arg ListServicesByIdParams) ([]Service, error)
	ListSliderImages(ctx context.Context, arg ListSliderImagesParams) ([]SliderImage, error)
	UpdateService(ctx context.Context, arg UpdateServiceParams) (Service, error)
}

var _ Querier = (*Queries)(nil)
