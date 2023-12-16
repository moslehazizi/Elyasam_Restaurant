package api

import (
	"net/http"

	"github.com/gin-gonic/gin"
	db "github.com/moslehazizi/Elyasam_Restaurant/db/sqlc"
)

func (server *Server) getLanding(c *gin.Context) {

	arg := db.ListCategoriesParams{
		Limit:  19,
		Offset: 0,
	}
	categories, err_1 := server.store.ListCategories(c, arg)
	if err_1 != nil {
		c.JSON(http.StatusInternalServerError, errorResponse(err_1))
		return
	}
	c.JSON(http.StatusOK, categories)

	for _, category := range categories {
		arg := db.ListServicesParams{
			ServiceCategory: category.ID,
			Limit:           20,
			Offset:          0,
		}
		var err error
		services_for_category, err := server.store.ListServices(c, arg)
		if err != nil {
			c.JSON(http.StatusInternalServerError, errorResponse(err))
			return
		}
		c.JSON(http.StatusOK, services_for_category)
	}
	c.JSON(http.StatusOK, externalAPIResponseJson)
}
